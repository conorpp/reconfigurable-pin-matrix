include <defs.scad>
use <assembly.scad>
use <slab.scad>

module short_wall_holes()
{
    
}

module ShortWall()
{
    cube([ outside_width, short_wall_thickness, depth ]);
}

module _put_screw_holes(rot=0)
{
    translate([0,slab_thickness/2,depth/5])
    {
        rotate([0,90,0+rot])
            cylinder(wall_screw_l, wall_screw_ri, wall_screw_ri);
        rotate([0,90,180+rot])
            cylinder(forever, wall_screw_ri, wall_screw_ri);
    }
    translate([0,slab_thickness/2,depth*4/5])
    {
        rotate([0,90,0+rot])
            cylinder(wall_screw_l, wall_screw_ri, wall_screw_ri);
        rotate([0,90,180+rot])
            cylinder(forever, wall_screw_ri, wall_screw_ri);
    }

}

module make_short_wall_holes()
{
    to_short_wall_positions()
    {
        _put_screw_holes();
        translate([slab_l,0,0])
            _put_screw_holes(180);
    }
}


difference()
{
    short_wall_origin()
    {
        ShortWall();
    }
    Holes();
    make_short_wall_holes();
}




