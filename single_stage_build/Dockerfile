FROM continuumio/miniconda3

ARG VERSION=master

RUN apt install -y git

RUN git clone --branch ${VERSION} --single-branch https://github.com/cov-lineages/pangolin

RUN cd pangolin \
    && conda env create -f environment.yml \
    && conda clean -a

RUN conda init bash \
    && . /root/.bashrc \
    && cd pangolin \
    && conda activate pangolin \
    && python setup.py install

COPY csv_reports_to_json.py /
RUN chmod +x /csv_reports_to_json.py

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]