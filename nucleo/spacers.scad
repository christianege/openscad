// Receiving for the spacers
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege <k4230r6@gmail.com>

receiving_z = 1.6;
spacer_d = 4.6;

module spacer_receivings(h=4)  {
		clearing = 0.2;

		receiving_d = spacer_d + 2.5;

		drill = 3.2-clearing;
		height = max(4,h);

		difference() {
			cylinder(h=height, r=receiving_d/2, $fn=30);
			spacer_inner_cutout(h=height);
			translate([0,0,height-(receiving_z)]) #cylinder(h=receiving_z +clearing, r=drill/2, $fn=30);
		}
		// this is to aviod support structures
		translate([0,0,height-(receiving_z +clearing)]) #cylinder(h=clearing, r=spacer_d/2, $fn=30);

}

module spacer_inner_cutout(h=4, clearing = 0.2) {
			height = max(4,h);
			translate([0,0,-clearing]) cylinder(h=height-receiving_z +clearing, r=spacer_d/2, $fn=30);

}

spacer_receivings();