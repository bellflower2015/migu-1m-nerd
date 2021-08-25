#!/bin/bash

export PYTHONIOENCODING=utf-8

[ -e /opt/build ] && rm -rf /opt/build

mkdir -p /opt/build

apt-get update -y \
    && apt-get install -y python-fontforge fontforge subversion curl unzip patch \
    && curl -LO https://bootstrap.pypa.io/pip/2.7/get-pip.py \
    && python get-pip.py \
    && pip install configparser \
    && cd /opt/build \
    && curl -L "https://osdn.net/frs/redir.php?m=liquid&f=mix-mplus-ipa%2F72511%2Fmigu-1m-20200307.zip" -o migu-1m-20200307.zip \
    && unzip -o migu-1m-20200307.zip \
    && svn export https://github.com/ryanoasis/nerd-fonts/tags/v2.0.0/font-patcher \
    && curl -LO https://raw.githubusercontent.com/tsunesan3/awsome-jp-coding-fonts/v1.0.0/tools/font-patcher.diff \
    && patch -p1 < font-patcher.diff \
    && mkdir src \
    && cd src \
    && svn export https://github.com/ryanoasis/nerd-fonts/tags/v2.0.0/src/glyphs \
    && cd .. \
    && fontforge -script font-patcher migu-1m-20200307/migu-1m-regular.ttf -c \
    && fontforge -script font-patcher migu-1m-20200307/migu-1m-bold.ttf -c \
    && curl -LO http://yozvox.web.fc2.com/unitettc.zip \
    && unzip -o unitettc.zip \
    && chmod 755 unitettc/unitettc64 \
    && unitettc/unitettc64 Migu1M.ttc Migu1M-{Regular,Bold}.ttf \
    && mv -f Migu1M.ttc .. \
    && rm -f Migu1M-{Regular,Bold}.ttf
