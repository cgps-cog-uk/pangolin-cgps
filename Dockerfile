FROM continuumio/miniconda3
LABEL authors="Corin Yeats and Anthony Underwood" \
      description="Docker image containing all requirements COVID-19 lineage assignment"

RUN apt update && \
    apt install -y curl git

# Create the environment
RUN curl https://raw.githubusercontent.com/hCoV-2019/pangolin/report_maker/environment.yml > /environment.yml
RUN conda env create -f /environment.yml && conda clean -a

# Install pangolin
RUN git clone  https://github.com/hCoV-2019/pangolin.git /pangolin
# Checkout branch
RUN cd pangolin && git checkout report_maker
RUN cd pangolin && conda run -n pangolin-web python setup.py install

COPY csv_reports_to_json.py /
RUN chmod +x /csv_reports_to_json.py

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
