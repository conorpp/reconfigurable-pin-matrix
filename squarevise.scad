use <threads.scad>

forever = 1000;
model_threads = 0;
apply_mold = 0;

inside_width = 130;
short_wall_thickness = 20;
tall_wall_thickness = 20;
outside_width = inside_width + short_wall_thickness*2;
depth = 20;
slab_shortener = 4;
slab_wall = depth/2;
slab_protrusion = 1.25;
hole_rad = 2;
ptol = 1;

short_wall_l = outside_width;
tall_wall_l = outside_width;

slab_thickness = depth/2;
slab_l = short_wall_l;
slab_thickness = depth/2;
linear_rod_offset = slab_l/10;
linear_bearing_outside_r = 3;
linear_bearing_inside_r = 1.5;
bearing_outside_r = 5;
bearing_inside_r = 2.5;
bearing_depth = 5;

slabx_o = 0;//20;
slaby_o = 0;//15;



module make_slab()
{
    cube([slab_l, slab_thickness, depth]);
}

module make_linear_hole()
{
    rotate([-90,0,0]) cylinder(slab_thickness,linear_bearing_outside_r,linear_bearing_outside_r);
    // infinite hole
    rotate([-90,0,180]) cylinder(forever,linear_bearing_outside_r,linear_bearing_outside_r);
}
module make_bearing_insert()
{
    rotate([-90,0,0]) cylinder(bearing_depth,bearing_outside_r,bearing_outside_r);
    // infinite hole
    rotate([-90,0,180]) cylinder(forever,bearing_inside_r+0.2,bearing_inside_r+0.2);
}


module make_slab_holes()
{
    translate([linear_rod_offset,0,depth/2])
    {
        if ($children > 0) children(0);
    }
    translate([slab_l - linear_rod_offset,0,depth/2])
    {
        if ($children > 2) children(2);
    }
    translate([slab_l/2,0,depth/2])
    {
        if ($children > 1) children(1);
    }
}

module ShortWall()
{
    cube([ outside_width + ptol, short_wall_thickness, depth ]);
}
module TallWall()
{
    cube([tall_wall_thickness, outside_width + ptol, depth*3 ]);
}

module to_slab_positions_y(slab_offset = slaby_o)
{
    // close short slab
    translate([tall_wall_thickness + ptol/2,
            short_wall_thickness + ptol + slab_offset,
            0]) children();

    // far short slab
    translate([tall_wall_thickness + ptol/2, 
            tall_wall_l - (short_wall_thickness+slab_thickness)  - slab_offset,
            0])
        translate([slab_l,slab_thickness,0]) rotate([0,0,180]) children();
}
module to_slab_positions_x(slab_offset = slabx_o)
{
    // right top slab
    translate([ tall_wall_thickness + short_wall_l - slab_thickness - slab_offset,0,depth + ptol])
        translate([slab_thickness,0,0]) rotate([0,0,90]) children();

    // right bottom slab
    translate([tall_wall_thickness + short_wall_l - slab_thickness - slab_offset,0,-depth - ptol])
        translate([slab_thickness,0,0]) rotate([0,0,90]) children();

    // left top slab
    translate([tall_wall_thickness + ptol + slab_offset,0, depth + ptol])
        translate([0,slab_l,0]) rotate([0,0,-90]) children();

    // left bottom slab
    translate([tall_wall_thickness + ptol + slab_offset,0, -depth - ptol])
        translate([0,slab_l,0]) rotate([0,0,-90]) children();
}
module to_slab_positions(slab_offsetx = slabx_o, slab_offsety = slaby_o)
{
    to_slab_positions_x(slab_offsetx) children();
    to_slab_positions_y(slab_offsety) children();
}

module PinMatrix()
{
    pin_z = 150;
    pin_x = 2;
    matrix_pad = 15;
    pin_pad = 0.2;

    mx_pin_start = tall_wall_thickness + linear_rod_offset + matrix_pad + ptol;
    mx_pin_end = tall_wall_thickness + short_wall_l - linear_rod_offset - matrix_pad - ptol;

    my_pin_start = short_wall_thickness + slab_thickness + ptol + matrix_pad;
    my_pin_end = tall_wall_l - short_wall_thickness - slab_thickness - ptol - matrix_pad;

    step = pin_x + pin_pad;
    steps_x = (mx_pin_end - mx_pin_start)/step;
    steps_y = (my_pin_end - my_pin_start)/step;


    translate([tall_wall_thickness + linear_rod_offset + matrix_pad + ptol,
            short_wall_thickness + slab_thickness + ptol + matrix_pad, -50])
    {
        for (x = [0 : 1 : steps_x])
            for (y = [0 : 1 : steps_y])
            {
                xx = abs(steps_x/2 - x + .5);
                yy = abs(steps_y/2 - y + .5);
                translate([step*x,step*y, 
                    apply_mold ? ((x == 0 || x == floor(steps_x) || y == 0 || y == floor(steps_y)) ? 0 : -abs(xx)+-abs(yy)) : 0
                     ]) 
                        cube([pin_x,pin_x,pin_z]);
            }
    }
}


module Solids()
{
    translate([tall_wall_thickness,0,0])
    {
        ShortWall();
        translate([0, inside_width + short_wall_thickness + ptol]) ShortWall();
    }
    translate([0,0,-depth])
    {
        TallWall();
        translate([tall_wall_thickness + outside_width + ptol,0,0])
        {
            TallWall();
        }
    }

    to_slab_positions()
    {
        color("green") make_slab();
    }

}

module Holes()
{
    to_slab_positions()
    {
        make_slab_holes()
        {
            make_linear_hole();
            make_bearing_insert();
            make_linear_hole();
        }
    }
}

module Assembly()
{
    to_slab_positions_x(0,0)
    {
        make_slab_holes()
        {
            color("purple")
            {
                translate([0,-outside_width/12,0]) rotate([-90,0,0]) cylinder(outside_width+20,linear_bearing_inside_r,linear_bearing_inside_r);
                cube([0,0,0]);
                translate([0,-outside_width/12,0]) rotate([-90,0,0]) cylinder(outside_width+20,linear_bearing_inside_r,linear_bearing_inside_r);
            }
        }
    }
    to_slab_positions_y(0,0)
    {
        make_slab_holes()
        {
            color("purple")
            {
                translate([0,-outside_width/9,0]) rotate([-90,0,0]) cylinder(outside_width,linear_bearing_inside_r,linear_bearing_inside_r);
                cube([0,0,0]);
                translate([0,-outside_width/9,0]) rotate([-90,0,0]) cylinder(outside_width,linear_bearing_inside_r,linear_bearing_inside_r);
            }
        }
    }
    to_slab_positions()
    {
        make_slab_holes()
        {
            cube([0,0,0]);
            color("blue") rotate([-90,0,180])
                if (model_threads)
                    metric_thread(bearing_inside_r*2,1,outside_width/2);
                else
                    cylinder(outside_width/2,bearing_inside_r,bearing_inside_r);
            cube([0,0,0]);
        }
    }
    PinMatrix();
}

translate([0,0,0])
{
    difference()
    {
        Solids();
        Holes();
    }
    Assembly();
}


