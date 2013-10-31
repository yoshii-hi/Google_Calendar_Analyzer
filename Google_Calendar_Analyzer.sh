#!/bin/sh

data_file="data.txt"

ruby Google_Calendar_Analyzer.rb
R --vanilla --slave --args $data_file < Google_Calendar_Analyzer.R
echo $data_file | sed -e s/.*//
open pdf/$data_file.pdf
