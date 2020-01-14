FROM golang:1.13 AS builder
WORKDIR /home/
COPY . app_src
RUN cd app_src \
	&& make

FROM alpine:latest
#RUN apk --no-cache add ca-certificates
WORKDIR /home/
COPY --from=builder /home/app_src/app /home/
EXPOSE 8080
CMD ["./app"]