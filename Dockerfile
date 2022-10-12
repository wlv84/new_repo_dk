FROM rocker/r-ver:4.2.1

ENV DATE=2022-01-01
ENV PKGS="'openxlsx'"

RUN mkdir /home/test
RUN /rocker_scripts/install_tidyverse.sh
RUN R -e "options(repos = list(CRAN = 'https://mran.microsoft.com/snapshot/${DATE}')); \
    install.packages(c(${PKGS}))"

COPY test.R /home/test/test.R

CMD cd /home/test && R -e "source('test.R')" && mv /home/test/test.xlsx /home/output/test.xlsx

# run the command below to test the project
# docker run --name test --rm -v $(pwd)/output:/home/output test
