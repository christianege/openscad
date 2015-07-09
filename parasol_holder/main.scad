// Holder for a big parasol
// License GNU GENERAL PUBLIC LICENSE v2+
// Copyright 2014 Christian Ege

// module tube is from Catarina Mota
// http://svn.clifford.at/openscad/trunk/libraries/shapes.scad

clearance = 0.8;
$fn=200;

h_in                  = 17.0;  // height inner tube
h_out               = 12;  // height outer tube
h_pl                  = 2.0;    // height top lid plate

r_in                   =  53.8/2;    // radius of inner tube
r_out                =  65.0/2;    // radius of outer tube
r_sten              =  40.0/2;     // radius of the cut out for the stern of the umbrella
wall_cut_out =    2.8;         // wall ofd cut out tube

module parasol_holder() {
	difference() {
        union() {
            cylinder(h = h_pl, r=r_out);
            cylinder(h = h_in, r=r_in );
            cylinder(h = h_out, r=r_out);
        }
         translate([0,0,(h_in/2)+h_pl+clearance])#tube(h_in+clearance,r_in+wall_cut_out,wall_cut_out,true);
        translate([0,0,-clearance]) #cylinder(h =h_in+2*clearance, r=r_sten );
        }
}

// wall is wall thickness
module tube(height, radius, wall, center = false) {
  difference() {
    cylinder(h=height, r=radius, center=center);
    cylinder(h=height, r=radius-wall, center=center);
  }
}

parasol_holder();