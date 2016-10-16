// This is a debug card holder
// Copyright (C) 2016  Christian Ege
//
// This program is free software: you can redistribute it and/or modify
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
// along with this program.  If not, see <http://www.gnu.org/

include <../utils/teardrops.scad>

delta=45.6-5.7;
size_y=12.8;
size_x=54;

hole_height=[28,30];
hole_distance=32-3.3;
board_y_offset=21;
base_height=4;

m4_nut_r=7.66/2;
m4_nut_height=3;

module base_plate() {
    
    difference() {
        hull() {
            for(i = [-1,1]) {
                translate([i*((delta/2)+m4_nut_r+2),0,0]) {
                    cylinder(r=base_height/2,h=size_y,$fn=100);
                }
            }
        }
        for(j = [-1,1]) {
            translate([j*delta/2,3,size_y/2]) {
                rotate([90,0,0]) {
                    #teardrop(h=6,r=4.5/2,$fn=100);
                }
            }
            translate([j*delta/2,m4_nut_height,size_y/2]) {
                rotate([90,0,0]) {
                    #cylinder(r=m4_nut_r+0.3,h=m4_nut_height,$fn=6);
                }
            }
        }
    }
}

module leg() {
    stand_width=16;
    stand_height=40;
    pt_srew_head_r=5.2/2;
    pt_srew_head_h=2.2;
    pt_screw_r=2.8/2;
    slot_offset = 26;
    
    difference() {
        hull() {
            for(i=[-1,1])
            translate([i*(stand_width/2),stand_height,0]){
                    cylinder(r=4/2,h=base_height-1.5,$fn=100);
            }
            translate([-(stand_width+5)/2,0,0]) {
                    #cube([stand_width+5,0.1,base_height-1.5]);
            }
            translate([-base_height/2,0,0])cube([base_height,0.1,size_y-1.5*base_height]);
        }
        for(k=[-1,1]) {
            hull() {
                for(j = [stand_height-pt_srew_head_r,slot_offset]) {
                    translate([k*pt_srew_head_r*2,j,-0.1]) {
                        cylinder(r=pt_screw_r+0.5,h=10,$fn=60);
                    }
                }
            }
            hull() {
                for(j = [stand_height-pt_srew_head_r,slot_offset]) {
                    translate([k*pt_srew_head_r*2,j,base_height-pt_srew_head_h]) {
                        cylinder(r=pt_srew_head_r+0.5,h=10,$fn=60);
                    }
                }

            }
        }
    }
}

base_plate();
translate([+7,0,0]) {
    leg();
}