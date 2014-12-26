// Base holder for Microsoft HD-3000 Web-Cam
// This is a remix of this Thing #274162 on Thingiverse
// http://www.thingiverse.com/thing:274162
//
// The base plate have been inspired by Think3dPrint3d
// http://blog.think3dprint3d.com/2013/10/OpenSCAD-Mendel90-Filament-Holder.html
//
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege <k4230r6@gmail.com>


use <../conf/utils.scad>

$fn=50;

threadedRodHole = 8.3;
base_z = 3;
base_z2 = 2+4;
clearance =0.3;

fastener_clearance_radius=3.3/2;
fastener_washer_clearance_radius=8/2.0;
mounting_plate_height = base_z;



mounting_plate_thickness=8;
mounting_plate_width=40+fastener_washer_clearance_radius;
mounting_plate_height=22+fastener_washer_clearance_radius*3;


module triangle () {
    b = 10;
    h = 30;
    w = 5;
    rotate(a=[90,-90,0]) {
        linear_extrude(height = w, center = true, convexity = 10, twist = 0)
            polygon(points=[[0,0],[h,0],[0,b]], paths=[[0,1,2]]);
    }
}

module base () {
    hull() {

        rounded_rectangle([mounting_plate_height,mounting_plate_width,base_z], r=2, center = true);
        translate([0,0,base_z2])cylinder(h=1, r=5,  center=true);
    }
    translate([0,0,base_z]) cylinder(h=30 ,r2=threadedRodHole/2.0 +3, r1=threadedRodHole/2.0 +6);

     for(i=[0:90:270]) {
        rotate([0,0,i]) translate([-(threadedRodHole/2.0+2.5),0,base_z-1]) triangle();
     }
}

module drill_hole () {
        #cylinder(h=100 ,r=threadedRodHole/2.0, $fn=60);
}

difference () {
    translate([0,0,base_z/2]) base ();
    translate([0,0,-0.2]) drill_hole();
    translate([0,0,-0.2]) #cylinder(h=7.5 +0.2,r=14.7/2+clearance, $fn=6);


    //bolt holes
    for(i=[-1,1])
      for(j=[-1,1])
        translate([(j*mounting_plate_height/2 - j*(fastener_washer_clearance_radius-1)),
                i*mounting_plate_width/2 -i*(fastener_washer_clearance_radius -1),base_z])
        {
        rotate([0,0,(j*270)]) {
            #cylinder(h=100,r=fastener_clearance_radius,center = true);
            translate([0,0,+20])
            #cylinder(h=40,r=fastener_washer_clearance_radius, center = true);
        }
     }
}
translate([0,0,7.5]) cylinder(h=0.2 ,r=14.5/2+2*clearance);

