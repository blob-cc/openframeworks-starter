docker build -t of-project .
docker run --rm -v $(pwd):/app of-project