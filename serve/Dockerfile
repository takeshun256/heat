FROM pytorch/torchserve:latest-gpu

RUN cd /home/model-server && git clone https://github.com/iShohei220/heat.git
RUN cd /home/model-server/heat && pip install -r requirements.txt
RUN cd /home/model-server/heat/models/ops && sh make.sh
