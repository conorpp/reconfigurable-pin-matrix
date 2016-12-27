include <defs.scad>


module make_slab()
{
    cube([slab_x, slab_y, slab_z]);
}

module make_linear_hole()
{
    rotate([-90,0,0]) cylinder(slab_y,linear_bearing_or,linear_bearing_or);
    // infinite hole
    rotate([-90,0,180]) cylinder(forever,linear_bearing_ir,linear_bearing_ir);
}
module make_bearing_insert()
{
    rotate([-90,0,0]) cylinder(bearing_y,bearing_or,bearing_or);
    // infinite hole
    r = bearing_ir - threaded_rod_r_grip;
    rotate([-90,0,180]) cylinder(forever,r,r);
}


module make_slab_holes()
{
    translate([linear_bearing_offset,0,short_wall_z/2])
    {
        if ($children > 0) children(0);
    }
    translate([tall_wall_y - linear_bearing_offset,0,short_wall_z/2])
    {
        if ($children > 2) children(2);
    }
    translate([tall_wall_y/2,0,short_wall_z/2])
    {
        if ($children > 1) children(1);
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

