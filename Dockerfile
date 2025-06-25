# Stage 1: Build
FROM golang:1.21 AS builder
WORKDIR /app
COPY go.mod .
COPY *.go .
RUN go build -o server

# Stage 2: Run
FROM gcr.io/distroless/base-debian11
WORKDIR /app
COPY --from=builder /app/server .
EXPOSE 8080
ENTRYPOINT ["/app/server"]