include <defs.scad>

_slab_offset = (tall_wall_y - slab_x)/2;

module make_slab()
{
    // grow about center x
    translate([_slab_offset, 0, 0])
    {
        cube([slab_x, slab_y, slab_z]);
    }
}

module make_linear_hole()
{
    rotate([-90,0,0]) cylinder(slab_y,linear_bearing_or,linear_bearing_or);
    // infinite hole
    rotate([-90,0,180]) cylinder(forever,linear_bearing_ir,linear_bearing_ir);
}

overhang_x = 0.40; // percentage
slab_cut_x = bearing_or*2 * (1- overhang_x) ;
slab_cut_y = slab_y/5;
slab_cut_z = bearing_or/2.0 + slab_z/2.0 + ptol;

slab_cut2_x = bearing_or*2;
slab_cut2_y = bearing_y;
slab_cut2_z = bearing_or/2.0 + slab_z/2.0 + ptol;

module make_bearing_insert()
{
    translate([-slab_cut_x/2, 0, -bearing_or/2 - ptol])
    {
        cube([slab_cut_x, slab_cut_y, slab_cut_z]);
    }
    translate([-slab_cut2_x/2, slab_cut_y, -bearing_or/2 - ptol])
    {
        cube([slab_cut2_x, slab_cut2_y, slab_cut2_z]);
    }
    /*rotate([-90,0,0]) cylinder(bearing_y,bearing_or,bearing_or);*/
    // infinite hole
    r = bearing_ir - threaded_rod_r_grip;
    rotate([-90,0,180]) cylinder(forever,r,r);
}


module make_slab_holes()
{
    /*translate([_slab_offset, 0, 0])*/
    {
        translate([(linear_bearing_offset+_slab_offset),0,slab_z/2])
        {
            if ($children > 0) children(0);
        }
        translate([tall_wall_y - (linear_bearing_offset+_slab_offset),0,slab_z/2])
        {
            if ($children > 2) children(2);
        }
        translate([tall_wall_y/2,0,slab_z/2])
        {
            if ($children > 1) children(1);
        }
    }
}

difference()
{
    color ("green") make_slab();
    make_slab_holes()
    {
        make_linear_hole();
        make_bearing_insert();
        make_linear_hole();
    }
}

