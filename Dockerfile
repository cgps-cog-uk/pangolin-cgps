FROM continuumio/miniconda3
LABEL authors="Corin Yeats and Anthony Underwood" \
      description="Docker image containing all requirements COVID-19 lineage assignment"

RUN apt update && \
    apt install -y curl git

# Create the environment
RUN curl https://raw.githubusercontent.com/aunderwo/lineages/master/environment.yml > /environment.yml
RUN conda env create -f /environment.yml && conda clean -a

COPY csv2json.py /
RUN chmod +x /csv2json.py

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
