// Base Plate for the STMicroelectronics Nucleo board
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege <k4230r6@gmail.com>

sensor_drill_holes = 2.3;
sensor_z = 1.6;

// Humidity
htu21d_x = 16.5;
htu21d_y = 18.2;
htu21d_z = sensor_z;
htu21d_holes = [  [2.45,15.75],  [13.75,15.75]];

// Lux - Sensor
tsl2591_x = 19.1;
tsl2591_y = 16.4;
tsl2591_z = sensor_z;
tsl2591_holes = [ [2.45,13.7],  [15.15,13.7] ];

// Presure Sensor
bmp180_x = 17.6;
bmp180_y = 19.3;
bmp180_z = sensor_z;
bmp180_holes = [  [2.45,17.0],  [15.15,17.0]  ];


module htu21d (clearance = 0.0)  {
	difference () {
		cube([htu21d_x,htu21d_y,htu21d_z]);
		for(i = htu21d_holes ) {
			translate ([0,0,-clearance]) {
				translate (i) {
					#cylinder(h = ( htu21d_z+2*clearance) , r=(((sensor_drill_holes)/2)+clearance), $fn=60 ) ;
				}
			}
		}
	}
	translate([(htu21d_x)/2,+1.25,0]) {
		rotate([180,0,0]) {
			pin_header(rows=5,cols=1);
		}
	}
}

module tsl2591 (clearance=0.0 )  {
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

module bmp180 (clearance=0.0)  {
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
