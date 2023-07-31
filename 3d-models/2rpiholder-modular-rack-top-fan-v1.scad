// delta is the distance arround the RPI
delta=5;
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

// fan width
fw = 120;
// fan distance of holes to border
fd = 8;
// fan hole diameter
fhd = 4;

//clip adjustment
ca = .5;

// total lenght to support two rpi
length=sd*2+db*4+delta*3;
height=h+delta;

module internalround() {
    difference() {
        cube([delta/2,delta/2,thick-ca],center=true);
        translate([delta/4,delta/4,0]) cylinder(h=thick+1,d=delta,center=true,$fn=16);
    }
}

module fanholder() {
    cube([2*delta+fhd,delta+fhd,thick-ca],center=true); 
    translate([0,(delta+fhd)/2,(delta+fhd)/2]) rotate([90,0,0]) difference() {
        cube([2*delta+fhd,delta+fhd,thick-ca],center=true);
        cylinder(h=thick+2*ca,d=fhd,$fn=38,center=true);
    }
    translate([0,(delta+fhd)/2,0])  rotate([0,90,0]) cylinder(d=thick-ca,h=2*delta+fhd,$fn=38,center=true);
}


translate([0,ld/2,0]) cube([length,delta+df,thick-ca],center=true);
translate([0,-ld/2,0]) cube([length,delta+df,thick-ca],center=true);
cube([delta,ld,thick-ca],center=true);


translate([length/2,0,0]) cube([delta,ld+df,thick-ca],center=true);
translate([-length/2,0,0]) cube([delta,ld+df,thick-ca],center=true);

translate([length/2,(ld+df)/2,0]) cylinder(h=thick-ca,d=delta,center=true,$fn=18);
translate([length/2,-(ld+df)/2,0]) cylinder(h=thick-ca,d=delta,center=true,$fn=18);
translate([-length/2,(ld+df)/2,0]) cylinder(h=thick-ca,d=delta,center=true,$fn=18);
translate([-length/2,-(ld+df)/2,0]) cylinder(h=thick-ca,d=delta,center=true,$fn=18);

translate([-length/2+3*delta/4,-(ld-df)/2+3*delta/4,0]) internalround();
translate([-length/2+3*delta/4,(ld-df)/2-3*delta/4,0]) rotate([0,0,270]) internalround();

translate([length/2-3*delta/4,-(ld-df)/2+3*delta/4,0]) rotate([0,0,90]) internalround();
translate([length/2-3*delta/4,(ld-df)/2-3*delta/4,0]) rotate([0,0,180]) internalround();


translate([3*delta/4,-(ld-df)/2+3*delta/4,0]) internalround();
translate([3*delta/4,(ld-df)/2-3*delta/4,0]) rotate([0,0,270]) internalround();

translate([-3*delta/4,-(ld-df)/2+3*delta/4,0]) rotate([0,0,90]) internalround();
translate([-3*delta/4,(ld-df)/2-3*delta/4,0]) rotate([0,0,180]) internalround();

translate([-length/2-delta/2-thick/2,(ld-delta)/2-thick-delta,0]) cube([thick+ca,2*delta-ca,thick-ca],center=true);
translate([-length/2-delta/2-thick/2,-(ld-delta)/2+thick+delta,0]) cube([thick+ca,2*delta-ca,thick-ca],center=true);

translate([length/2+delta/2+thick/2,(ld-delta)/2-thick-delta,0]) cube([thick+ca,2*delta-ca,thick-ca],center=true);
translate([length/2+delta/2+thick/2,-(ld-delta)/2+thick+delta,0]) cube([thick+ca,2*delta-ca,thick-ca],center=true);

translate([-fw/2+fd,ld/2+(delta+df)/2,0]) fanholder();
translate([fw/2-fd,ld/2+(delta+df)/2,0]) fanholder();