include <defs.scad>
include <slab.scad>


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

module short_wall_origin()
{
    translate([tall_wall_thickness+ptol/2,0,0])
    {
        children();
    }
}


module tall_wall_origin()
{
    translate([0,0,-depth])
    {
        children();
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


