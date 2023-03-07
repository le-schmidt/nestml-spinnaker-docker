FROM python:3.10

RUN apt-get update -y
RUN apt-get upgrade -y

RUN mkdir /home/spinnaker
WORKDIR /home/spinnaker

### SPINNAKER DEVELOPMENT ENVIRONMENT ###

# Following DevEnv setup found here
# http://spinnakermanchester.github.io/development/devenv6.0.html

# 1 Install Python requirements 
# 1.1 General platform requirements already satisfied by baseimage

# 1.2 Not relevant

# 1.3 Install general dependencies

COPY ./requirements_spinnaker.txt .

RUN pip install -r ./requirements_spinnaker.txt

# 2 Install the C development requirements (Debian/Ubuntu)
# 2.1 arm-none-eabi toolchain
# RUN apt-get install gcc-arm-none-eabi  libnewlib-arm-none-eabi -y

RUN mkdir /home/dev
WORKDIR /home/dev
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
RUN tar xvf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
RUN rm gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
ENV PATH /home/dev/gcc-arm-none-eabi-10.3-2021.10/bin:$PATH

# 2.2 perl and dependencies
RUN apt-get install perl perl-tk libterm-readline-gnu-perl -y

# 3 Clone Spinnaker repositories
RUN mkdir /home/spinnaker/spinnaker_source
WORKDIR /home/spinnaker/spinnaker_source
RUN git clone https://github.com/SpiNNakerManchester/SupportScripts
RUN bash SupportScripts/install.sh 8 -y

# 4 Install python modules
RUN bash SupportScripts/setup.sh
RUN python -m spynnaker.pyNN.setup_pynn

# 5 Setup C environment and build
RUN bash SupportScripts/automatic_make.sh
COPY .spynnaker.cfg /root


### NESTML ###
WORKDIR /home
RUN git clone https://github.com/siirty/nestml.git
WORKDIR /home/nestml
RUN git checkout spinnaker-new
RUN python setup.py install --user
RUN pip install pytest
# RUN pytest /home/nestml/tests/spinnaker_tests/test_spinnaker_iaf_psc_exp.py 