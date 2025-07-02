# Use the Alpine Linux base image
FROM alpine:latest

# Install OpenSSH and create necessary directories
RUN apk --no-cache add openssh && \
   delgroup www-data && \
   mkdir -p /var/www/html && \
   addgroup -g 33 www-data && \
   adduser -u 33 -G www-data -h /var/www/html -D www-data && \
   chown root:root /var/www && \
    chown root:root /var/www/html && \
    mkdir -p /var/www/html/data && \
    chown www-data:www-data /var/www/html/data

# Copy the custom entry point script
COPY perm.sh /perm.sh

# Generate SSH host keys
RUN ssh-keygen -A

# Set the entry point script as executable
RUN chmod +x /perm.sh

# Expose the SSH port
EXPOSE 22

# Switch to the root user to run entrypoint
USER root

WORKDIR /var/www/html

# Set the entry point
ENTRYPOINT ["/perm.sh"]
