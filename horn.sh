OPENSCAD=~/Desktop/OpenSCAD-2013.10.26.app/Contents/MacOS/OpenSCAD
for i in {0..4}; do
  $OPENSCAD horn.scad -D"ITEM=$i;" -o horn-$i.stl
done
