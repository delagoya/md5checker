# MD5 Checker

A small Docker container that downloads a file from a source URL (`SOURCE_FILE_URL`), calculates the MD5 checksum, and compares that to the given MD5 checksum (`MD5SUM`). If the checksums match, it will make a `GET` HTTP request the given `SUCCESS_CALLBACK_URL`, and if not, to the `ERROR_CALLBACK_URL`.

If the optional `KEEP_FILE` argument is given, the file will not be deleted. In all cases, it is assumed that files are written to the `/tmp` directory of the container. So if (for whatever reason) you want to keep the file around on the host system, then you should use a [bind mount](https://docs.docker.com/storage/bind-mounts/) to the container's `/tmp` dir like so:

```bash
docker run -v `pwd`:/tmp --rm md5checker https://example.com 09b9c392dc1f6e914cea287cb6be34b0 http://example.com http://example.com 1
# Output:
# MD5 /tmp/cdac74e0-8f90-42b3-a11a-c121b7cd288d sum SUCCESS
```

You can check the MD5 on your system using the correct command. The following is for OS X

```bash
md5 "cdac74e0-8f90-42b3-a11a-c121b7cd288d"
# Output:
# MD5 (cdac74e0-8f90-42b3-a11a-c121b7cd288d) = 09b9c392dc1f6e914cea287cb6be34b0
```

## USAGE

```
A utility to download and calculate and check the MD5Sum of a file.


  * File is downloaded to a random file name.
  * MD5 sum is calculated.
  * If checksums match, will send a GET request to the SUCCESS_CALLBACK_URL
  * If checksums do not match, will send GET to ERROR_CALLBACK_URL
  * If KEEP_FILE arg is set, file will not be deleted from disk


docker run md5checker <SOURCE_FILE_URL> <MD5SUM> <SUCCESS_CALLBACK_URL> <ERROR_CALLBACK_URL> [KEEP_FILE]
```

## BUILD

If you want to modify and build this and push into your own registry, then set the REGISTRY environment variable when running make

```bash
# pushing to your Docker Hub account
make REGISTRY="DOCKERHUB_USERNAME"
# pushing to ECR (assuming you are logged in and a `md5checker` registry is created)
make REGISTRY=12341234124.dkr.ecr.us-east-1.amazonaws.com
```
