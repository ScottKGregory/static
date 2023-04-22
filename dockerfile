FROM golang:1.20.3 as build-env
WORKDIR /go/src/static
COPY . .
RUN go get -d -v ./...
RUN CGO_ENABLED=0 go build -o /go/bin/static

FROM scratch
COPY --from=build-env /go/bin/static /

EXPOSE 8080
CMD ["/static"]
