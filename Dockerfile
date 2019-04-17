# Copyright 2016, EMC, Inc.
ARG repo=rackhd
ARG tag=devel

FROM ${repo}/on-core:${tag}

COPY . /RackHD/on-tasks/

RUN cd /RackHD/on-tasks \
  && mkdir -p /RackHD/on-tasks/node_modules \
  && npm install -g cnpm --registry=https://registry.npm.taobao.org \
  && cnpm install --ignore-scripts --production \
  && rm -r /RackHD/on-tasks/node_modules/on-core \
  && rm -r /RackHD/on-tasks/node_modules/di \
  && ln -s /RackHD/on-core /RackHD/on-tasks/node_modules/on-core \
  && ln -s /RackHD/on-core/node_modules/di /RackHD/on-tasks/node_modules/di \
  && mkdir /var/lib/apt/list \
  && cp -r /var/lib/apt/lists/* /var/lib/apt/list \
  && rm -rf  /var/lib/apt/lists/* \
  && echo 'deb http://mirrors.aliyun.com/debian wheezy main contrib non-free'>>/etc/apt/sources.list \
  && echo 'deb-src http://mirrors.aliyun.com/debian wheezy main contrib non-free'>>/etc/apt/sources.list \
  && echo 'deb http://mirrors.aliyun.com/debian wheezy-updates main contrib non-free'>>/etc/apt/sources.list \
  && echo 'deb-src http://mirrors.aliyun.com/debian wheezy-updates main contrib non-free'>>/etc/apt/sources.list \
  && echo 'deb http://mirrors.aliyun.com/debian-security wheezy/updates main contrib non-free'>>/etc/apt/sources.list \
  && echo 'deb-src http://mirrors.aliyun.com/debian-security wheezy/updates main contrib non-free'>>/etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y apt-utils ipmitool openipmi
