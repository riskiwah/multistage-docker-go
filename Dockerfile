FROM golang:1-alpine3.8 as build
WORKDIR /go/src/simpleapi
ADD . /go/src/simpleapi
#COPY handlers /go/src/simpleapi
RUN apk add git \
    && apk add g++ \
    && go get github.com/labstack/echo \
    && go get github.com/mattn/go-sqlite3 \
    && CGO_ENABLED=1 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:3.8
EXPOSE 8000
WORKDIR /bin
COPY --from=build /go/src/simpleapi .
CMD  ["./app"]