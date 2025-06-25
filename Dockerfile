# Stage 1: Build
FROM golang:1.21 AS builder
WORKDIR /app
COPY /app/go.mod ./
COPY /app/*.go ./
RUN go build -o server

# Stage 2: Run
FROM gcr.io/distroless/base-debian11
WORKDIR /app
COPY --from=builder /app/server .
EXPOSE 8080
ENTRYPOINT ["/app/server"]