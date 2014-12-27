// Holder for the sensor boards
// This will press the sensors with the help of two pt screws against the sensor stand
//
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege <k4230r6@gmail.com>

use <base.scad>

translate ([0,base_plate_y+ 10,0]) {
	sensor_holder();
}