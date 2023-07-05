FROM pytorch/torchserve:latest-gpu

USER root
RUN apt-get update && apt-get install -y git ninja-build
RUN export PATH="/usr/local/cuda/bin:$PATH"
RUN export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
RUN cd /home/model-server && git clone https://github.com/takeshun256/heat.git
RUN cd /home/model-server/heat && python -m pip install -r requirements.txt
RUN cd /home/model-server/heat/models/ops && export PATH="/usr/local/cuda/bin:$PATH" && export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH" && python setup.py build install
