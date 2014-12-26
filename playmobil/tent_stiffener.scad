// Stiffener for Playmobil Camping Iglu tent 5435
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege <k4230r6@gmail.com>

$fn=50;
difference () {
	minkowski()
	{
		cube([128,138,3]);
		cylinder(r=2,h=1);
	}
	translate ([4,4,-0.1]) {
		minkowski()
		{
			cube([120,130,3.2]);
			cylinder(r=2,h=1);
		}
	}
}