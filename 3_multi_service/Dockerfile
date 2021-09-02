FROM golang:1.17.0-alpine

WORKDIR /app
COPY . .

ENV CGO_ENABLED=0
RUN go build -v -o app ./app.go

FROM scratch
COPY --from=0 /app/app /bin/app

ENTRYPOINT ["/bin/app"]
