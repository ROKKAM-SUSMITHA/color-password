# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables
ENV NODE_VERSION=12
ENV MONGO_VERSION=5.0

# Prevent tzdata from prompting for input during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update and install prerequisites
RUN apt-get update && \
    apt-get install -y wget curl gnupg software-properties-common lsb-release && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js 12
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt-get update && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install MongoDB
RUN wget -qO - https://www.mongodb.org/static/pgp/server-${MONGO_VERSION}.asc | apt-key add - && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/${MONGO_VERSION} multiverse" | tee /etc/apt/sources.list.d/mongodb-org-${MONGO_VERSION}.list && \
    apt-get update && \
    apt-get install -y mongodb-org && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create the MongoDB data directory
RUN mkdir -p /data/db

# Expose the MongoDB port
EXPOSE 27017

# Expose a port for your Node.js application (if needed)
EXPOSE 3000

# Command to start both MongoDB and your Node.js application
CMD mongod --fork --logpath /var/log/mongod.log

