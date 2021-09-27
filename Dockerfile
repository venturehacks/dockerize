FROM golang:1.17.1-alpine3.14 AS binary
RUN apk -U add openssl git
WORKDIR /build
ENV CGO_ENABLED 0
ADD ./go.* ./
RUN go mod download
ADD . ./
RUN go install

FROM alpine:3.14
MAINTAINER Jason Wilder <mail@jasonwilder.com>

COPY --from=binary /go/bin/dockerize /usr/local/bin

ENTRYPOINT ["dockerize"]
CMD ["--help"]
