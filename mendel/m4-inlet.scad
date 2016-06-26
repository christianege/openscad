
c=3;
a = sqrt(c*c/2);
dim_y = 10;
dim_x = 19;
for(y=[0,dim_y-c]) {
    translate([0,y,0]) {
        rotate([45,0,0]){
            cube([dim_x,a,a]);
        }
    }
}
cube([dim_x,dim_y-c,c]);