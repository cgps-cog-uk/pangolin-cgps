ARG PANGOLIN_VERSION
ARG PANGOLIN_DATA_VERSION
#
#FROM registry.gitlab.com/cgps/cog-uk/pangolin/code:$PANGOLIN_VERSION AS code
#FROM registry.gitlab.com/cgps/cog-uk/pangolin/models:$PANGOLIN_DATA_VERSION AS data

#FROM continuumio/miniconda3:latest

FROM python:3.9-slim

ARG PANGOLIN_VERSION
ARG PANGOLIN_DATA_VERSION

LABEL authors="Corin Yeats and Anthony Underwood" \
      description="Docker image containing all requirements COVID-19 lineage assignment"

#RUN apt  --allow-releaseinfo-change update \
#    && apt install -y curl \
#    && rm -rf /var/lib/apt/lists/*

# Install pangolin
#COPY --from=code /code/pangolin pangolin

RUN apt update \
    && apt install -y git wget \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN mkdir -p ~/miniconda3 \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh \
    && mkdir -p /opt \
    && /bin/bash ~/miniconda3/miniconda.sh -b -p /opt/conda \
    && rm -rf ~/miniconda3/miniconda.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
    && echo "conda activate base" >> ~/.bashrc \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && conda clean -afy

RUN git clone --depth 1 --branch ${PANGOLIN_VERSION} --single-branch https://github.com/cov-lineages/pangolin.git \
    && cd pangolin \
    && sed -i 's/python>=3.7/python>=3.9/' environment.yml \
    && conda env create -f environment.yml \
    && conda init bash \
    && . /root/.bashrc \
    && conda activate pangolin \
    && pip install .

#RUN conda install -c bioconda -c conda-forge -c defaults pangolin

#RUN git clone --depth 1 --branch ${PANGOLIN_VERSION} --single-branch https://github.com/cov-lineages/pangolin.git \
#    && cd pangolin \
#    && conda env create -f environment.yml \
#    && conda clean -a \
#
#RUN conda init bash \
#    && . /root/.bashrc \
#    && cd pangolin \
#    && conda activate pangolin \
#    && python setup.py install \
#    && python pip_installs.py \
#    && pip install git+https://github.com/cov-lineages/pangolin-data.git \
#    && pip install git+https://github.com/cov-lineages/scorpio.git \
#    && pip install git+https://github.com/cov-lineages/constellations.git

#RUN pip cache purge

COPY csv_reports_to_json.py /csv_reports_to_json.py

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x csv_reports_to_json.py \
    && chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
