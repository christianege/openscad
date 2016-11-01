//    Shutter stop
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

layerheight = 0.25;
epsilon=layerheight;
height=2;
width = 15;
length=30;

module stiffener_leg() {
    radius=(width/2)/2;
    leg=length-radius-height-epsilon;
    cut=[5,width,20];
    difference() {
        hull() {
            translate([0,-width/2,0]) {
                cube([epsilon,width,epsilon]);
                
            }
            translate([0,-(width/2.5)/2,0]) {
                cube([epsilon,width/2.5,2]);
            }
            translate([leg,0,0]) {
                cylinder(r=radius,h=epsilon,$fn=100);
            }
        }
        rotate([0,45,0]) {
            translate([-cut[0],-width/2,-cut[2]/2]) {
            cube(cut);
            }
        }
    }
}

module base_leg() {
hull() {
        for(i=[0,1]) {
            translate([0,-i*length,0])cylinder(r=height/2,h=width,$fn=100);
        }
    }
}

module base() {
    translate([height/2,-height/2,0]) {
        base_leg();
        rotate([0,0,90]) base_leg();
    }
}

module stiffener() {
    translate([height-(epsilon),0,height-(epsilon)]) {
        stiffener_leg();
        rotate([0,270,180]) stiffener_leg();
    }
}

module base_block() {
    translate([0,0,width/2]) {
        rotate([90,0,0]) {
            stiffener();
        }
    }
    base();
}

module hole(r=2.8/2,h=5*height) {
    rotate([90,0,90])teardrop(h=h,r=r,$fn=100);
    translate([height+epsilon,0,0]) {
        rotate([90,0,90])cylinder(h=h,r=(5.45+1.5*epsilon)/2,$fn=6);
    }
}

module shutter_stop() {
    difference() {
        base_block();
        for(i=[length-6,8+height]) {
            hole_l=5*height;
            translate([-(epsilon+0.8),-i,width/2]) {
                hole(h=hole_l);
            }
        }
    }
}

shutter_stop();