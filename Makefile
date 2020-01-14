CGO_ENABLED=0
GOOS=linux
GOPROXY='https://goproxy.cn'

app:
	gitCommitVersion='$(shell git rev-parse HEAD)' \
	&& echo "git commit: $${gitCommitVersion}" \
	&& go build -ldflags "-s -w -X 'main.gitCommitVersion=$${gitCommitVersion}'" -a -v -o $@ . \
	&& chmod +x ./$@