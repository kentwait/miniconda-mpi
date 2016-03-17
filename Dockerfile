FROM kentwait/docker-openmpi
MAINTAINER Kent Kawashima <kentkawashima@gmail.com>

# Install utilities
RUN apt-get install -q -y ca-certificates \
                          libglib2.0-0 \
                          libxext6 \
                          libsm6 \
                          libxrender1 \
                          git \
                          mercurial \
                          subversion

# Install anaconda 
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.19.0-Linux-x86.sh && \
    /bin/bash /Miniconda3-3.19.0-Linux-x86.sh -b -p /opt/conda && \
    rm /Miniconda3-3.19.0-Linux-x86.sh

ENV PATH /opt/conda/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# Install Python3 packages
RUN conda install -q -y ipython \
                        jupyter
RUN pip install -q simpy \
                   mpi4py

# Create "docker" user
RUN useradd --create-home --home-dir /home/docker --shell /bin/bash docker
RUN usermod -a -G sudo docker
RUN echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Allow notebook to communicate with outside world
EXPOSE 8888
USER docker
RUN mkdir -p /home/docker/notebooks
ENV HOME=/home/docker
ENV SHELL=/bin/bash
ENV USER=docker
VOLUME /home/docker/notebooks
WORKDIR /home/docker/notebooks

CMD /opt/conda/bin/jupyter-notebook --no-browser --port 8888 --ip=0.0.0.0