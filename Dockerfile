# Use the official nginx image as base
FROM nginx:alpine


# Remove default index and copy our static site
RUN rm -rf /usr/share/nginx/html/*
COPY index.html /usr/share/nginx/html/index.html


# Expose port 80 (informational for users of the image)
EXPOSE 80


# Nginx image already sets a default CMD to run nginx in the foreground