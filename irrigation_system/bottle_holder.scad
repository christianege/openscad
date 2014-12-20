// Holder for wine bottles
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege


wineBottleBodyDiameter = 87;
wineBottleNeckDiameter1 = 31;
wineBottleNeckDiameter2 = 32;

clearance = 0.2;
holder_ring_x = 10;
holder_ring_y= 10;
holder_ring_z = 10;
holder_path_z = 10;
holder_path_x = 25;
holder_path_y = ((wineBottleBodyDiameter -wineBottleNeckDiameter2) /2.0)+20+2;
uholder_path_y = 25;

stand_x = 95;
stand_y = 120;
stand_z = 8;

threadedRodHole = 8.0+clearance;

module lower_ring() {
	difference() {
		cylinder(h = holder_ring_z, r=((wineBottleNeckDiameter1+2*holder_ring_y )/2.0)+clearance, $fn=60);
		translate([0,0,-clearance]) {
			cylinder(h = holder_ring_z+2*clearance, r1=(wineBottleNeckDiameter1/2.0)+clearance, r2=(wineBottleNeckDiameter2/2.0)+clearance, $fn=60);
		}
	}

}

module upper_ring() {
	difference() {
		cylinder(h = holder_ring_z, r=((wineBottleBodyDiameter+2*holder_ring_y )/2.0)+clearance, $fn=60);
		translate([0,0,-clearance]) {
			cylinder(h = holder_ring_z+2*clearance, r=(wineBottleBodyDiameter/2.0)+clearance, $fn=60);
		}
	}

}


module lower_path() {
	difference() {
		cube(size = [holder_path_x,holder_path_y,holder_path_z], center = true);
	}
}

module upper_path() {
		#cube(size = [holder_path_x,uholder_path_y,holder_path_z], center = true);
}


module lower_holder() {
	difference () {
		union () {
			lower_ring();
			translate([0,-((holder_path_y+wineBottleNeckDiameter2)/2.0)-2,holder_path_z /2.0]) {
				lower_path();
			}
		}
			drill_hole();

		}
}

module upper_holder() {
	difference () {
		union () {
			upper_ring();
			translate([0,-((uholder_path_y+wineBottleBodyDiameter)/2.0 +2 ),holder_path_z /2.0]) {
				upper_path();
			}
			translate([0,(wineBottleBodyDiameter)/2 +holder_ring_y+4 ,holder_ring_z/2 ])
				cube(size = [15,holder_ring_y+2*clearance,holder_ring_z], center = true);
		}
		drill_hole();
		translate([0,(wineBottleBodyDiameter+holder_ring_y)/2 +clearance ,holder_ring_z/2 + clearance ]) #cube(size = [5,holder_ring_y+20+2*clearance,holder_ring_z+2*clearance], center = true);

		translate([-50,(wineBottleBodyDiameter)/2 +holder_ring_y+4 ,holder_ring_z/2 + clearance ]) {
			rotate ([0,90,0])  cylinder(h=100+2*clearance ,r=3.5/2.0, $fn=60);
		}
		translate([+7.5-2.5,(wineBottleBodyDiameter)/2 +holder_ring_y+4 ,holder_ring_z/2 + clearance ])
			rotate ([0,90,0])  cylinder(h=100+2*clearance ,r=6.8/2.0, $fn=6);


		}
}


module drill_hole () {
		translate([0,-(wineBottleBodyDiameter/2+10+threadedRodHole/2) ,-(holder_path_z/2)]) {
			#cylinder(h=100+2*clearance ,r=threadedRodHole/2.0, $fn=60);
		}
	}
module stand () {
	difference () {
		union () {
			translate([0,-holder_path_y/2,0]) cube(size = [stand_x,stand_y,stand_z], center = true);
			translate([0,-(wineBottleBodyDiameter/2+10+threadedRodHole/2),0] ) cylinder(h=50 ,r2=threadedRodHole/2.0 +5, r1=threadedRodHole/2.0 +8, $fn=60);


		}
		drill_hole();
		translate( [0,-(wineBottleBodyDiameter/2+10+threadedRodHole/2),-(stand_z/2+clearance)]) #cylinder(h=7.5 ,r=14.7/2+clearance, $fn=6);

		for ( i = [-10	:1.0: 35] )
		{
			translate( [0,i,-(stand_z/2+clearance)]) #cylinder(h=stand_z+2*clearance ,r=25, $fn=50);
		}

	}
}

module triangle () {
	b = 15;
	h = 50;
	w = 5;
	rotate(a=[90,-90,0]) {
		linear_extrude(height = w, center = true, convexity = 10, twist = 0)
			polygon(points=[[0,0],[h,0],[0,b]], paths=[[0,1,2]]);
	}
}

module base () {

	translate([-((threadedRodHole/2.0 +5)-clearance),-(wineBottleBodyDiameter/2+10+threadedRodHole/2),0 ]) triangle();
	translate([+((threadedRodHole/2.0 +5)-clearance),-(wineBottleBodyDiameter/2+10+threadedRodHole/2),0 ])
		rotate([0,0,180])triangle();

	translate([0,-(wineBottleBodyDiameter/2+(10-threadedRodHole/2)),0 ])
		rotate([0,0,270])triangle();

	translate([0,-(wineBottleBodyDiameter/2+10+threadedRodHole+5),0 ])
		rotate([0,0,90])triangle();


	translate([0,-(wineBottleBodyDiameter/2+10+threadedRodHole/2) ,7.5-0.5 ])
	cylinder(h=0.1 ,r=14.5/2+clearance, $fn=10);

translate ([0,0,stand_z/2]) stand();
}

base();
//lower_holder();
//upper_holder();
//lower_path();