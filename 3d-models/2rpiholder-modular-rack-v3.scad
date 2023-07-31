// delta is the distance arround the RPI
delta=4;
// thickness is the thickness of the plates
thick=2.5;


// height of the rpi
h = 25;
// small distance between rpi fixation
sd = 49;
// long distance between rpi fixation
ld = 58;
// distance of rpi fixation to borders
db = 3;

// diameter of the fixation
df = 6;
// diameter of the fixation screw
ds = 3;

//clip adjustment
ca = .5;

// total lenght to support two rpi
length=sd*2+db*4+delta*3;
height=h+delta;

module internalround() {
    difference() {
        cube([delta/2,delta/2,thick],center=true);
        translate([delta/4,delta/4,0]) cylinder(h=thick+1,d=delta,center=true,$fn=16);
    }
}

module clipsf() {
    difference() {
        translate([0,0,thick]) cube([thick,2*thick+2*delta,2*thick],center=true);
        translate([0,0,thick/2]) cube([2*ca+thick,2*delta,thick],center=true);
    }
}

module fixation() {
    cylinder(h=3*thick+ca,d=df,$fn=6);
    translate([0,0,-thick/2-ca]) cylinder(h=thick/2+2*ca,d=ds,$fn=18);
}

module beam() {
    difference() {
        union() {
            cube([length,delta+df,thick],center=true);
            translate([0,0,-ld/2+1.5*thick]) rotate([90,0,0]) difference() {
                cylinder(h=delta+df,d=ld,center=true);
                translate([0,-1.5*thick,0]) cube([ld+2*ca,ld+2*ca,delta+df+2*ca],center=true);
            }
        }
        translate([delta/2+db,0,0]) fixation();
        translate([delta/2+db+sd,0,0]) fixation();
        translate([-delta/2-db,0,0]) fixation();
        translate([-delta/2-db-sd,0,0]) fixation();
        translate([delta/2+db+sd/2,-(ld/2)-1,0]) cylinder(h=thick+2*ca,d=ld,center=true,$fn=32);
        translate([-delta/2-db-sd/2,-(ld/2)-1,0]) cylinder(h=thick+2*ca,d=ld,center=true,$fn=32);
    }
}

translate([0,ld/2,0]) rotate([0,0,180]) beam();
translate([0,-ld/2,0]) beam();
cube([delta,ld,thick],center=true);


translate([length/2,(ld+df)/2,0]) cylinder(h=thick,d=delta,center=true,$fn=18);
translate([length/2,-(ld+df)/2,0]) cylinder(h=thick,d=delta,center=true,$fn=18);
translate([-length/2,(ld+df)/2,0]) cylinder(h=thick,d=delta,center=true,$fn=18);
translate([-length/2,-(ld+df)/2,0]) cylinder(h=thick,d=delta,center=true,$fn=18);

translate([-length/2+3*delta/4,-(ld-df)/2+3*delta/4,0]) internalround();
translate([-length/2+3*delta/4,(ld-df)/2-3*delta/4,0]) rotate([0,0,270]) internalround();

translate([length/2-3*delta/4,-(ld-df)/2+3*delta/4,0]) rotate([0,0,90]) internalround();
translate([length/2-3*delta/4,(ld-df)/2-3*delta/4,0]) rotate([0,0,180]) internalround();


translate([3*delta/4,-(ld-df)/2+3*delta/4,0]) internalround();
translate([3*delta/4,(ld-df)/2-3*delta/4,0]) rotate([0,0,270]) internalround();

translate([-3*delta/4,-(ld-df)/2+3*delta/4,0]) rotate([0,0,90]) internalround();
translate([-3*delta/4,(ld-df)/2-3*delta/4,0]) rotate([0,0,180]) internalround();

difference() {
    union() {
        translate([length/2,0,0]) cube([delta,ld+df,thick],center=true);
        translate([-length/2,0,0]) cube([delta,ld+df,thick],center=true);
        translate([length/2+delta/2-thick/2,0,(height)/2]) cube([thick,ld-delta,height],center=true);
        translate([-length/2-delta/2+thick/2,0,(height)/2]) cube([thick,ld-delta,height],center=true);
        
        translate([-length/2-delta/4+thick,0,thick/2+delta/4])rotate([90,0,0]) linear_extrude(height=ld-delta,center=true) polygon([[-delta/4,-delta/4],[delta/4,-delta/4],[-delta/4,delta/4]]);

        translate([length/2+delta/4-thick,0,thick/2+delta/4])rotate([90,0,180]) linear_extrude(height=ld-delta,center=true) polygon([[-delta/4,-delta/4],[delta/4,-delta/4],[-delta/4,delta/4]]);

        translate([-length/2-delta/2-thick/2,0,h-thick/2]) rotate([90,90,180]) linear_extrude(height=ld-delta,center=true) polygon([[-thick/2,-thick/2],[thick/2,-thick/2],[-thick/2,thick/2]]);

        translate([length/2+delta/2+thick/2,0,h-thick/2]) rotate([90,180,180]) linear_extrude(height=ld-delta,center=true) polygon([[-thick/2,-thick/2],[thick/2,-thick/2],[-thick/2,thick/2]]);

        translate([-length/2-delta/2-thick/2,0,delta/2+h]) cube([thick,ld-delta,delta],center=true);
        translate([length/2+delta/2+thick/2,0,delta/2+h]) cube([thick,ld-delta,delta],center=true);

        translate([-length/2-delta/2-thick/2,(ld-delta)/2-thick-delta,height]) clipsf();
        translate([-length/2-delta/2-thick/2,-(ld-delta)/2+thick+delta,height]) clipsf();

        translate([length/2+delta/2+thick/2,(ld-delta)/2-thick-delta,height]) clipsf();
        translate([length/2+delta/2+thick/2,-(ld-delta)/2+thick+delta,height]) clipsf();

        translate([-length/2-delta/2-thick/2,(ld-delta)/2-thick-delta,-ca]) cube([thick+ca,2*delta-ca,thick-ca],center=true);
        translate([-length/2-delta/2-thick/2,-(ld-delta)/2+thick+delta,-ca]) cube([thick+ca,2*delta-ca,thick-ca],center=true);

        translate([length/2+delta/2+thick/2,(ld-delta)/2-thick-delta,-ca]) cube([thick+ca,2*delta-ca,thick-ca],center=true);
        translate([length/2+delta/2+thick/2,-(ld-delta)/2+thick+delta,-ca]) cube([thick+ca,2*delta-ca,thick-ca],center=true);
    }
    
    translate([0,0,height]) rotate([0,90,0]) cylinder(h=length+2*delta+2*thick+2*ca,d=ld-delta-4*thick-4*delta,center=true,$fn=32);
translate([0,0,-thick/2]) rotate([0,90,0]) cylinder(h=length+2*delta+2*thick+2*ca,d=ld-delta-4*thick-4*delta,center=true,$fn=32);
    translate([0,(ld-delta)/2,(height)/2-0.5*thick]) rotate([0,90,0]) cylinder(h=length+2*delta+2*thick+2*ca,d=height-2*thick,center=true,$fn=32);
    translate([0,-(ld-delta)/2,(height)/2-0.5*thick]) rotate([0,90,0]) cylinder(h=length+2*delta+2*thick+2*ca,d=height-2*thick,center=true,$fn=32);
}