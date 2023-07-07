# Content
This repository contains the description files to make a Docker-Image as well as an Apptainer-Image.

## Configure Spinnaker
Before building the image edit the spynnaker.cfg to work with your board.
This can also be done afterwards by copying and replacing the config file in your home directory with your edited version



## Apptainer

Disclaimer: If you encounter a problem with storage space set the APPTAINER_TMPDIR variable to a path that you know has enough space left ~5GB
	
	export APPTAINER_TMP_DIR=<dir_with_free_space>


1. To build the Apptainer image just run:
    
        apptainer build <path/to/target/image.sif> ./apptainer.def

    Where the image is copied into the target directory and "apptainer.def" is the definition file for the image

2. We need to generate an overlay which is used to make folders writable
        
        apptainer overlay create --size 512 <path/to/target/overlay_name.img>


3. Start the container with shell by calling

        apptainer shell --overlay <path/to/target/overlay_name.img> /path/to/image.sif 

You can skip the next steps by running 
	
	./setup_script.sh

4. Test if spinnaker is all setup by going to spinnaker source folder

        cd /home/spinnaker/source

    and run the va_benchmark.py

        python PyNN8Examples/examples/va_benchmark.py

5. Setup NESTML
    Setup nestml for python

        cd /home/nestml
        git checkout spinnaker-new
        python setup.py install --user

    Setup folder for generated spinnaker models

        cd spinnaker-install
        python setup.py develop

6. Test NESTML
    Generate spinnaker source files and example

        cd ..
        pytest tests/spinnaker_tests/test_spinnaker_iaf_psc_exp.py
	
    Open spinnaker-install/examples/<neuronName>_chain_example.py and see if parameters are correct

    Run example

        python spinnaker-install/examples/iaf_psc_exp_nestml_chain_example.py

## Docker (Untested)
To build the Docker image just run:

    docker build /path/to/Dockerfile

Start the container with active shell with

    docker run -it <image_id> /bin/bash
