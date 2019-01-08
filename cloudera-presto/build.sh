#!/bin/bash

if [ ! -f "java-1.8.0-openjdk-headless-1.8.0.191.b12-0.el6_10.x86_64.rpm" ]; then
    wget http://mirror.centos.org/centos/6/updates/x86_64/Packages/java-1.8.0-openjdk-headless-1.8.0.191.b12-0.el6_10.x86_64.rpm
fi

cmd="docker build --build-arg SERVICE_NAME=hadoop --build-arg SERVICE_VERSION=hadoop -t hadoop ."
echo $cmd

$cmd
