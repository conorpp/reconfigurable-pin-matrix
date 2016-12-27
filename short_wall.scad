include <defs.scad>
use <assembly.scad>
use <slab.scad>

module short_wall_holes()
{
    
}

module ShortWall()
{
    cube([ short_wall_x, short_wall_y, short_wall_z]);
}

module _put_screw_holes(rot=0)
{
    translate([0,slab_thickness/2,short_wall_z/5])
    {
        rotate([0,90,0+rot])
            cylinder(wall_screw_l, wall_screw_ri, wall_screw_ri);
        rotate([0,90,180+rot])
            cylinder(forever, wall_screw_ri, wall_screw_ri);
    }
    translate([0,slab_thickness/2,short_wall_z*4/5])
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
        translate([short_wall_cut_offset,0,0])
        {
            cube([short_wall_cut_x, short_wall_cut_y, short_wall_cut_z]);
        }
        translate([tall_wall_y - short_wall_cut_offset - short_wall_cut_x,0,0])
        {
            cube([short_wall_cut_x, short_wall_cut_y, short_wall_cut_z]);
        }

        /*_put_screw_holes();*/
        /*translate([slab_l,0,0])*/
            /*_put_screw_holes(180);*/
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




