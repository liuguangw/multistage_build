@echo off
SET CGO_ENABLED=0
SET GOARCH=amd64
SET GO111MODULE=on
SET GOPROXY=https://goproxy.cn
SET GOOS=windows
SET DIST_FILE_NAME=app.exe
SET gitCommitVersion=""
FOR /F %%a IN ('git rev-parse HEAD') DO SET "gitCommitVersion=%%a"

echo git commit: %gitCommitVersion%

go build -ldflags "-s -w -X 'main.gitCommitVersion=%gitCommitVersion%'" -o %DIST_FILE_NAME%