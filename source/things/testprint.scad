use<dactyl_manuform_skeleton_edition_4x5_right.scad>;
use<joystick_bracket.scad>

//joystick_block();
//dm_right();linear_extrude(4)
projection(){

//translate([100, 0, 0]){
difference(){
    union(){
  dm_right();
joystick_block();
        
    }
translate([0,-200,20])cube([400,400,100]);
}
    hull(){
 translate([100,10,0]) cylinder(r=4,h=10);  
 translate([100,-30,0]) cylinder(r=4,h=10);  
    }
    }
//testbracket();
//}