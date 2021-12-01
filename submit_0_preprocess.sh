#!/bin/bash

# Helper script to submit the preprocess script.

scriptdir=/home/westbroo/Worry_and_Mindfulness/Scripts

for dirname in /home/westbroo/Worry_and_Mindfulness/Subjects/*
do
    subnum=`echo $dirname | tr -cd '[:digit:]'`
    echo $subnum
    cd ${dirname}
  if [[ $subnum > 4003 && $subnum < 4054 ]]; then
    ${scriptdir}'/0_preprocess.csh' $subnum
  fi
done
