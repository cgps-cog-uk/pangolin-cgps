FROM continuumio/miniconda3
LABEL authors="Corin Yeats and Anthony Underwood" \
      description="Docker image containing all requirements COVID-19 lineage assignment"

RUN apt update && \
    apt install -y curl git

# Create the environment
RUN curl https://raw.githubusercontent.com/aineniamh/lineages/master/environment.yml > /environment.yml
RUN conda env create -f /environment.yml && conda clean -a

# IQtree install - overwrites the default from conda
RUN curl -L https://github.com/Cibiv/IQ-TREE/releases/download/v2.0-rc2/iqtree-2.0-rc2-Linux.tar.gz | tar -xz \
    && mv iqtree-2.0-rc2-Linux/bin/iqtree /opt/conda/envs/pangolin-env/bin/ \
    && rm -rf iqtree*

RUN conda run -n pangolin-env pip install git+https://github.com/aineniamh/lineages.git

COPY csv2json.py /
RUN chmod +x /csv2json.py

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
