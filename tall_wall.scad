include <defs.scad>
use <assembly.scad>
use <slab.scad>


module TallWall()
{
    cube([tall_wall_thickness, outside_width, depth*3 ]);
}


difference()
{
    tall_wall_origin()
    {
        TallWall();
    }
    Holes();
}


