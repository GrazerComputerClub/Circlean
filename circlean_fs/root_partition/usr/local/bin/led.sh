#!/bin/bash

#activate or deactivate (parameter 2) output/LED GPIO (parameter 1)
gpio -g mode $1 out
gpio -g write $1 $2
