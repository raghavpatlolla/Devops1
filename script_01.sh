#!/bin/bash
#FUNCTIONS
ECHO_SAMPLE(){
  echo "hi i am from a sample function ECHO_SAMPLE"
  return
  echo "value of a is $a"
  b=200
}

a=100
echo " b values is $b"
ECHO_SAMPLE
echo " b values is $b"