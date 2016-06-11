rad_s = 400/2;
rad_c = 80/2;

c = rad_s;
b = rad_c;
a= sqrt(c*c-b*b);

h = 6;

$fn=300;

m_x=70;
m_y=40;
m_z=6;

d_h = 6.6;
di_h = 45.6-d_h;


angle=[356,4];
m = [1,-1];
module base() {
    translate([0,0,(h-a)]) {
        difference() {
            intersection() {
                sphere(r=rad_s);
                cylinder(r=rad_c, h=rad_s+10);
            }
            translate([0,0,-1])cylinder(r=rad_c+1, h=a+1);
        }
    }
    cylinder(r=rad_c, h=h);
}
module top() {
    difference () {
        base();
        for(j=[60,180,300]) {
            rotate([0,0,j]) {
                translate([0,25,-1]) {
                    cylinder(r=3.5/2,h=100,$fn=60);
                }
                translate([0,25,1]) {
                    cylinder(r=6.8/2,h=100,$fn=60);
                }
            }
        }
        plate();
    }
}

module plate() {
    for( j = [0,1]) {
    rotate([angle[j],0,0]) {
        translate([0,m[j]*25,5+m_z/2]) {
                cube([m_x,m_y,m_z],center=true);
            }
        }
    }
}
top();

