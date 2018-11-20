#!/bin/bash

cmd="docker build --build-arg SERVICE_NAME=hadoop --build-arg SERVICE_VERSION=hadoop -t hadoop ."
echo $cmd

$cmd
