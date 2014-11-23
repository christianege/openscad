// Base Plate for the STMicroelectronics Nucleo board
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege <k4230r6@gmail.com>

include <pin_headers.scad>;

nucleo_x = 70;
nucleo_y1 = 80.50;
nucleo_y2 = 82.50;
nucleo_z = 1.6;

header_cutout_w = 6;
header_cutout_h = 48.1;

header_cutout = [[1.3,30.5],[nucleo_x-(2.3+header_cutout_w)+1,30.5]];

base_plate_z = 3;

pt_screw_l = 12;
pt_screw_d = 3;

clearance = 0.3;

drill_hole_y = (27.65+3.35/2);
nucleo_drill_holes = [[10.87,drill_hole_y],[59.129,drill_hole_y],[24.35+(3.25/2),76.725]];

sensor_drill_holes = 2.6;

// Humidity
htu210_x = 16.5;
htu210_y = 18.2;
htu210_z = 1.6;
htu210_holes = [  [1.3+sensor_drill_holes/2,1.3+sensor_drill_holes/2],  [12.6+sensor_drill_holes/2,1.3+sensor_drill_holes/2]];

// Lux - Sensor
tsl2591_x = 19.1;
tsl2591_y = 16.4;
tsl2591_z = 1.6;
tsl2591_holes = [ [1.3+sensor_drill_holes/2,1.55+sensor_drill_holes/2],  [14.00+sensor_drill_holes/2,1.55+sensor_drill_holes/2] ];

// Presure Sensor
bmp180_x = 17.6;
bmp180_y = 19.3;
bmp180_z = 1.6;
bmp180_holes = [  [1.3+sensor_drill_holes/2,1.55+sensor_drill_holes/2],  [14.00+sensor_drill_holes/2,1.55+sensor_drill_holes/2]  ];

sensor_x = htu210_x+tsl2591_x+bmp180_x + 10;
sensor_space_x = (nucleo_x - sensor_x)/2;


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
	translate([(htu210_x)/2,htu210_y-1.25,+htu210_z]) {
		pin_header(rows=5,cols=1); 
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
	translate([(tsl2591_x)/2,tsl2591_y-1.25,+tsl2591_z]) {
		pin_header(rows=6,cols=1); 
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
	translate([(bmp180_x)/2,bmp180_y-1.25,+bmp180_z]) {
		pin_header(rows=5,cols=1); 
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
		cube([nucleo_x,nucleo_y2,base_plate_z]);
		#header_cutouts ();
	}
}



base_plate();
stand_bolts();

translate ([sensor_space_x,nucleo_y2+5,0]) {
	bmp180();
}

translate ([sensor_space_x+bmp180_x+5.0,nucleo_y2+5,0]) {
	htu210();
}

translate ([sensor_space_x+bmp180_x+htu210_x+10.0,nucleo_y2+5,0]) {
	tsl2591();
}


