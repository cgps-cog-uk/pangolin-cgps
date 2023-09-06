FROM python:3.9-slim

LABEL authors="Corin Yeats and Anthony Underwood" \
      description="Docker image containing all requirements COVID-19 lineage assignment"

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
    && conda update -n base -c defaults conda \
    && conda clean -afy

RUN conda create -n pangolin -y \
    && conda init bash \
    && . /root/.bashrc \
    && conda activate pangolin \
    && conda config --add channels defaults \
    && conda config --add channels bioconda \
    && conda config --add channels conda-forge \
    && conda config --set channel_priority strict \
    && . /root/.bashrc \
    && conda activate pangolin \
    && conda install pangolin -y \
    && conda update --all

RUN conda run -n pangolin pangolin -v | sed 's/pangolin //' > /.pangolin_version

RUN conda run -n pangolin pangolin -pv | sed 's/pangolin-data //' > /.pangolin_data_version

COPY csv_reports_to_json.py /csv_reports_to_json.py

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x csv_reports_to_json.py \
    && chmod +x entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
