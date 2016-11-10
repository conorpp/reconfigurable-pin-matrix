include <defs.scad>
use <assembly.scad>
use <slab.scad>

module ShortWall()
{
    cube([ outside_width, short_wall_thickness, depth ]);
}

difference()
{
    short_wall_origin()
    {
        ShortWall();
    }
    Holes();
}

