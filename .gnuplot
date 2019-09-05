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

# default line colors (Matlab) (same as 11-17 in parula.pal)
set style line 1 lt 1 lc rgb '#0072bd' # blue
set style line 2 lt 1 lc rgb '#d95319' # orange
set style line 3 lt 1 lc rgb '#edb120' # yellow
set style line 4 lt 1 lc rgb '#7e2f8e' # purple
set style line 5 lt 1 lc rgb '#77ac30' # green
set style line 6 lt 1 lc rgb '#4dbeee' # light-blue
set style line 7 lt 1 lc rgb '#a2142f' # red

# corresponding macros
BLUE = "1"
ORANGE = "2"
YELLOW = "3"
PURPLE = "4"
GREEN = "5"
LIGHTBLUE = "6"
RED = "7"

# add macros to select a desired terminal
WXT = "set terminal wxt size 350,262 enhanced font 'Verdana,10' \
   persist"
PNG = "set terminal pngcairo size 350,262 enhanced font 'Verdana,10'"
SVG = "set terminal svg size 350,262 fname \
   'Verdana, Helvetica, Arial, sans-serif' fsize = 10"
