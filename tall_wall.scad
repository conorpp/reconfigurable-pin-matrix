include <defs.scad>
use <assembly.scad>
use <slab.scad>

module TallWall()
{
    cube([tall_wall_x, tall_wall_y, tall_wall_z ]);
}


difference()
{
    tall_wall_origin()
    {
        TallWall();
    }
    Holes();
}


