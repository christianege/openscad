// PCB mounting clips for 35mm DIN Rail by RobertHunt 
// is licensed under the Creative Commons - Attribution license.
//
// https://www.thingiverse.com/thing:101024



CLIP_H = 10;
HOLE_DEPTH = 7;
HOLE_DIAMETER = 2.9;

module din_clip() {
	
	difference() {

		linear_extrude(height=CLIP_H, center=true, convexity=5) {
			import(file="din_clip_01.dxf", layer="0", $fn=64);
		}
}

}

din_clip();

