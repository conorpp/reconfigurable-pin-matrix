include <defs.scad>

use <threads.scad>
use <slab.scad>
use <short_wall.scad>
use <tall_wall.scad>
use <assembly.scad>

module PinMatrix()
{
    mx_pin_start = tall_wall_thickness + linear_rod_offset + matrix_pad + ptol;
    mx_pin_end = tall_wall_thickness + short_wall_l - linear_rod_offset - matrix_pad - ptol;

    my_pin_start = short_wall_thickness + slab_thickness + ptol + matrix_pad;
    my_pin_end = tall_wall_l - short_wall_thickness - slab_thickness - ptol - matrix_pad;

    step = pin_x + pin_pad;
    steps_x = (mx_pin_end - mx_pin_start)/step;
    steps_y = (my_pin_end - my_pin_start)/step;


    translate([tall_wall_thickness + linear_rod_offset + matrix_pad + ptol,
            short_wall_thickness + slab_thickness + ptol + matrix_pad, -50/SCALE])
    {
        for (x = [0 : 1 : steps_x])
            for (y = [0 : 1 : steps_y])
            {
                xx = abs(steps_x/2 - x + .5);
                yy = abs(steps_y/2 - y + .5);
                translate([step*x,step*y, 
                    (apply_mold ? ((x == 0 || x == floor(steps_x) || y == 0 || y == floor(steps_y)) ? 0 : -abs(xx)+-abs(yy)) : 0)/SCALE
                     ]) 
                        cube([pin_x,pin_x,pin_z]);
            }
    }
}


module Solids()
{
    short_wall_origin()
    {
        ShortWall();
        translate([0, inside_width + short_wall_thickness + ptol]) ShortWall();
    }

    tall_wall_origin()
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
                translate([0,-outside_width/12,0]) rotate([-90,0,0]) cylinder(outside_width+20/SCALE,linear_bearing_inside_r,linear_bearing_inside_r);
                cube([0,0,0]);
                translate([0,-outside_width/12,0]) rotate([-90,0,0]) cylinder(outside_width+20/SCALE,linear_bearing_inside_r,linear_bearing_inside_r);
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


