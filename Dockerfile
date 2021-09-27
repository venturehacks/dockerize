FROM golang:1.17.1-alpine3.14 AS binary
RUN apk -U add openssl git
WORKDIR /build
ENV CGO_ENABLED 0
ADD ./go.* ./
RUN go mod download
ADD . ./
RUN go install

FROM scratch
MAINTAINER Jason Wilder <mail@jasonwilder.com>
ENTRYPOINT ["/dockerize"]
CMD ["--help"]
COPY --from=binary /go/bin/dockerize /dockerize
