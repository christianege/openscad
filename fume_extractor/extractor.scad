// Solder Fume Extractor - by Nirav Patel <http://eclecti.cc>
//
// This is a parametric solder fume extractor, designed to be used either
// vertically to pull in a larger volume of air or horizontally to have
// stronger suction.  It is a blatant rip off of a Hakko FA-400.
// In the default configuration, it works with a 120mm fan and the filters
// used by the Hakko and similar commercial fume extractors.
//
// This work is licensed under a Creative Commons Attribution 3.0 Unported License.

filter_w = 130;
filter_t = 9;
wall = 3;
fan_w = 120;
fan_r = 63;
fan_hole = 105/2;
fan_hole_r = 2;
angle = 20;
corner = 10;

// grating used to hold both sides of the filter
module grating(w, h, t, holes_x, holes_y, grate_wall) {
    translate([-w/2, -h/2, 0]) {
        difference() {
            cube([w, h, t]);
            for(x = [grate_wall : (w-grate_wall)/holes_x : w-grate_wall]) {
                for(y = [grate_wall : (h-grate_wall)/holes_y : h-grate_wall]) {
                    translate([x, y, 0])
                        cube([(w-grate_wall)/holes_x-grate_wall, (h-grate_wall)/holes_y-grate_wall, t]);
                }
            }
        }
    }
}

union() {
    difference() {
        // main body of filter holder
        translate([-filter_w/2-wall, -filter_w/2-wall, 0])
            cube([filter_w+wall*2, filter_w+wall*2, filter_t+wall*3]);
        difference() {
            // filter area
            translate([-filter_w/2, -filter_w/2, wall])
                cube([filter_w, filter_w, filter_t+wall*2]);
            // cut the corners that'll hold the filter grate in place
            for (x = [-1, 1])
                for (y = [-1, 1])
                    translate([filter_w/2*x, filter_w/2*y, filter_t+wall*2])
                        rotate([0, 0, 45])
                            translate([-corner, -corner, 0])
                                cube([corner*2, corner*2, wall]);
        }
        // fan air hole   
        intersection() {
            translate([-fan_w/2, -fan_w/2, 0])
                cube([fan_w, fan_w, wall]);
            cylinder(h = wall, r = fan_r);
        }
        // fan bolt holes
        for (x = [-1, 1])
            for (y = [-1, 1])
                translate([x*fan_hole, y*fan_hole, 0])
                    cylinder(h = wall, r = fan_hole_r);
    }
    // grating on the fan side of the filter
    grating(fan_w, fan_w, wall, 6, 6, 2);
    // the angled housing
    intersection() {
        translate([-filter_w/2-wall, -filter_w/2-wall, filter_t+wall*3]) {
            rotate([-angle, 0, 0]) {
                union() {
                    difference() {
                        union() {
                            cube([filter_w+wall*2, (filter_w+wall*2)*cos(angle), (filter_w+wall*2)*sin(angle)]);
                            // extra little angled feet
                            for (x = [0, filter_w+wall])
                                translate([x, 0, -(filter_t+wall*3)/cos(angle)])
                                    cube([wall, (filter_w+wall*2)*cos(angle), (filter_t+wall*3)/cos(angle)]);
                        }
                        // hollow the inside
                        translate([wall, wall, 0])
                           cube([filter_w, filter_w, (filter_w+wall*2)*sin(angle)]);
                        // make an opening for the grating
                        rotate([90, 0, 0])
                            translate([wall, 0, -2*wall])
                                cube([filter_w, (filter_w+wall*2)*sin(angle)*0.75, 3*wall]);
                    }
                    // the air intake for horizontal orientation
                    rotate([90, 0, 0])
                        translate([filter_w/2+wall, (filter_w+wall*2)*sin(angle)*0.75/2, -wall])
                            grating(filter_w, (filter_w+wall*2)*sin(angle)*0.75, wall, 3, 1, 4);
                }
            }
        }
        // cut off the bits that are outside our working area
        translate([-filter_w/2-wall, -filter_w/2-wall-50, 0])
            cube([filter_w+wall*2, filter_w+wall*2+50, filter_t+wall*3+(filter_w+wall*2)*tan(angle)]);
    }
}

// the filter grate on the intake side
translate([filter_w+wall+30, 0, 0])
    grating(filter_w-2, filter_w-corner*sqrt(2), wall, 6, 6, 2);
