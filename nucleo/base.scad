// Base Plate for the STMicroelectronics Nucleo board
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege <k4230r6@gmail.com>

$fn=50;

include <pin_headers.scad>;
include <sensor_modules.scad>;
use <spacers.scad>
use <../conf/utils.scad>

nucleo_x = 70;
nucleo_y1 = 80.50;
nucleo_y2 = 82.50;
nucleo_z = 1.6;

epsilon = 0.01;

header_cutout_w = 8;
header_cutout_h = 50;

header_cutout = [[-0.1,30.5],[nucleo_x-(header_cutout_w)+0.1,30.5]];

base_plate_x = nucleo_x;

base_plate_z = 3;

pt_screw_l = 12;
pt_screw_d = 3;

pt_screw_drill = 3.0 * 0.9;

clearance = 0.3;

drill_hole_y = (27.65+3.35/2);
nucleo_drill_holes = [[10.87,drill_hole_y],[59.129,drill_hole_y],[24.35+(3.25/2),79.8]];

sensor_drill_holes = 2.3;

breadboard_x = 50.0;
breadboard_y = (2.54*6);
breadboard_z = 1.6;

sensor_x = htu21d_x+tsl2591_x+bmp180_x + 10;
sensor_space_x = (nucleo_x - sensor_x)/2;

sensor_max_y = max ( [htu21d_y,tsl2591_y,bmp180_y]);
sensor_min_y = min ( [htu21d_y,tsl2591_y,bmp180_y]);
base_plate_y = nucleo_y2 + 5.0 +  sensor_max_y;

htu21d_y_off = base_plate_y - htu21d_y;
tsl2591_y_off  = base_plate_y - tsl2591_y;
bmp180_y_off = base_plate_y -bmp180_y;

sensor_stand_x = nucleo_x;
sensor_stand_y = sensor_min_y-4;
sensor_stand_z = 23-base_plate_z;


module sensor_boards ()  {
		translate ([sensor_space_x,bmp180_y_off+epsilon,sensor_stand_z+epsilon ]) {
			bmp180(clearance=clearance);
		}
		translate ([sensor_space_x+bmp180_x+5.0, tsl2591_y_off+epsilon,sensor_stand_z+epsilon]) {
			tsl2591(clearance=clearance);
		}
		translate ([sensor_space_x+bmp180_x+tsl2591_x+10.0,htu21d_y_off+epsilon,sensor_stand_z+epsilon]) {
			htu21d(clearance=clearance);
		}
}


module sensor_stand () {
	difference () {
		translate([0,base_plate_y-sensor_stand_y, sensor_z]) {
			cube([sensor_stand_x,sensor_stand_y,sensor_stand_z]);
		}

		sensor_boards();
		// hole for the pt screw to tighten the holder
		translate ([sensor_space_x+bmp180_x+5/2,base_plate_y-(1.55+sensor_drill_holes/2), (sensor_stand_z+base_plate_z)-(pt_screw_l+sensor_z)]) {
			#cylinder(h = pt_screw_l +clearance, r=pt_screw_drill/2.0, $fn=60 ) ;
		}
		// hole for the pt screw to tighten the holder
		translate ([sensor_space_x+bmp180_x+tsl2591_x+5+5/2,base_plate_y-(1.55+sensor_drill_holes/2), (sensor_stand_z+base_plate_z)-(pt_screw_l+sensor_z)]) {
			#cylinder(h = pt_screw_l +clearance, r=pt_screw_drill/2.0, $fn=60 ) ;
		}

		// the two long holes for cables
		translate ([sensor_space_x+2,(base_plate_y+clearance)-sensor_stand_y/2,base_plate_z+3+5 ]) {
			rotate ([90,0,0]) #vertical_tearslot(h=sensor_stand_y +2*clearance,r=5/2,l=8, center = true);
		}

		translate ([base_plate_x-(sensor_space_x+2),(base_plate_y+clearance)-sensor_stand_y/2,base_plate_z+3+5 ]) {
			rotate ([90,0,0]) #vertical_tearslot(h=sensor_stand_y +2*clearance,r=5/2,l=8, center = true);
		}
	}
}

module sensor_holder () {
	difference () {
			union ()  {
					cube([sensor_stand_x,5,5]);
					translate ([0,(5-sensor_drill_holes)/2,5-epsilon]) {
						cube([sensor_stand_x,sensor_drill_holes,2]);
					}
					translate ([0,0,5-epsilon]) {
						cube([sensor_space_x-clearance,5,2]);
					}
					translate ([sensor_stand_x-sensor_space_x+clearance,0,5-epsilon]) {
						cube([sensor_space_x-clearance,5,2]);
					}
					translate ([(sensor_stand_x-sensor_space_x-htu21d_x-5)+clearance,0,5-epsilon]) {
						cube([5.0-2*clearance,5,2]);
					}
					translate ([sensor_space_x+bmp180_x+clearance,0,5-epsilon]) {
						cube([5.0-2*clearance,5,2]);
					}
			}
		translate ([sensor_space_x+bmp180_x+5/2,5/2, -clearance]) {
			#cylinder(h = pt_screw_l +clearance, r=3.2/2.0, $fn=60 ) ;
		}
		translate ([sensor_space_x+bmp180_x+tsl2591_x+5+5/2,5/2, -clearance]) {
			#cylinder(h = pt_screw_l +clearance, r=3.2/2.0, $fn=60 ) ;
		}
	}
}

module spacer_receiving () {
	for(i = nucleo_drill_holes ) {
	translate ([0,0,1.9+clearance]) {
		translate (i)	{
				spacer_receivings();
			}
		}
	}
}

module screw_holes () {
	for(i = nucleo_drill_holes ) {
	translate ([0,0,clearance]) {
		translate (i)	{
				cylinder(h = pt_screw_l +3*clearance, r=((pt_screw_drill)/2), $fn=60 ) ;
			}
		}
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
module spacer_cutouts () {
	for(i = nucleo_drill_holes ) {
		translate (i)  translate([0,0,2]) #spacer_inner_cutout(h=4, clearing=0.3);
	}
}
module base_plate () {
	difference () {
		cube([base_plate_x,base_plate_y,base_plate_z]);
		#header_cutouts ();
		#spacer_cutouts();
	}
}

module breadboard(clearance = 0.0) {
		cube([breadboard_x+2*clearance,breadboard_y+2*clearance,breadboard_z+2*clearance],center=true);
		for (y = [0: 3])
		{
			translate([0,((breadboard_y-3*2.54)/2)-(y*2.54),0]) {
				pin_header(rows=8,cols=1);
			}
		}
}

module breadboard_holder () {
	translate([0,0,(breadboard_y+4)/2]) {
		rotate ([-90,0,0]) {
				difference () {
					cube([breadboard_x+4,breadboard_y+4,breadboard_z+4],center=true);
					translate([0,-((3*2.54/2)),0]) #cube([breadboard_x-2*2.54,breadboard_y-2.54+clearance,breadboard_z+4+2*clearance], center=true);
					translate([0,-(2.54+clearance),0])breadboard(clearance=0.5);
			}
		}
	}
}



translate([base_plate_x/2,base_plate_y+2,0])breadboard_holder ();

base_plate();
spacer_receiving();
sensor_stand();
translate ([0,base_plate_y+ 10,0]) {
	sensor_holder();
}
//sensor_boards();
