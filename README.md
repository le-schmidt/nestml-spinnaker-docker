# Content
This repository contains the description files to make a Docker-Image as well as an Apptainer-Image.

## Configure Spinnaker
Before building the image edit the spynnaker.cfg to work with your board.
This can also be done afterwards by copying and replacing the config file in your home directory with your edited version

## Apptainer
1. To build the Apptainer image just run:
    
        apptainer build <path/to/target/image.sif> ./apptainer.def

    Where the image is copied into the target directory and "apptainer.def" is the definition file for the image

2. We need to generate an overlay which is used to make folders writable
        
        apptainer shell --overlay /tmp/spinnaker_reports_overlay.img target.sif 


3. Start the container with shell by calling

        apptainer shell --overlay /tmp/spinnaker_reports_overlay.img image.sif 


    or just run the container with

        apptainer run --overlay /tmp/spinnaker_reports_overlay.img /path/to/image.sif

    or execute a command in container with

        apptainer exec --overlay /tmp/spinnaker_reports_overlay.img /path/to/image.sif command

4. Test if spinnaker is all setup by going to spinnaker source folder

        cd /home/spinnaker/source

    and run the va_benchmark.py

        python PyNN8Examples/examples/va_benchmark.py

## Docker (Untested)
To build the Docker image just run:

    docker build /path/to/Dockerfile

Start the container with active shell with

    docker run -it <image_id> /bin/bash
