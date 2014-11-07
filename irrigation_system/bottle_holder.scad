// Enclosure for the Olimex AX0-OLinuXino-LIME board
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege 


wineBottleBodyDiameter = 95;
wineBottleNeckDiameter1 = 31;
wineBottleNeckDiameter2 = 32;

clearance = 0.4;
holder_ring_x = 10;
holder_ring_y= 10;
holder_ring_z = 10;
holder_path_z = 10;
holder_path_x = 20;
holder_path_y = ((wineBottleBodyDiameter -wineBottleNeckDiameter2) /2.0)+20+2;

threadedRodHole = 8.0+clearance;

module lower_ring() {
	difference() {
		cylinder(h = holder_ring_z, r=((wineBottleNeckDiameter1+2*holder_ring_y )/2.0)+clearance, $fn=60);
		translate([0,0,-clearance]) {
			cylinder(h = holder_ring_z+2*clearance, r1=(wineBottleNeckDiameter1/2.0)+clearance, r2=(wineBottleNeckDiameter2/2.0)+clearance, $fn=60);
		}
	}
	
}

module lower_path() {
	difference() {
		cube(size = [holder_path_x,holder_path_y,holder_path_z], center = true);
		translate([0,-((holder_path_y/2.0))+20/2,-((holder_path_z/2))-clearance]) {
			#cylinder(h=holder_path_z+2*clearance ,r=threadedRodHole/2.0, $fn=60);
		}
	}
}

module lower_holder() {
	lower_ring();
	translate([0,-((holder_path_y+wineBottleNeckDiameter2)/2.0)-2,holder_path_z /2.0]) {
		lower_path();
	}
}

lower_holder();
