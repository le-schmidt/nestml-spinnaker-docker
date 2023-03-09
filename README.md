# Content
This repository contains the description files to make a Docker-Image as well as an Apptainer-Image.

## Apptainer
To build the Apptainer image just run:
    
    apptainer build <path/to/target/image.sif> ./apptainer.def

Where the image is copied into the target directory and "apptainer.def" is the definition file for the image

Start the container with shell by calling

    apptainer shell /path/to/image.sif

or just run the container with

    apptainer run /path/to/image.sif

or execute a command in container with

    apptainer exec /path/to/image.sif command

## Docker
To build the Docker image just run:

    docker build /path/to/Dockerfile

Start the container with active shell with

    docker run -it <image_id> /bin/bash