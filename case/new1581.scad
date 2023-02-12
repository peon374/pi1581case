include <PiHoles.scad>;

$fn=20;

facePi1541();
//lidPi1541();
//basePi1541();



module screwpost() {
    difference() {
        union() {
            translate([0,-5,0]) cube([10,10,50]);
            cylinder(d=10,h=50);
        }
        cylinder(d=2.5,h=50);
    }
}

regPos=[95,20,-10];


module basePi1541() {   
    difference() {
        union() {
            roundedBoxBottom();
            translate([10,0,-12]) cube([57,8,36]);
            translate([2,0,2]) cube([57,8,36-14]);
            translate([80,20,-10]) rotate([0,0,90]) piPosts("3B",9,false); 
            
            translate(regPos) { 
                translate([3,6,0]) cylinder(d1=10, d2=5, h=10);
                translate([18,37,0]) cylinder(d1=10, d2=5, h=10);
            }
        }
        translate([35,3.5,0]) rotate([90,0,180]) ieccut();
        translate([35+25,3.5,0]) rotate([90,0,180]) ieccut();
        translate([90,-5,15]) rotate([-90,0,0]) cylinder(d=6,h=20);
        translate([110,-5,15]) rotate([-90,0,0]) cylinder(d=8,h=20);
        translate([90-8.5/2,3,8]) cube([8.5,10,14]);
        translate([80,20,0]) rotate([0,0,90]) piHoles("3B",9,false);
        translate(regPos) { 
            translate([3,6,0]) cylinder(d=2.5, h=20);
            translate([18,37,0]) cylinder(d=2.5, h=20);
        }
    }
}

module lidPi1541() {
    roundedBoxTop();

}

module facePi1541() {
    difference() {
        translate([0,205,0]) difference() {
            union() {
                roundedBoxFace();
                translate([47,6,0]) cube([50,4,50]);
                translate([50,-8,45]) cube([38,15,4]);
                translate([30,-12,3]) cube([78,20,4]);
                translate([110,7,20]) cube([20,4,20],center=true);
                translate([115,2,35]) rotate([-90,0,0]) cylinder(d=8,h=8);
                translate([105,2,35]) rotate([-90,0,0]) cylinder(d=8,h=8);
            }
            translate([52,6,10]) spiLCD();
            translate([110,3,20]) rotate([-90,0,0]) rotaryEncoder();
            translate([115,1.7,35]) rotate([-90,0,0]) LED();
            translate([105,1.7,35]) rotate([-90,0,0]) LED();
            translate([15,2,35]) rotate([-90,0,0]) cylinder(d=8,h=18);
            translate([30,2,35]) rotate([-90,0,0]) cylinder(d=8,h=18);
            translate([15,2,15]) rotate([-90,0,0]) cylinder(d=8,h=18);
            translate([30,2,15]) rotate([-90,0,0]) cylinder(d=8,h=18);

        }
        lidPi1541();
        basePi1541();
    }
}

module LED() {
    cylinder(d=5,h=8);
    cylinder(d=5.5,h=1);
}

module spiLCD() {    
    cube([39.4,1.6,28.4]);
    translate([4.5,1.6,1]) cube([31,2,26.4]);
    translate([5,1.6+2,1.5]) cube([26,12,25.4]);
    translate([0,1.6,5]) cube([2,1.6,19]);
}

module rotaryEncoder() {
    cube([12,14,7],center=true);
    cylinder(d=7.1,h=20);
    translate([0,7-0.5,7/2+0.5]) cube([2,1,1.5],center=true);
    translate([0,0,7/2+3]) cylinder(d=11,h=20);
}


module roundedBoxFace(d=8,s=[138,205,50],w=7) {

    difference() {
        union() {
            translate([d/2,0,d/2]) minkowski() {
                cube([s[0]-d,10,s[2]-d]);
                rotate([90,0,0]) cylinder(d=d,h=0.001);
            }
            translate([d/2,-w/4,d/2]) minkowski() {
                cube([s[0]-d,10,s[2]-d]);
                rotate([90,0,0]) cylinder(d=d/2,h=0.001);
            }
        }
        translate([d/2,-w/4,d/2]) minkowski() {
            cube([s[0]-d,10,s[2]-d]);
            rotate([90,0,0]) cylinder(d=d/4,h=0.001);
        }
    }
}


module roundedBoxTop(d=8,s=[138,205,50],w=7) {

    difference() {
        translate([d/2,0,d/2]) minkowski() {
            cube([s[0]-d,s[1],s[2]-d]);
            rotate([90,0,0]) cylinder(d=d,h=0.001);
        }
        translate([d/2,w/2+10,d/2]) minkowski() {
            cube([s[0]-d,s[1],s[2]-d]);
            rotate([90,0,0]) cylinder(d=d-w,h=10);
        }
        translate([0,-1,0]) cube([s[0]+20+d,s[1]+20+d,s[2]/2]);
        translate([w/4,w/4,s[2]/2-2]) cube([s[0]-w/2,s[1],4]);
        for (i=[0:6:80]) {
            translate([-0.1,40+i,s[2]/2+d/2]) cube([s[0]+10,2,(s[2]/2)-d]);
        }
        translate([d/2,s[1]-w/4,d/2]) minkowski() {
            cube([s[0]-d,10,s[2]-d]);
            rotate([90,0,0]) cylinder(d=d-w/2,h=0.001);
        }
        translate([138/2,198,45]) rotate([45,0,0]) cube([40,4,4],center=true);

    }
    difference() {
        intersection() {
            union() {
                translate([128,20,25]) screwpost();
                translate([128,180,25]) screwpost();
                translate([10,20,25]) rotate([0,0,180]) screwpost();
                translate([10,180,25]) rotate([0,0,180]) screwpost();
            }
            translate([d/2,0,d/2]) minkowski() {
                cube([s[0]-d,s[1],s[2]-d]);
                rotate([90,0,0]) cylinder(d=d,h=0.001);
            }
        }
        roundedBoxBottom();
    }
}

module roundedBoxBottom(d=8,s=[138,205,50],w=7) {
    difference() {
        union() {
            difference() {
                union() {
                    intersection() {
                        translate([d/2,0,d/2]) minkowski() {
                            cube([s[0]-d,s[1],s[2]-d]);
                            rotate([90,0,0]) cylinder(d=d,h=0.001);
                        }
                        translate([0,-1,0]) cube([s[0]+20+d,s[1]+20+d,s[2]/2]);
                    }
                    base();
                    translate([w/4,w/4,s[2]/2-2]) cube([s[0]-w/2,s[1]-w/2,4]);
              
                }
                translate([d/2,w/2+10,d/2]) minkowski() {
                    cube([s[0]-d,s[1],s[2]-d]);
                    rotate([90,0,0]) cylinder(d=d-w,h=10);
                }
                translate([10,w/2,-10]) cube([130-12,205-8-5,50]);
                for (i=[0:6:80]) {
                    translate([d-4,40+i,-8]) cube([s[0]-d,2,s[2]-d]);
                }
                translate([d/2,s[1]-w/4,d/2]) minkowski() {
                    cube([s[0]-d,10,s[2]-d]);
                    rotate([90,0,0]) cylinder(d=d-w/2,h=0.001);
                }
            }
            
            intersection() {
                union() {
                    translate([128,20,-25]) screwpost();
                    translate([128,180,-25]) screwpost();
                    translate([10,20,-25]) rotate([0,0,180]) screwpost();
                    translate([10,180,-25]) rotate([0,0,180]) screwpost();
                }
                union() {
                    intersection() {
                        translate([d/2,0,d/2]) minkowski() {
                            cube([s[0]-d,s[1],s[2]-d]);
                            rotate([90,0,0]) cylinder(d=d,h=0.001);
                        }
                        translate([0,-1,0]) cube([s[0]+20+d,s[1]+20+d,s[2]/2]);
                    }
                    base();
                    translate([w/4,w/4,s[2]/2-2]) cube([s[0]-w/2,s[1]-w/2,4]);
              
                }
            }    
        }
        translate([128,20,-25]) screwGuide();
        translate([128,180,-25]) screwGuide();
        translate([10,20,-25]) screwGuide();
        translate([10,180,-25]) screwGuide();
    }
}

module screwGuide() {
    cylinder(d=3.3,h=100);
    cylinder(d=5.5,h=48);
}

module base() {
    translate([134,205,-12]) rotate([0,0,180]) difference() {
        cube([130,205,12]);
        translate([-1,-13,-10]) rotate([20,0,0]) cube([140,20,20]);
        translate([130-3,-14,-10]) rotate([0,6,0]) cube([20,225,40]);
        translate([-20+3,-14,-10]) rotate([0,-6,0]) cube([20,225,40]);
    }
}

module ieccut() {
    cube([21.3,60,1.8]);
    translate([1,1,0]) cube([21.2-2,60,30]);
    translate([21.2/2,19/2,-28]) cylinder(d=18,h=30);
}


