# Step 1: Use the official Apache HTTP Server image as base
FROM httpd:2.4

# Step 2: Set the working directory inside the container
WORKDIR /usr/local/apache2/htdocs/

# Step 3: Copy your website files (index.html and others if needed)
COPY index.html /usr/local/apache2/htdocs/

# (Optional) – If you have a full website folder, use:
# COPY ./website/ /usr/local/apache2/htdocs/

# Step 4: Expose port 80 to the outside world
EXPOSE 80

# Step 5: Start Apache (default command from httpd image)
CMD ["httpd-foreground"]
----
----

*Create work flow add ci and cd file 
---ci---
name: CI - Build & Push Docker Image

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and push image (sha + latest)
        env:
          IMAGE: ${{ secrets.DOCKER_USERNAME }}/myapp
          TAG: ${{ github.sha }}
        run: |
          docker build -t $IMAGE:latest -t $IMAGE:$TAG .
          docker push $IMAGE:$TAG
          docker push $IMAGE:latest
