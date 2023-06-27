ARG PANGOLIN_VERSION
ARG PANGOLIN_DATA_VERSION
#
#FROM registry.gitlab.com/cgps/cog-uk/pangolin/code:$PANGOLIN_VERSION AS code
#FROM registry.gitlab.com/cgps/cog-uk/pangolin/models:$PANGOLIN_DATA_VERSION AS data

FROM continuumio/miniconda3:latest

ARG PANGOLIN_VERSION
ARG PANGOLIN_DATA_VERSION

LABEL authors="Corin Yeats and Anthony Underwood" \
      description="Docker image containing all requirements COVID-19 lineage assignment"

#RUN apt  --allow-releaseinfo-change update \
#    && apt install -y curl \
#    && rm -rf /var/lib/apt/lists/*

# Install pangolin
#COPY --from=code /code/pangolin pangolin
COPY csv_reports_to_json.py /csv_reports_to_json.py

COPY entrypoint.sh /entrypoint.sh

RUN apt update \
    && apt install -y git \
    && git clone --depth 1 --branch ${PANGOLIN_VERSION} --single-branch https://github.com/cov-lineages/pangolin.git \
    && chmod +x csv_reports_to_json.py \
    && chmod +x entrypoint.sh \
    && cd pangolin \
    && conda env create -f environment.yml \
    && conda init bash \
    && . /root/.bashrc \
    && conda activate pangolin \
    && pip install .  \
    && echo $PANGOLIN_VERSION > /.pangolin_version \
    && echo $PANGOLIN_DATA_VERSION > /.pangolin_data_version \
    && apt remove -y git \
    && rm -rf /var/lib/apt/lists/*
RUN pip cache purge

ENTRYPOINT ["/entrypoint.sh"]
