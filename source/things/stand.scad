offset = 0.1;
screw_head_radius = 5 / 2;
screw_head_height = 4;

bracket_width = 10 / 2;
bracket_height = 8;

thickness = 4;

long_rod = 50;
short_rod = 20;

module bracket(){
  color("", 1.0){
    translate([0, 0, 3]){
      minkowski(){
        cylinder(r = bracket_width - 1, h = bracket_height, center = true);
        sphere(r = 1);
      }

        }}}

module m4screw(){
  color("red", 0.5){
    union(){
      translate([0, 0, -4]){
        cylinder(h = 16, r = (4 / 2) + offset);
        cylinder(h = 4, r = (screw_head_radius) + offset);
      }
      translate([0, 0, -50]){
        cylinder(h = 50, r = (screw_head_radius) + offset);
      }

    }
  }

}

module lod(length){
  color("white", 0.5){
    cylinder(h = length, r = ((screw_head_radius) + offset));
  }
}

module brackets(length){
  union(){
    translate([0, 0, -thickness]){
      bracket();

    }
    mirror([0, 0, 1]){
      translate([0, 0, -length - thickness]){
        bracket();
        translate([0, 0, -13]){
          cylinder(r1 = bracket_width + 1, r2 = bracket_width, 20);
        }}
    }
  }
}

module screws(length){
  union(){
    translate([0, 0, -thickness]){
      m4screw();
    }
    mirror([0, 0, 1]){
      translate([0, 0, -length - thickness]){
        m4screw();
      }
    }
  }
}

module bracket_screw_rod(length){
  brackets(length);
 screws(length);// screws(length);// screws(length);// screws(length);// screws(length);// screws(length);// screws(length);// screws(length);
  lod(length);

}

/////////////////////////////////////

translate([-72, -48, 58]){
  rotate([180, -30, 60]){
    bracket_screw_rod(short_rod);
  }
}

translate([-65, -60, 55]){
  rotate([180, -30, 60]){
    bracket_screw_rod(short_rod);
  }
}

translate([-71, -69, 50]){
  rotate([180, -30, 60]){
    bracket_screw_rod(short_rod);
  }
}
//////////

translate([-6, 0, 37]){
  rotate([180, 60, 0]){
    //      bracket_screw_rod(short_rod);
  }
}

translate([-6, -24, 37]){
  rotate([180, 60, 0]){
    //      bracket_screw_rod(short_rod);
  }
}

/////////////

translate([-24, 11.5, 47]){
  rotate([180, 25, 0]){
    bracket_screw_rod(short_rod);
  }
}

translate([-22, -33, 50]){
  rotate([180, 25, 0]){
    bracket_screw_rod(short_rod);
  }
}

translate([-29, -9, 47]){
  rotate([180, 25, 0]){
    bracket_screw_rod(short_rod);
  }
}
///////////

translate([-50, 12, 85]){
  rotate([180, 0, 0]){
    bracket_screw_rod(long_rod);
  }
}

translate([-50, -12, 85]){
  rotate([180, 0, 0]){
    bracket_screw_rod(long_rod);
  }
}

//////////
//difference(){
/*
  hull(){
    translate([-70, -40, 4]){
    rotate([0, 20, 0]){
      cube([40, 65, 34]);
        }    }
    translate([-90, -70, 0]){
      rotate([0, 0, -30]){
        cube([30, 40, 28]);
      }}
  }
*/
//  cube([300, 300, 50], center = true);
//}