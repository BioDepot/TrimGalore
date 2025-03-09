FROM debian:bullseye-slim
RUN apt-get update && apt-get -y install default-jre git libfindbin-libs-perl libhtsjdk-java libngs-java fastqc cutadapt curl isal\
    && apt-get autoclean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* 
 
RUN git clone https://github.com/BioDepot/TrimGalore.git
RUN ln -s /TrimGalore/trim_galore /usr/local/bin/trim_galore
