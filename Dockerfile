FROM ypzhang/cxx-python-dev

#############################################################################                                                                                                                                                  # Install CUDA toolkit only, skip driver                                                                                                                                                                                       # Assuming files are copied to /usr/local/src/cuda_files                                                                                                                                                                       
#############################################################################
COPY ./cuda_files /usr/local/src/cuda_files


## Only install toolkit, skipping drivers
RUN wget -q --directory-prefix=/usr/local/src/cuda_files https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda_8.0.44_linux-run 

RUN sh /usr/local/src/cuda_files/cuda_8.0.44_linux-run --tmpdir=/tmp/ --toolkit  -silent
RUN rm -rf /tmp/* /usr/local/src/cuda_files/cuda_8.0.44_linux-run

# Copy cudnn 5.1 to CUDA toolkit 
RUN cp /usr/local/src/cuda_files/cudnn5.1/cuda/include/* /usr/local/cuda/include/.
RUN cp /usr/local/src/cuda_files/cudnn5.1/cuda/lib64/* /usr/local/cuda/lib64/.

## Expose CUDA DIR
ENV PATH=/usr/local/cuda/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

#RUN export PATH=/usr/local/cuda/bin:$PATH
#RUN export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH



