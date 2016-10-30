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

// Pumpking scraper

outer_diameter = 100;
height = 2;
blade_offset = 3;
epsilon=0.3;

difference() {
    hull() {
        cylinder(r=outer_diameter/2,h=epsilon,$fn=100);
        translate([0,blade_offset,height])cylinder(r=(outer_diameter-height)/2,h=epsilon,$fn=100);
    }
    translate([-outer_diameter,0,-epsilon])cube([2*outer_diameter,outer_diameter,height*2]);
}