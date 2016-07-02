// Elliptical Nose Cone Designer
// By ProfWunder http://www.thingiverse.com/thing:507830
// is licensed under the Creative Commons - Attribution - Share Alike license. 
// 
// Modified by Christian Ege <ch@ege.io>


//Course render = 2, Fine render = 0.3
$fs=0.3;

//Std Estes diameters (in inches):
NC_5 = 0.541;
NC_20 = 0.736;
NC_50 = 0.976;
NC_55 = 1.325;
NC_60 = 1.637;
dia = 35.5/25.4;

//Leave these as is
$fn=0;
$fa=0.01;

//Set shoulder length in inches
slen = 0.2;

//Set ratio (len / dia)
ratio = 2;

//Convert to metric, calc shoulder
rad = dia/2*25.4;
h=ratio*rad*4;
sht=slen*25.4;
shr=(dia-.028)/2*24.5;
shr2=shr-0.5;

//Build nose cone
translate([0,0,sht-1]){
	difference(){
		resize([0,0,h]) sphere (r = rad);
		resize([0,0,h-2]) sphere (r = rad-1);
		translate([0,0,-h/2]) cylinder(r = rad, h = h/2);
	}
}


//Add shoulder
difference(){
	cylinder(r1=shr2, r2=shr, h=sht);
	cylinder(r=shr2-1, h=sht);
}

/*
//Add Shock Cord Attachment
rotate ([90,0,0]){
	translate ([0,2,-shr+1]){
		cylinder (r=2, h=shr*2-2);
	}
}
*/