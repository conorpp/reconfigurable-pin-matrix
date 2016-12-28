include <defs.scad>
include <slab.scad>
use <short_wall.scad>
use <tall_wall.scad>

module to_slab_positions_y(slab_offset = slaby_o)
{
    start_z = short_wall_z/2 - slab_z/2 + ptol;
    // close short slab
    translate([tall_wall_x + ptol/2,
            short_wall_y + ptol + slab_offset,
             start_z ]) children();

    // far short slab
    translate([tall_wall_x + ptol/2, 
            tall_wall_y - (short_wall_y+slab_y)  - slab_offset,
            start_z])
        translate([tall_wall_y,slab_y,0]) rotate([0,0,180]) children();
}

module to_slab_positions_x(slab_offset = slabx_o)
{
    short_wall_top = short_wall_z + ptol;
    short_wall_bot = -ptol;
    // right top slab
    translate([ tall_wall_x + tall_wall_y - slab_y - slab_offset,0,short_wall_top])
        translate([slab_y,0,0]) rotate([0,0,90]) children();

    // right bottom slab
    translate([tall_wall_x + tall_wall_y - slab_y - slab_offset,0,-slab_z + short_wall_bot])
        translate([slab_y,0,0]) rotate([0,0,90]) children();

    // left top slab
    translate([tall_wall_x + ptol + slab_offset,0, short_wall_top])
        translate([0,tall_wall_y,0]) rotate([0,0,-90]) children();

    // left bottom slab
    translate([tall_wall_x + ptol + slab_offset,0, -slab_z + short_wall_bot])
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

module to_tall_wall_positions()
{
    tall_wall_origin()
    {
        rotate([0,0,180])
        {
            translate([-tall_wall_x,-tall_wall_y,0])
            {
                children();
            }
        }
        translate([short_wall_x + tall_wall_x + ptol, 0, 0]) children();
    }
}



module Solids()
{

    to_short_wall_positions()
    {
        color("orange") ShortWall();
    }

    to_tall_wall_positions()
    {
        TallWall();
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
    tall_wall_holes();
}


