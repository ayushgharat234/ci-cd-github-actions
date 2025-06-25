# Stage 1: Build
FROM golang:1.21 AS builder

WORKDIR /app

COPY go.mod . 
RUN go mod download

COPY . . 

RUN CGO_ENABLED=0 go build -ldflags "-s -w" -o server .

# Stage 2: Run
FROM gcr.io/distroless/static

WORKDIR /app

COPY --from=builder /app/server .

EXPOSE 8080

CMD ["/app/server"]