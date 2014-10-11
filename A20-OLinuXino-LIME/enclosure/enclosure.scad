// Enclosure for the Olimex AX0-OLinuXino-LIME board
// License GNU AFFERO GENERAL PUBLIC LICENSE v3+
// Copyright 2014 Christian Ege 


clearance=0.8;
// minimum wall width 
wall_width=1.6; 
layer_height=0.2;

lime_board_x = 83.96;
lime_board_y = 59.6;
lime_board_z = 2.00;

lime_notch_diameter = 0.0;
lime_notches = [ 
				[ 21.55, 0.0 ],
				[43.01, 0.0 ],
				[ 21.55, 0.0 ],
				[43.01, 0.0 ]
];

lime_drill_holes = [
						[0.0,	15.80],
						[0.0, 55.18]
];

module lime_pcb() {
	color("red") {
		cube([lime_board_x,lime_board_y,lime_board_z]);
	}
}

lime_pcb();