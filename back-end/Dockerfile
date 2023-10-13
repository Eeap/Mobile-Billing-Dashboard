FROM golang:1.19-alpine AS builder

LABEL maintainer="Terraform canvas <sumink0903@gmail.com>"

# Move to working directory (/build).
WORKDIR /build

# Copy and download dependency using go mod.
COPY go.mod go.sum ./
RUN go mod download
RUN wget https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_amd64.zip
RUN unzip terraform_1.5.2_linux_amd64.zip && rm terraform_1.5.2_linux_amd64.zip
RUN mv terraform /usr/bin/terraform
RUN apk add git

# Copy the code into the container.
COPY . .

# Set necessary environment variables needed for our image and build the API server.
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
RUN go build -ldflags="-s -w" -o apiserver .

#FROM scratch
#
## Copy binary and config files from /build to root folder of scratch container.
#COPY --from=builder ["/build/apiserver", "/"]

# Command to run when starting the container.
ENTRYPOINT ["/build/apiserver"]
