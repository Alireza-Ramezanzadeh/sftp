# Use the Alpine Linux base image
FROM alpine:latest

# Install OpenSSH and create necessary directories
RUN apk --no-cache add openssh && \
    delgroup www-data && \
    mkdir -p /var/www/html && \
    addgroup -g 33 www-data && \
    adduser -u 33 -G www-data -h /var/www/html -D www-data && \
    chown -R www-data:www-data /var/www/html && \
    chown root. /var/www/html && \
    chown root. /var/www

# Copy the custom entry point script
COPY entrypoint.sh /entrypoint.sh

# Generate SSH host keys
RUN ssh-keygen -A

# Set the entry point script as executable
RUN chmod +x /entrypoint.sh

# Expose the SSH port
EXPOSE 22

# Switch to the root user to run entrypoint
USER root

WORKDIR /var/www/html

# Set the entry point
ENTRYPOINT ["/entrypoint.sh"]