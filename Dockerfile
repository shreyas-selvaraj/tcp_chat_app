FROM golang as builder

ENV GO111MODULE=on

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

# final stage
FROM scratch
COPY --from=builder /app/tcp_chat /app/
EXPOSE 8080
ENTRYPOINT ["/app/tcp_chat"]