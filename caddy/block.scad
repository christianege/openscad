// Copyright (c) 2016 Christian Ege <ch@ege.io>
// 
// This file is part of my OpenSCAD stuff
// 
// This is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
// 
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.


stand_r=28/2;
hole_r=25/2;
pin_r=23/2;
edge_r=5/2;
pin_off_x=12+pin_r;

dim_z=8;
dim_x=50+edge_r;
dim_y=60;

cylinders=[ 
                       [dim_x,dim_y/2,1],
                       [edge_r,dim_y/2,1],
                       [dim_x,-dim_y/2,1],
                       [edge_r,-dim_y/2,1],
                       [edge_r,-dim_y/4,dim_z],
                       [edge_r,dim_y/4,dim_z]
];


difference() {
	hull() {
		translate([pin_off_x,0,-0.1])cylinder(r=stand_r,h=dim_z);
		for(i=cylinders) {
			translate([i[0],i[1],0]) {
				cylinder(r=edge_r,h=i[2],$fn=60);
			}
		}
	}
	translate([pin_off_x,0,-0.2]){
		cylinder(r=hole_r,h=dim_z+2);
	}

	translate([0,0,0]){
		rotate([0,45,0])#cube([0.9,100,0.9],center=true);
	}


}
