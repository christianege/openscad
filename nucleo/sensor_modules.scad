// Sensor modules from Adafruit
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege <k4230r6@gmail.com>


use <pin_headers.scad>;

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
bmp180_holes = [  [2.45,16.55],  [15.15,16.55]  ];


module base_sensor(clearance = 0,  size , holes, drill,rows) {
	echo( "size: ",size[0],size[1],size[2]);
	echo ("holes: ",holes);
	echo("drill: ", drill);
	echo("clearance:",clearance);
	difference () {
		cube(size);
		for(i = holes ) {
			translate ([clearance,clearance,-clearance]) {
				translate (i) {
					#cylinder(h =  size[2]+2*clearance , r=((drill/2)+clearance), $fn=60 ) ;
				}
			}
		}
	}
	translate([(size[0])/2,+1.25,0]) {
		rotate([180,0,0]) {
			pin_header(rows=rows,cols=1);
		}
	}
}


module htu21d (clearance = 0.0,drill=sensor_drill_holes)  {
	base_sensor(clearance = clearance, size=[htu21d_x,htu21d_y,htu21d_z], holes=htu21d_holes, drill=drill,rows=5) ;
}

module tsl2591 (clearance=0.0,drill=sensor_drill_holes )  {
	base_sensor(clearance = clearance, size=[tsl2591_x,tsl2591_y,tsl2591_z], holes=tsl2591_holes, drill=drill,rows=6) ;
}

module bmp180 (clearance=0.0, drill=sensor_drill_holes )  {
	base_sensor(clearance=clearance, size=[bmp180_x,bmp180_y,bmp180_z], holes=bmp180_holes, drill=drill,rows=5) ;
}

//bmp180(clearance=0.2, drill = sensor_drill_holes);
//tsl2591 (clearance=0.2, drill = sensor_drill_holes );
//htu21d(clearance=0.2, drill = sensor_drill_holes );
