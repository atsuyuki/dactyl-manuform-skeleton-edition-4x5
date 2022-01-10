module joystick()color("#555")translate([-2.5, 0.3, 0])import("KY-023_Joystick_Module.stl");

module joystick_screw(x, y, r, h){
  translate([x, y, -3]){
    cylinder(r = r, h = h, $fs = 0.01, center = true);
  }

}

module joystick_screws(r, h){
  joystick_screw(26 / 2, -20 / 2, r, h);
  joystick_screw(26 / 2, 20 / 2, r, h);
  joystick_screw(-26 / 2, -20 / 2, r, h);
  joystick_screw(-26 / 2, 20 / 2, r, h);
}

module joystick_block(){
  difference(){
    union(){
      difference(){
        translate([75, -71, 63])rotate([15, 0, 40]){
            bracket();
            translate([0, 0, 0.1])joystick();
          }
        translate([75, -71, 31])cylinder(r = 4.1, h = 20.2, $fs = 0.01);
      }
        color("gray", 0.5)translate([75, -71, 31.1])cylinder(r = 4, h = 20, $fs = 0.01);
    }
    translate([0, -100, -100 + 18])cube([100, 100, 100]);
  }
}

joystick_block();

module bracket(){
  difference(){
    union(){
      difference(){
        union(){
          translate([0, 0, -3])cube([34, 26, 6], center = true);
          rotate([-15, 0, 0])translate([0, 0, -8])cube([12, 12, 10], center = true);
          rotate([-15, 0, 0])translate([0, 0, -45]){
              hull(){
                minkowski(){ 
                  union(){
                    cylinder(r = 4, h = 10);
                    translate([10, 10, 0])cylinder(r = 1, h = 6);
                    translate([-10, 10, 0])cylinder(r = 1, h = 6);
                    translate([0, -6, 0])cylinder(r = 1, h = 6);
                  }
                  sphere(4);
                }

              }}
          //rotate([-15, 0, 0])translate([0, 0, -12])cylinder(r=2,h=8);
        }
        union(){
          translate([-27, 0, -4 / 2])cube([27 + 2-4, 13, 10], center = true);
          translate([0, 0, -4 / 2])cube([27 + 2-4, 20 + 2+5, 4], center = true);
          translate([0, 0, -4 / 2])cube([34+2, 13, 4], center = true);
          rotate([-15, 0, 0])translate([0, 0, -12])cylinder(r = 2, h = 100, center = true, $fs = 0.01);
          rotate([-15, 0, 0])translate([0, 0, -47])cylinder(r = 4, h = 10, center = true, $fs = 0.01);
          rotate([-15, 0, 0])translate([0, 0, -5])cylinder(r = 4, h = 4, center = true);
          rotate([-15, 0, 0])translate([0, 0, -45]){
              translate([10, 10, -10])cylinder(r = 1.7, h = 16);
              translate([-10, 10, -10])cylinder(r = 1.7, h = 16);
              translate([0, -6, -10])cylinder(r = 1.7, h = 16);
            }
        }
      }
      joystick_screws(3, 6);
    }
    color("red")joystick_screws(1.7, 10);
  }
}