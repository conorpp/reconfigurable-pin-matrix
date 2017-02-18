include <defs.scad>

use <threads.scad>
use <slab.scad>
use <short_wall.scad>
use <tall_wall.scad>
use <fixture.scad>
use <assembly.scad>

module PinMatrix()
{
    mid_y = tall_wall_y/2;
    mid_x = (short_wall_x + short_wall_ext_x*2)/2;

    mx_pin_start = mid_x - matrix_x/2;
    mx_pin_end = mid_x + matrix_x/2;

    my_pin_start = mid_y - matrix_x/2;
    my_pin_end = mid_y + matrix_x/2;

    echo("matrix X,Y", mx_pin_end - mx_pin_start, my_pin_end - my_pin_start);

    step = pin_x + pin_pad;
    steps_x = (mx_pin_end - mx_pin_start)/step;
    steps_y = (my_pin_end - my_pin_start)/step;

    if (apply_pin_matrix)
    {
        translate([mx_pin_start,
                my_pin_start, -50/SCALE])
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
}


module Assembly()
{
    to_slab_positions_x(0,0)
    {
        make_slab_holes()
        {
            color("purple")
            {
                translate([0,-tall_wall_y/12,0]) rotate([-90,0,0]) cylinder(tall_wall_y+20/SCALE,linear_bearing_ir,linear_bearing_ir);
                cube([0,0,0]);
                translate([0,-tall_wall_y/12,0]) rotate([-90,0,0]) cylinder(tall_wall_y+20/SCALE,linear_bearing_ir,linear_bearing_ir);
            }
        }
    }
    to_slab_positions_y(0,0)
    {
        make_slab_holes()
        {
            color("purple")
            {
                translate([0,-tall_wall_y/9,0]) rotate([-90,0,0]) cylinder(tall_wall_y,linear_bearing_ir,linear_bearing_ir);
                cube([0,0,0]);
                translate([0,-tall_wall_y/9,0]) rotate([-90,0,0]) cylinder(tall_wall_y,linear_bearing_ir,linear_bearing_ir);
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
                    metric_thread(bearing_ir*2,1,tall_wall_y/2);
                else
                    cylinder(tall_wall_y/2,bearing_ir,bearing_ir);
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


