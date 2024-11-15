# Imagen a usar golang Alpine 
FROM golang:1.22-alpine3.19 AS builder

# Set the working directory
WORKDIR /app

# Copy the Go source code
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the application
RUN go build -o bin .

# Use a smaller runtime image
FROM alpine:3.19

# Set the working directory
WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=builder /app/bin .

# Expose the port your API listens on
EXPOSE 8088

# Start the application
CMD ["./bin"]