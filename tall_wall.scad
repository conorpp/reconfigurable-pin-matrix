include <defs.scad>
use <assembly.scad>
use <slab.scad>


module _TallWall()
{
    cube([tall_wall_x, tall_wall_y, tall_wall_z ]);
    translate([0,-tall_wall_ext_y,0])
    {
        /*orange() */
        cube([tall_wall_ext_x, tall_wall_ext_y, tall_wall_ext_z ]);
    }
    translate([0,tall_wall_y,0])
    {
        /*orange() */
        cube([tall_wall_ext_x, tall_wall_ext_y, tall_wall_ext_z ]);
    }
}

module TallWall()
{
    difference()
    {
        _TallWall();
        tall_wall_cuts();
    }
}

module cut_lock()
{
    cut_start = tall_wall_z/2 + short_wall_z/2 - (short_wall_z - short_wall_cut_z);
    leftover = tall_wall_z - cut_start;

    translate([0,0,cut_start])
    {
        cube([tall_wall_x, tall_wall_cut_y ,leftover]);
    }
    translate([tall_wall_x/2,0,0])
    {
        cube([tall_wall_cut_x, tall_wall_cut_y, cut_start]);
    }
}

module tall_wall_holes()
{
}

module tall_wall_cuts()
{
    cut_lock();
    translate([0,tall_wall_y - tall_wall_cut_y,0])
    {
        cut_lock();
    }
}



difference()
{
    tall_wall_origin()
    {
        TallWall();
    }
    Holes();
}


