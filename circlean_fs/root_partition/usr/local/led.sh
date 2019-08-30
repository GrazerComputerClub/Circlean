#!/bin/bash

#activate output/LED GPIO4
gpio -g mode 4 out
gpio -g write 4 1
