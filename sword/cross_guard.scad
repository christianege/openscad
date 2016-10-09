//    This is a sword`s cross guard
//    Copyright (C) 2016  Christian Ege
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU Affero General Public License as
//    published by the Free Software Foundation, either version 3 of the
//    License, or (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU Affero General Public License for more details.
//
//    You should have received a copy of the GNU Affero General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.

include <../utils/teardrops.scad>

inner_cube_x=15+8;
inner_cube_y=29;
height=8;

cut_out_x=15.2+0.5;
cut_out_y=29.5+0.5;

difference() {
    hull() {
        translate([0,50,0])cylinder(r=3,h=height,$fn=100);
        translate([0,-50,0])cylinder(r=3,h=height,$fn=100);
        translate([-inner_cube_x/2,-inner_cube_y/2,0])cube([inner_cube_x,inner_cube_y,height]);
    }
    translate([-cut_out_x/2,-cut_out_y/2,-0.5])cube([cut_out_x,cut_out_y,height+1]);
    translate([-(inner_cube_x+10)/2,0,height/2])rotate([90,0,90])#teardrop(h=inner_cube_x+10,r=3/2,$fn=100);
}