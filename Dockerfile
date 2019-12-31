FROM golang:1.13 AS builder
WORKDIR /home/
COPY . app_src
ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOPROXY=https://goproxy.cn
RUN cd app_src \
    && go generate . \
    && go build -a -v -o app . \
    && chmod +x ./app

FROM alpine:latest
#RUN apk --no-cache add ca-certificates
WORKDIR /home/
COPY --from=builder /home/app_src/app /home/
EXPOSE 8080
CMD ["./app"]