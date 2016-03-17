# miniconda-mpi

Docker container for developing MPI applications in Python using Jupyter notebook.
Includes Miniconda 3.19.0 for Python 3.5.

## Install

	docker pull kentwait/miniconda-mpi


## Usage

The following command runs the container which launches a Jupyter notebook running Python 3.5 and IPython 4.1.1.

	docker run -d -p <port>:8888 -v <directory>:/home/docker/notebooks kentwait/miniconda-mpi

Replace `<port>` with 8888 (default) or any unused port on the host machine.
Replace `<directory>` with the directory where notebooks will be stored on the host machine.


# Notes

Because only Miniconda is included, this container is compact and ideal as a base for adding Python 3 packages as needed. If you would rather have the full Anaconda installation, please use [kentwait/anaconda-mpi][https://github.com/kentwait/anaconda-mpi] instead.