# Test web app that returns the name of the host/pod/container servicing req
# Linux x64

# start build image by first grabbing the node: current alpine image
# which is actually a special container image with node tools preinstalled
# we are going to use it as the foundation, or the bottom layer of our image to build 
# everything on top of it.
# this is not a full linux distro with kernel and everything, it's a more like 
# a set of file systems constructs like folders and device files. 
# every container, when it is running uses the kernel of the host it's running on
# so the container itself doesn't come packaged with its own kernel.

FROM node:current-alpine


# metadata telling who to hustle about the app
LABEL org.opencontainers.image.title="Hello Docker Learners!" \
      org.opencontainers.image.description="Web server showing host that responded" \
      org.opencontainers.image.authors="@nigelpoulton"


# Create directory in container image for app code
RUN mkdir -p /usr/src/app

# Copy app code (.) to /usr/src/app in container image
# we are going to run the container in the location where the app code resides.
COPY . /usr/src/app

# Set working directory context
WORKDIR /usr/src/app

# Install dependencies from packages.json
RUN npm install

# Command for container to execute
# this is the command to run each time the container get started from the image
# it's basically calling node with the name of the main app file. 

ENTRYPOINT [ "node", "app.js" ]
