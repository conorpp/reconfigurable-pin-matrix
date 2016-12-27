include <defs.scad>
include <slab.scad>
use <short_wall.scad>
use <tall_wall.scad>


module to_slab_positions_y(slab_offset = slaby_o)
{
    // close short slab
    translate([tall_wall_x + ptol/2,
            short_wall_y + ptol + slab_offset,
            0]) children();

    // far short slab
    translate([tall_wall_x + ptol/2, 
            tall_wall_y - (short_wall_y+slab_y)  - slab_offset,
            0])
        translate([tall_wall_y,slab_y,0]) rotate([0,0,180]) children();
}
module to_slab_positions_x(slab_offset = slabx_o)
{
    // right top slab
    translate([ tall_wall_x + tall_wall_y - slab_y - slab_offset,0,short_wall_z + ptol])
        translate([slab_y,0,0]) rotate([0,0,90]) children();

    // right bottom slab
    translate([tall_wall_x + tall_wall_y - slab_y - slab_offset,0,-short_wall_z - ptol])
        translate([slab_y,0,0]) rotate([0,0,90]) children();

    // left top slab
    translate([tall_wall_x + ptol + slab_offset,0, short_wall_z + ptol])
        translate([0,tall_wall_y,0]) rotate([0,0,-90]) children();

    // left bottom slab
    translate([tall_wall_x + ptol + slab_offset,0, -short_wall_z - ptol])
        translate([0,tall_wall_y,0]) rotate([0,0,-90]) children();
}
module to_slab_positions(slab_offsetx = slabx_o, slab_offsety = slaby_o)
{
    to_slab_positions_x(slab_offsetx) children();
    to_slab_positions_y(slab_offsety) children();
}

module short_wall_origin()
{
    translate([tall_wall_x+ptol/2,0,0])
    {
        children();
    }
}

module to_short_wall_positions()
{
    short_wall_origin()
    {
        children();
        translate([0, inside_width + short_wall_y + ptol]) children();
    }
}


module tall_wall_origin()
{
    translate([0,0,-short_wall_z])
    {
        children();
    }
}


module Solids()
{

    to_short_wall_positions()
    {
        color("orange") ShortWall();
    }

    tall_wall_origin()
    {
        TallWall();
        translate([tall_wall_x + tall_wall_y + ptol,0,0])
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
    make_short_wall_holes();
}


