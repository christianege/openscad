// Base Plate for the STMicroelectronics Nucleo board
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege <k4230r6@gmail.com>


nucleo_x = 70;
nucleo_y1 = 80.50;
nucleo_y2 = 82.50;
nucleo_z = 1.6;

header_cutout_w = 6;
header_cutout_h = 48.1;

header_cutout = [[2.3,30.5],[nucleo_x-(2.3+header_cutout_w),30.5]];

base_plate_z = 3;

pt_screw_l = 12;
pt_screw_d = 3;

clearance = 0.3;

drill_hole_y = (27.65+3.35/2);
nucleo_drill_holes = [[10.87,drill_hole_y],[59.129,drill_hole_y],[43.89,76.725]];




module screw_receiving () {
	for(i = nucleo_drill_holes ) {
	translate ([0,0,base_plate_z]) {
		translate (i)	{
				cylinder(h = pt_screw_l +clearance, r=((pt_screw_d*0.8)+1), $fn=60 ) ;
			}
		}
	}
}

module screw_holes () {
	for(i = nucleo_drill_holes ) {
	translate ([0,0,clearance+base_plate_z]) {
		translate (i)	{
				cylinder(h = pt_screw_l +2*clearance, r=((pt_screw_d*0.8)), $fn=60 ) ;
			}
		}
	}
}

module stand_bolts () {
	difference () {
		screw_receiving ();
		#screw_holes();
	}
}

module header_cutouts () {
	for(i = header_cutout ) {
		translate([0,0,-clearance]) {
			translate (i) {
				cube([header_cutout_w,header_cutout_h,(base_plate_z+2*clearance)]);
			}
		}
	}
}

module base_plate () {
	difference () {
		cube([nucleo_x,nucleo_y2,base_plate_z]);
		#header_cutouts ();
	}
}



base_plate();
stand_bolts();


