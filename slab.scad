include <defs.scad>

module make_slab()
{
    cube([slab_l, slab_thickness, depth]);
}

module make_linear_hole()
{
    rotate([-90,0,0]) cylinder(slab_thickness,linear_bearing_outside_r,linear_bearing_outside_r);
    // infinite hole
    rotate([-90,0,180]) cylinder(forever,linear_bearing_outside_r,linear_bearing_outside_r);
}
module make_bearing_insert()
{
    rotate([-90,0,0]) cylinder(bearing_depth,bearing_outside_r,bearing_outside_r);
    // infinite hole
    rotate([-90,0,180]) cylinder(forever,bearing_inside_r+0.2,bearing_inside_r+0.2);
}


module make_slab_holes()
{
    translate([linear_rod_offset,0,depth/2])
    {
        if ($children > 0) children(0);
    }
    translate([slab_l - linear_rod_offset,0,depth/2])
    {
        if ($children > 2) children(2);
    }
    translate([slab_l/2,0,depth/2])
    {
        if ($children > 1) children(1);
    }
}

difference()
{
    make_slab();
    make_slab_holes()
    {
        make_linear_hole();
        make_bearing_insert();
        make_linear_hole();
    }
}

