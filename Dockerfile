FROM continuumio/miniconda3
LABEL authors="Corin Yeats and Anthony Underwood" \
      description="Docker image containing all requirements COVID-19 lineage assignment"

RUN apt update && \
    apt install -y curl git

# Create the environment
COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
RUN git clone https://github.com/aineniamh/lineages.git /lineage 

# IQtree install - overwrites the default from conda
RUN curl -L https://github.com/Cibiv/IQ-TREE/releases/download/v2.0-rc2/iqtree-2.0-rc2-Linux.tar.gz | tar -xz \
    && mv iqtree-2.0-rc2-Linux/bin/iqtree /opt/conda/envs/lineage-env/bin/ \
    && rm -rf iqtree*

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

#CMD "/bin/bash"
ENTRYPOINT ["/entrypoint.sh"]
