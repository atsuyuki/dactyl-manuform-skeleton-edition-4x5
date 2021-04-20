module addon_holder(){
  difference(){
    translate([0, 11, 0])cube([12, 35, 6], center = true);
    union(){
      cylinder(r = 7.5 / 2, h = 20, center = true, $fs = 0.01);
      translate([0, 22, 0])cylinder(r = 7.5 / 2, h = 20, center = true, $fs = 0.01);
    }
  }
}

module promicro(){
  color("darkblue")cube([33, 18, 1.6]);
  color("lightgray")translate([29, 5, 1.6])cube([5, 7.4, 2.5]);
  color("lightgray")translate([3.5, 6, 1.6])cube([3, 5, 1]);
  color("darkorange"){
    translate([20, 4, 1.6])cube([3, 1.5, 1.5]);
    translate([20, 12, 1.6])cube([3, 1.5, 1.5]);
  }
  color("#222")translate([14, 4, 1.6])rotate([0, 0, 45])cube([7, 7, 1]);
  for(i = [0:11]){
    for(j = [0:1]){
      color("Khaki")translate([1.3 + i * 2.54, 1.3 + j * 15.24, 1.6])cylinder(r = 0.9, h = 0.01, $fs = 0.5);
    }
  }
}

module promicro_holder(){
  union(){
    color("green")addon_holder();
    translate([-6, 11, 0]){
      rotate([90, 180, -90]){
        color("green")cube([33 + 3, 10, 2], center = true);
        color("green")translate([33 / 2, 0, 2])cube([3, 12, 8], center = true);
        color("green")translate([-33 / 2, 0, 2])cube([3, 10, 4], center = true);

        translate([-33 / 2, -18 / 2, 1])promicro();
      }
    }
  }
}

promicro_holder();