FROM golang:1.13.7-alpine3.11 AS binary
RUN apk -U add openssl git
WORKDIR /build
ENV CGO_ENABLED 0
ADD ./go.* ./
RUN go mod download
ADD . ./
RUN go install

FROM alpine:3.11
MAINTAINER Jason Wilder <mail@jasonwilder.com>

COPY --from=binary /go/bin/dockerize /usr/local/bin

ENTRYPOINT ["dockerize"]
CMD ["--help"]
