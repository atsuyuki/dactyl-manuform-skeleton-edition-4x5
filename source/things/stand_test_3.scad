print_offset = 0.2;

long_rod = 50;
mid_rod = 30;
short_rod = 20;
rod_diamater = 7;
long_rod_diamater = 7;
mid_rod_diamater = 7;
short_rod_diamater = 8;

//$fs = 0.01;

module m4screw(){
  screw_rk = 6.1 / 2;
  screw_k = 1.5;
  screw_r = 4 / 2;

  rotate([180, 0, 0]){
    union(){
      cylinder(r = screw_r + print_offset, h = 15, $fs = 0.01);
      cylinder(r1 = screw_rk + print_offset, r2 = screw_r + print_offset, h = screw_k, $fs = 0.01);
      color("blue", 0.5)translate([0, 0, -30])cylinder(r = screw_rk + print_offset, h = 30, $fs = 0.01);
    }
  }
}

module rod(length = 10, translate = [0, 0, 0], rotate = [0, 0, 0], rod_dia, offset = print_offset){
  translate(translate)rotate(rotate){
      translate([0, 0, -length / 2]){
        cylinder($fs = 0.01, r = rod_dia / 2 + offset, h = length + offset * 2, center = true);
      }
    }
}

module bracket(rod_length, translate = [0, 0, 0], rotate = [0, 0, 0], length = 15){
  translate(translate)rotate(rotate){
      translate([0, 0, (length / 2) + print_offset]){
        color("red", 0.5)cylinder(r = rod_diamater / 2, h = length, center = true);

      }
    }
}

module lower_bracket(rod_length, translate = [0, 0, 0], rotate = [0, 0, 0], length = 30){
  translate(translate)rotate(rotate){
      translate([0, 0, -(rod_length + length / 2) + print_offset]){
        color("red", 0.5)cylinder(r = rod_diamater / 2, h = length, center = true);
      }
    }
}

pos_list = [
  [long_rod, [-47, -11, 80], [0, 16, 0], 7, long_rod_diamater],
  [long_rod, [-47, 11, 80], [0, 16, 0], 7, long_rod_diamater],

  [mid_rod, [-21, -37.8, 51], [0, 50, 40], 9, mid_rod_diamater],

  [mid_rod, [-33, -8.4, 53], [0, 25, 0], 8, mid_rod_diamater],
  [mid_rod, [-33, 14, 53], [0, 25, 0], 7, mid_rod_diamater],

//  [short_rod, [-0, -23, 34], [0, 65, 0], 7, short_rod_diamater],
//  [short_rod, [-0, -1, 34], [0, 65, 0], 7, short_rod_diamater],

//  [short_rod, [-71, -69, 49], [0, -30, 60], 8, short_rod_diamater],
  [mid_rod, [-65, -60, 55], [0, -30, 60], 8, mid_rod_diamater],
  [mid_rod, [-72, -48, 58], [0, -30, 60], 9, mid_rod_diamater],
//  [short_rod, [-25, -73, 51], [0, 0,0], 8, short_rod_diamater],
];

module stab_high(){translate([-68,-55,0])cylinder(r=3,h=100);}
module stab_low(){
    translate([-40,10,0])cylinder(r=3,h=100);
    translate([-40,-15,0])cylinder(r=3,h=100);
    }


module base(thickness){


  linear_extrude(height = thickness){
    projection()union(){
        hull(){
          for(pos = [
              pos_list[0],
              pos_list[1],
              pos_list[3],
              pos_list[4],
//              pos_list[5],
              pos_list[6],
            ]){
            lower_bracket(pos[0], pos[1], pos[2]);
                stab_low();
          }
            translate([-35,-10,0])cylinder(r=3,h=thickness);
            translate([-30,5,0])cylinder(r=3,h=thickness);

        }

        hull(){
          for(pos = [
              pos_list[0],
              pos_list[3],
//              pos_list[7],
//              pos_list[8],
            ]){
            lower_bracket(pos[0], pos[1], pos[2]);
          }
        }

        hull(){
          for(pos = [
              pos_list[2],
              pos_list[6],
//              pos_list[8],
//              pos_list[9],
            ]){
            lower_bracket(pos[0], pos[1], pos[2]);
                                

          }
        }
      }
  }
}


module base_higher(thickness){
  linear_extrude(height = thickness){
    projection()union(){
        hull(){
          for(pos = [
              pos_list[0],
              pos_list[1],
//              pos_list[5],
//          pos_list[2],

              pos_list[6],
            ]){
            lower_bracket(pos[0], pos[1], pos[2]);
          }
        }
        hull(){
          for(pos = [
              pos_list[0],
              pos_list[5],
              pos_list[6],
              pos_list[2],
//              pos_list[7],
            ]){
            lower_bracket(pos[0], pos[1], pos[2]);
            stab_high();
          }
        }
      }
  }
}




module base_screws(r){
  union(){
    translate([-69, -48, 18])cylinder(r = r, h = 10);
    translate([-41, -40, 18])cylinder(r = r, h = 10);
    translate([-72, 5, 18])cylinder(r = r, h = 10);
    translate([-18, -13, 18])cylinder(r = r, h = 6);
  }
}

module base_plate(){
  base_plate_thickness = 4;
  base_plate_offset = 18;
  difference(){
    difference(){
      union(){
        union(){
          for(pos = pos_list){
            minkowski(){
              lower_bracket(pos[0], pos[1], pos[2]);
              sphere(3);
            }
          }
        }
        minkowski(){
          base(base_plate_offset + base_plate_thickness);
          sphere(3);
        }
        minkowski(){
          base_higher(base_plate_offset + base_plate_thickness + 5);
          sphere(3);
        }
      }
      cube([300, 300, base_plate_offset * 2], center = true);
    }
    union(){
      rods();
      translate([0, 0, 16]){
        difference(){
          union(){
            color("red")translate([-3, 0, 0])scale([0.95, 0.95, 0.95])base(5);
            color("blue")translate([-3, 0, 0])scale([0.95, 0.95, 0.95])base_higher(10);
          }
          translate([-46, -27, 0])rotate([0, 0, 70])cube([2, 100, 50], center = true);
        }
      }
    }
  }

}

module rods(){
  for(pos = pos_list){
    color("gray", 0.5)rod(pos[0], pos[1], pos[2], pos[4]);
  }
}

module rods_nooffset(){
  for(pos = pos_list){
    color("gray", 0.5)rod(pos[0], pos[1], pos[2], pos[4], 0);
  }
}

module top_brackets(){
  for(pos = pos_list){
    bracket(pos[0], pos[1], pos[2], pos[3]);
  }
}

module screws(){
  for(pos = pos_list){
    translate(pos[1])rotate(pos[2]){
        translate([0, 0, pos[3]]){
          m4screw();
        }
        translate([0, 0, -(pos[0] + 4)]){
          rotate([180, 0, 0])m4screw();
        }
      }
  }
}

top_brackets();
base_plate();
rods();

points = [
  [20, 20, 0],
  [0, 35, 0],
  [-55, 35, 0],
  [-75, 20, 0],
  [-75, -30, 0],
  [-80, -50, 0],
  [-100, -80, 0],
  [-64, -100, 0],
  [-44, -70, 0],
  //   [-20, -50,0],
  //    [10, -50,0],
  [20, -40, 0],
];

/*
hull(){
  for(point = points){
    translate(point){
      cylinder(r = 1, h = 4);
    }
  }
}
    */  