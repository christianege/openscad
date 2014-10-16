layer_height = 0.2;
epsilon = 0.001;
clearance = 0.3;

pt_screw_head_z = 2.2;
pt_screw_d1 = 3.0;
pt_screw_d2 = 5.5+clearance;
pt_screw_L = 12;
pt_screw_drill =  pt_screw_d1 * 0.9;

min_wall_z = layer_height*4.0;
min_wall_thikness = 1.6; 

mounting_support_r = 2.5;

matchbox_x = 50;
matchbox_y = 35;
matchbox_edge_r = 2;

completion_x =  matchbox_x-((2*min_wall_thikness));
completion_y = matchbox_y-((2*min_wall_thikness));
completion_z = pt_screw_head_z+clearance+min_z_wall;

matchbox_z = max(15,pt_screw_L - (completion_z));


cutout_x =  matchbox_x-(4*min_wall_thikness);
cutout_y = matchbox_y-(4*min_wall_thikness);
cutout_z = matchbox_z-(min_wall_z+clearance);






completion_z = min_wall_z + pt_screw_head_z;

module matchbox_body_perimeter () {
	minkowski()
	{
		cube([matchbox_x-(2*matchbox_edge_r),matchbox_y-(2*matchbox_edge_r),matchbox_z]);
		translate([matchbox_edge_r,matchbox_edge_r,0])  cylinder(r=matchbox_edge_r, h=0.01,$fn=50);
	}
}

module matchbox_completion_cutout (x,y,z,r) {
	minkowski()
	{
		cube([x-(2*r)+clearance,y-(2*r)+clearance,z+clearance]);
		translate([r+min_wall_thikness,r+min_wall_thikness,-epsilon])  cylinder(r=r, h=epsilon,$fn=50);
	}
}

module matchbox_completion (x,y,z,r) {
	
	difference() {
		union() {
			minkowski()
			{	
				cube([x-(2*r),y-(2*r),z]);
				translate([r+min_wall_thikness,r+min_wall_thikness,0])  cylinder(r=r, h=epsilon,$fn=50);
			}
		}
		completion_holes(x=(3*min_wall_thikness),y=(3*min_wall_thikness),rd=(pt_screw_d1)/2,h=completion_z+2*clearance);
		completion_holes(x=matchbox_x -(3*min_wall_thikness),y=(3*min_wall_thikness),rd=(pt_screw_d1)/2,h=completion_z+2*clearance);
		completion_holes(x=matchbox_x -(3*min_wall_thikness),y=matchbox_y -(3*min_wall_thikness),rd=(pt_screw_d1)/2,h=completion_z+2*clearance);
		completion_holes(x=(3*min_wall_thikness),y=matchbox_y -(3*min_wall_thikness),rd=(pt_screw_d1)/2,h=completion_z+2*clearance);
		#completion_screw_head(x=(3*min_wall_thikness),y=(3*min_wall_thikness),rd=pt_screw_d2/2,h=pt_screw_head_z+clearance+epsilon);
		#completion_screw_head(x=matchbox_x-(3*min_wall_thikness),y=(3*min_wall_thikness),rd=pt_screw_d2/2,h=pt_screw_head_z+clearance+epsilon);
		#completion_screw_head(x=matchbox_x-(3*min_wall_thikness),y=matchbox_y -(3*min_wall_thikness),rd=pt_screw_d2/2,h=pt_screw_head_z+clearance+epsilon);
		#completion_screw_head(x=(3*min_wall_thikness),y=matchbox_y -(3*min_wall_thikness),rd=pt_screw_d2/2,h=pt_screw_head_z+clearance+epsilon);

	}
}


module matchbox_cutout (x,y,z,r) {
	translate([2*min_wall_thikness,2*min_wall_thikness,-epsilon])  cube([x,y,z]);
}

module mounting_support(x,y,r,h) {
	translate([x,y,completion_z+epsilon]) cylinder(r=r, h=h,$fn=50);
}

module mounting_holes(x,y,rd,h) {
	translate([x,y,completion_z]) cylinder(r=rd, h=h+2*epsilon,$fn=50);
}

module completion_holes(x,y,rd,h) {
	translate([x,y,-clearance]) cylinder(r=rd, h=h+2*epsilon,$fn=50);
}

module completion_screw_head(x,y,rd,h) {
	translate([x,y,epsilon+ completion_z-(pt_screw_head_z+clearance)]) cylinder(r=rd, h=h,$fn=50);
}

module mounting_holes(x,y,rd,h) {
	translate([x,y,completion_z]) cylinder(r=rd, h=h+2*epsilon,$fn=50);
}


module enclosure () {	
	difference () {
		union () {
			difference () {
				matchbox_body_perimeter();
				#matchbox_completion_cutout(completion_x ,completion_y,completion_z,matchbox_edge_r);
				#matchbox_cutout (cutout_x ,cutout_y,cutout_z,matchbox_edge_r);
				
			}
			mounting_support((3*min_wall_thikness),(3*min_wall_thikness),mounting_support_r,cutout_z-completion_z);
			mounting_support(matchbox_x -(3*min_wall_thikness),(3*min_wall_thikness),mounting_support_r,cutout_z-completion_z);
			mounting_support(matchbox_x -(3*min_wall_thikness),matchbox_y- (3*min_wall_thikness),mounting_support_r,cutout_z-completion_z);
			mounting_support((3*min_wall_thikness),matchbox_y- (3*min_wall_thikness),mounting_support_r,cutout_z-completion_z);
		}
		mounting_holes(x=(3*min_wall_thikness),y=(3*min_wall_thikness),rd=pt_screw_drill/2,h=(pt_screw_L-completion_z )+clearance);
		mounting_holes(x=matchbox_x -(3*min_wall_thikness),y=(3*min_wall_thikness),rd=pt_screw_drill/2,h=(pt_screw_L-completion_z )+clearance);
		mounting_holes(x=matchbox_x -(3*min_wall_thikness),y=matchbox_y -(3*min_wall_thikness),rd=pt_screw_drill/2,h=(pt_screw_L-completion_z )+clearance);
		mounting_holes(x=(3*min_wall_thikness),y=matchbox_y -(3*min_wall_thikness),rd=pt_screw_drill/2,h=(pt_screw_L-completion_z )+clearance);
	
	}		
}

translate([0,0,matchbox_z ]) rotate([180,0,0]) enclosure();

matchbox_completion(completion_x ,completion_y,completion_z,matchbox_edge_r);
