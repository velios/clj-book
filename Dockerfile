FROM ubuntu:18.04

ENV TZ=Europe/Moscow

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -y \
    texlive-latex-extra \
    make \
    gettext \
    python \
    python-setuptools \
    python-pygments \
    texlive-lang-cyrillic \
    texlive-fonts-extra \
    git \
    cm-super

RUN mktextfm larm0900
RUN mktextfm larm1000
RUN mktextfm larm2488
RUN mktextfm labx2488
RUN mktextfm larm1440
RUN mktextfm latt1000
RUN mktextfm lati1000
RUN mktextfm labx1440
RUN mktextfm larm0600
RUN mktextfm latt0900
RUN mktextfm larm2074
RUN mktextfm labx2074
RUN mktextfm lasl0900
RUN mktextfm larm0800
RUN mktextfm larm0500
RUN mktextfm lati0900
RUN mktextfm labx0900
RUN mktextfm larm1200
RUN mktextfm labx1200

RUN mkdir /workdir
WORKDIR /workdir

COPY pyg_print ./pyg_print
COPY Makefile ./
RUN make pyg-print-install

WORKDIR /
RUN rm -rf /workdir

ENTRYPOINT ["/bin/bash", "-c", "source /book/ENV_PRINT && \"$@\"", "-s"]
