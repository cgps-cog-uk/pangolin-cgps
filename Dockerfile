ARG PANGOLIN_VERSION
ARG PANGOLEARN_VERSION

FROM registry.gitlab.com/cgps/cog-uk/lineages-code:$PANGOLIN_VERSION AS code
FROM registry.gitlab.com/cgps/cog-uk/lineages-data:$PANGOLEARN_VERSION AS data

FROM continuumio/miniconda3

ARG PANGOLIN_VERSION
ARG PANGOLEARN_VERSION

LABEL authors="Corin Yeats and Anthony Underwood" \
      description="Docker image containing all requirements COVID-19 lineage assignment"

RUN apt  --allow-releaseinfo-change update \
    && apt install -y curl \
    && rm -rf /var/lib/apt/lists/*

# Install pangolin
COPY --from=code /code/pangolin pangolin
RUN cd pangolin \
    && conda env create -f environment.yml \
    && conda clean -a

RUN conda init bash \
    && . /root/.bashrc \
    && cd pangolin \
    && conda activate pangolin \
    && python setup.py install

COPY --from=code /code/csv_reports_to_json.py /csv_reports_to_json.py
RUN chmod +x /csv_reports_to_json.py

COPY --from=code /code/entrypoint.sh /
RUN chmod +x /entrypoint.sh

COPY --from=data /data /data

RUN echo $PANGOLIN_VERSION > /.pangolin_version
RUN echo $PANGOLEARN_VERSION > /.pangoLEARN_version

ENTRYPOINT ["/entrypoint.sh"]
