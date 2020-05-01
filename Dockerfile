ARG CODE_VERSION=latest
ARG DATA_VERSION=latest

FROM registry.gitlab.com/cgps/lineages-code:${CODE_VERSION} AS code
FROM registry.gitlab.com/cgps/lineages-data:${DATA_VERSION} AS data

FROM continuumio/miniconda3

LABEL authors="Corin Yeats and Anthony Underwood" \
      description="Docker image containing all requirements COVID-19 lineage assignment"

RUN apt update \
    && apt install -y curl \
    && rm -rf /var/lib/apt/lists/*

# Create the environment
#RUN curl https://raw.githubusercontent.com/hCoV-2019/pangolin/report_maker/environment.yml > /environment.yml

# Install pangolin
COPY --from=code /code/pangolin pangolin
RUN cd pangolin \
    && conda env create -f environment.yml \
    && conda clean -a \
    && conda run -n pangolin python setup.py install

COPY --from=code /code/csv_reports_to_json.py /csv_reports_to_json.py
RUN chmod +x /csv_reports_to_json.py

COPY --from=code /code/entrypoint.sh /
RUN chmod +x /entrypoint.sh

COPY --from=data /data /data

ENTRYPOINT ["/entrypoint.sh"]
