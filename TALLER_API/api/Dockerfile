# FROM golang:1.22 AS builder
# WORKDIR /app
# COPY go.mod go.sum ./

# RUN go mod download
# COPY . .
# RUN go build -o api

# FROM alpine:latest
# WORKDIR /root/
# COPY --from=builder /app/api .

# EXPOSE 8088
# CMD ["./api"]

FROM golang:1.22

WORKDIR /usr/app/src
COPY . ./
RUN go mod tidy
# NOTE name need to be Dockerfile
#FROM python:3.9

#RUN pip install mysql-connector-python

#WORKDIR /usr/app/src

#COPY hello_world.py ./