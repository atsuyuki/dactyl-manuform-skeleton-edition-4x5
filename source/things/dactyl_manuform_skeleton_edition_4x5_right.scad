//use<right_fixed_module.scad>
module right() include<right.scad>
use<stand_test_3.scad>
use<misc.scad>

use<joystick_bracket.scad>
color("gray")translate([0,-102,14.9]) import("right_baseplate-design.stl");

//include<right_baseplate.scad>

joystick_block();
dm_right();
/*

difference(){
hull(){
color("yellow")translate([72, -70, 60]) rotate([50,0,30]){
  translate([0,0,-6]) cube([34,26,1],center=true);
}
translate([72, -70, 18]) rotate([0,0,30]){
translate([0,0,3])cube([34,20,6],center=true);
}
}
union(){
translate([72, -70, 18])rotate([0,0,30]){
  translate([5,0,-6])cylinder(r=1.7,h=10);
  translate([-5,0,-6])cylinder(r=1.7,h=10);
}
  }

}
    }



*/
/*
module tab(){
  hull(){
    translate([-33
    , -50, 76]){
      rotate([10, -20, 10]){
        translate([-0.5, 0.4, 0.5])cube([1, 17, 6], center = true);
      }
    }

    color("yellow", 0.8)translate([-28, -40, 73]){
        rotate([-30, 50, 0]){
          translate([-0.5, -0.5, 0])cube([1, 17, 6], center = true);
        }
      }
  }
}
*/  

module base_screws_hole(r){
  rib_height=4;
  union(){
translate([-74, -40, 18]){
  cylinder(r = r, h = rib_height); 
translate([0,0,rib_height])sphere(r);
  }
    translate([-37, -45, 18]){
      cylinder(r = r, h = rib_height); 
    translate([0,0,rib_height])sphere(r);
      }
    translate([-75, 3, 18]){
      cylinder(r = r, h = rib_height); 
    translate([0,0,rib_height])sphere(r);
      }
    translate([-28, 5, 18]){
      cylinder(r = r, h = 6); 
    translate([0,0,3])sphere(r);
      }

  }
}

//  translate([80,-55,18]) cylinder(r=3,h=6);
//  translate([55,-75,18]) cylinder(r=3,h=6);

module dm(){
// トッププレート// トッププレート
  difference(){
    union(){
      right();
      top_brackets();
      //      tab();
    }
    union(){
      rods();
      screws();
    }
  }

// ボトムプレート// ボトムプレート
  difference(){
    union(){
      base_plate();
      base_screws_hole(3);
    }
    union(){
      rods();
      screws();
      base_screws_hole(1.7);
    }
  }
}

/*
translate([-47, -11, 80])rotate([0, 16, 0]){
    translate([0, 0, -40])promicro_holder();
  }
    */  

module dm_right(){
translate([100, 0, 0]){
  dm();
  rods_nooffset();
translate([-47,-11,80]) rotate([180,180+16,0]) translate([0,0,-30]){
    import("promicro_holder.stl");
    translate([14,-29.5,-13.5])rotate([90,0,90])promicro();
    }
  //screws();
}
}



//mirror([1, 0, 0])translate([100, 0, 0])dm();
