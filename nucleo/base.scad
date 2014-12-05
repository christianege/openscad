// Base Plate for the STMicroelectronics Nucleo board
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege <k4230r6@gmail.com>

include <pin_headers.scad>;

nucleo_x = 70;
nucleo_y1 = 80.50;
nucleo_y2 = 82.50;
nucleo_z = 1.6;

epsilon = 0.01;

header_cutout_w = 6;
header_cutout_h = 48.1;

header_cutout = [[1.3,30.5],[nucleo_x-(2.3+header_cutout_w)+1,30.5]];

base_plate_x = nucleo_x;

base_plate_z = 3;

pt_screw_l = 12;
pt_screw_d = 3;

pt_screw_drill = 3.0 * 0.8;

clearance = 0.3;

drill_hole_y = (27.65+3.35/2);
nucleo_drill_holes = [[10.87,drill_hole_y],[59.129,drill_hole_y],[24.35+(3.25/2),76.725]];

sensor_drill_holes = 2.3;

breadboard_x = 50.0;
breadboard_y = (2.54*6);
breadboard_z = 1.6;



sensor_z = 1.6;

// Humidity
htu210_x = 16.5+2*clearance;
htu210_y = 18.2;
htu210_z = sensor_z;
htu210_holes = [  [1.3+sensor_drill_holes/2,htu210_y-(1.3+sensor_drill_holes/2)],  [12.6+sensor_drill_holes/2,htu210_y-(1.3+sensor_drill_holes/2)]];

// Lux - Sensor
tsl2591_x = 19.1+2*clearance;
tsl2591_y = 16.4;
tsl2591_z = sensor_z;
tsl2591_holes = [ [1.3+sensor_drill_holes/2,tsl2591_y-(1.55+sensor_drill_holes/2)],  [14.00+sensor_drill_holes/2,tsl2591_y-(1.55+sensor_drill_holes/2)] ];

// Presure Sensor
bmp180_x = 17.6+2*clearance;
bmp180_y = 19.3;
bmp180_z = sensor_z;
bmp180_holes = [  [1.3+sensor_drill_holes/2,bmp180_y-(1.55+sensor_drill_holes/2)],  [14.00+sensor_drill_holes/2,bmp180_y-(1.55+sensor_drill_holes/2)]  ];

sensor_x = htu210_x+tsl2591_x+bmp180_x + 10;
sensor_space_x = (nucleo_x - sensor_x)/2;


sensor_max_y = max ( [htu210_y,tsl2591_y,bmp180_y]);
sensor_min_y = min ( [htu210_y,tsl2591_y,bmp180_y]);
base_plate_y = nucleo_y2 + 5.0 +  sensor_max_y;

htu210_y_off = base_plate_y - htu210_y;
tsl2591_y_off  = base_plate_y - tsl2591_y;
bmp180_y_off = base_plate_y -bmp180_y;

sensor_stand_x = nucleo_x;
sensor_stand_y = sensor_min_y-4;
sensor_stand_z = 23-base_plate_z;


module sensor_boards ()  {
		translate ([sensor_space_x,bmp180_y_off+epsilon,sensor_stand_z+epsilon ]) {
			bmp180();
		}
		translate ([sensor_space_x+bmp180_x+5.0, tsl2591_y_off+epsilon,sensor_stand_z+epsilon]) {
			tsl2591();
		}
		translate ([sensor_space_x+bmp180_x+tsl2591_x+10.0,htu210_y_off+epsilon,sensor_stand_z+epsilon]) {
				htu210();
		}
}


module sensor_stand () {
	difference () {
		translate([0,base_plate_y-sensor_stand_y, sensor_z]) {
			cube([sensor_stand_x,sensor_stand_y,sensor_stand_z]);
		}

		sensor_boards();
		translate ([sensor_space_x+bmp180_x+5/2,base_plate_y-(1.55+sensor_drill_holes/2), (sensor_stand_z+base_plate_z)-(pt_screw_l+sensor_z)]) {
			#cylinder(h = pt_screw_l +clearance, r=pt_screw_drill/2.0, $fn=60 ) ;
		}
		translate ([sensor_space_x+bmp180_x+tsl2591_x+5+5/2,base_plate_y-(1.55+sensor_drill_holes/2), (sensor_stand_z+base_plate_z)-(pt_screw_l+sensor_z)]) {
			#cylinder(h = pt_screw_l +clearance, r=pt_screw_drill/2.0, $fn=60 ) ;
		}

		translate ([sensor_space_x+bmp180_x/2,base_plate_y+clearance,sensor_stand_z/2 ]) {
			rotate ([90,0,0]) #cylinder(h = sensor_stand_y +2*clearance, r=pt_screw_drill/2.0, $fn=60 ) ;
		}

		translate ([base_plate_x-(sensor_space_x+htu210_x/2),base_plate_y+clearance,sensor_stand_z/2 ]) {
			rotate ([90,0,0]) #cylinder(h = sensor_stand_y +2*clearance, r=pt_screw_drill/2.0, $fn=60 ) ;
		}

		translate ([base_plate_x/2,base_plate_y+clearance,sensor_stand_z/2 ]) {
			rotate ([90,0,0]) #cylinder(h = sensor_stand_y +2*clearance, r=pt_screw_drill/2.0, $fn=60 ) ;
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
					translate ([(sensor_stand_x-sensor_space_x-htu210_x-5)+clearance,0,5-epsilon]) {
						cube([5.0-2*clearance,5,2]);
					}
					translate ([sensor_space_x+bmp180_x+clearance,0,5-epsilon]) {
						cube([5.0-2*clearance,5,2]);
					}
			}
		translate ([sensor_space_x+bmp180_x+5/2,5/2, -clearance]) {
			#cylinder(h = pt_screw_l +clearance, r=pt_screw_drill/2.0, $fn=60 ) ;
		}
		translate ([sensor_space_x+bmp180_x+tsl2591_x+5+5/2,5/2, -clearance]) {
			#cylinder(h = pt_screw_l +clearance, r=pt_screw_drill/2.0, $fn=60 ) ;
		}
	}
}

module htu210 ()  {
	difference () {
		cube([htu210_x,htu210_y,htu210_z]);
		for(i = htu210_holes ) {
			translate ([0,0,-clearance]) {
				translate (i) {
					#cylinder(h = ( htu210_z+2*clearance) , r=(((sensor_drill_holes)/2)+clearance), $fn=60 ) ;
				}
			}
		}
	}
	translate([(htu210_x)/2,+1.25,0]) {
		rotate([180,0,0]) {
			pin_header(rows=5,cols=1);
		}
	}
}

module tsl2591 ()  {
	difference () {
		cube([tsl2591_x,tsl2591_y,tsl2591_z]);
		for(i = tsl2591_holes ) {
			translate ([0,0,-clearance]) {
				translate (i) {
					#cylinder(h = ( tsl2591_z+2*clearance) , r=(((sensor_drill_holes)/2)+clearance), $fn=60 ) ;
				}
			}
		}
	}
	translate([(tsl2591_x)/2,+1.25,0]) {
		rotate([180,0,0]) {
			pin_header(rows=6,cols=1);
		}
	}
}

module bmp180 ()  {
	difference () {
		cube([bmp180_x,bmp180_y,bmp180_z]);
		for(i = bmp180_holes ) {
			translate ([0,0,-clearance]) {
				translate (i) {
					#cylinder(h = ( bmp180_z+2*clearance) , r=(((sensor_drill_holes)/2)+clearance), $fn=60 ) ;
				}
			}
		}
	}
	translate([(bmp180_x)/2,+1.25,0]) {
		rotate([180,0,0]) {
			pin_header(rows=5,cols=1);
		}
	}
}

module screw_receiving () {
	for(i = nucleo_drill_holes ) {
	translate ([0,0,1]) {
		translate (i)	{
				cylinder(h = (pt_screw_l +clearance)-nucleo_z , r=(((pt_screw_d*0.8)/2)+1.4), $fn=60 ) ;
			}
		}
	}
}

module screw_holes () {
	for(i = nucleo_drill_holes ) {
	translate ([0,0,clearance+1]) {
		translate (i)	{
				cylinder(h = pt_screw_l +2*clearance, r=((pt_screw_d*0.8)/2), $fn=60 ) ;
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
		cube([base_plate_x,base_plate_y,base_plate_z]);
		#header_cutouts ();
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
					translate([0,-(2.54+clearance),0])breadboard(clearance=0.3);
			}
		}
	}
}



breadboard_holder ();

/**
base_plate();
stand_bolts();
sensor_stand();
translate ([0,base_plate_y+ 10,0]) {
	sensor_holder();
}
**/
//sensor_boards();


