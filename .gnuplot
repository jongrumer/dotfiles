# GNUPLOT CONFIG
# ==============
# search for functions or data files in these directories
set loadpath '/Users/jon/.gnuplotfiles:/Users/jon/.gnuplotfiles/gnuplot-configs:/Users/jon/.gnuplotfiles/gnuplot-palettes:/Users/jon/.gnuplotfiles/gnuplot-basics'
# load default color palette
load 'dark2.pal'
# set default terminal
set terminal qt
# enable macros
set macros
# corresponding macros
BLUE = "1"
ORANGE = "2"
YELLOW = "3"
PURPLE = "4"
GREEN = "5"
LIGHTBLUE = "6"
RED = "7"
# add macros to select a desired terminal
PNG = "set terminal pngcairo size 350,262 enhanced font 'Verdana,10'"
SVG = "set terminal svg size 350,262 fname 'Verdana, Helvetica, Arial, sans-serif' fsize = 10"
