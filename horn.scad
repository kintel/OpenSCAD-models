INCHES = 25.4;

NUMBER = 2;
DIAMETER = 60;
HEIGHT = 120;
TWIST = 0.5;
DISTANCE = 0.4;
HOLLOW = false;
SCALE = 6/8;

module baseshape(size) {
 circle(size/2);
* rotate([0,0,45]) square(size, center=true);
* rotate([0,0,45]) pentagon(size/2);
}


COLORS = ["White", "Red", "Green", "Blue", "Yellow", "Black", "Pink"];
NUM_COLORS = 8;
ITEM = -1;
use <MCAD/regular_shapes.scad>


module base(neg = false) {
  if (neg) {
    difference() {
      translate([DIAMETER/2*DISTANCE,0]) baseshape(DIAMETER);
      translate([-DIAMETER/2*DISTANCE,0]) baseshape(DIAMETER);
    }
  }
  else {
    translate([-DIAMETER/2*DISTANCE,0]) baseshape(DIAMETER);
  }
}

module baseitem(n) {
  rotate([0,0,n*360/NUMBER]) translate([DIAMETER/2*DISTANCE,0]) baseshape(DIAMETER);
}

module newbase(n) {
  difference() {
    baseitem(n);
    for (i=[0:NUMBER-1]) {
      if (i!=n) baseitem(i);
    }
  }
}

module smoother() {
  hull() {
    sphere(r=10);
    translate([0,0,54.5]) sphere(r=4);
  }
}

module extrudepart() {
    linear_extrude(height=HEIGHT, twist=TWIST*360, scale=[SCALE, SCALE], convexity=3) child();
}

module part(item) {
    color(COLORS[(item+1)%NUM_COLORS]) extrudepart() newbase(item);
}

module inside() {
    color(COLORS[0]) extrudepart() for (i=[1:NUMBER-1], j=[0:i-1]) {
        intersection() {baseitem(i); baseitem(j);}
    }
}

module horn(item) {
  if (item == -1) {
      for (x=[0:NUMBER-1]) part(x);
  }
  else {
      part(item);
  }
}

horn(ITEM);
if (!HOLLOW) inside();
