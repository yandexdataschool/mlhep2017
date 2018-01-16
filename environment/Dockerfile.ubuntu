FROM ubuntu:16.04
MAINTAINER Andrey Ustyuzhanin andrey.u@gmail.com
EXPOSE 8888

COPY install-packages.sh /tmp/
RUN /tmp/install-packages.sh

# install anaconda
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

SHELL ["/bin/bash", "--login", "-c"]

COPY start_jupyter_or_everware.sh /usr/local/bin/
CMD ["/bin/bash", "--login", "-c", "/usr/local/bin/start_jupyter_or_everware.sh"]

COPY install-jupyter.sh /tmp/
RUN /tmp/install-jupyter.sh

COPY install-modules.sh environment.yaml /tmp/
RUN cd /tmp && /tmp/install-modules.sh
 
#COPY install-root.sh /tmp/
#RUN cd /tmp && /tmp/install-root.sh
 
COPY install-hyperopt.sh /tmp/
RUN cd /tmp && /tmp/install-hyperopt.sh
 
