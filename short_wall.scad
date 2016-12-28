include <defs.scad>
use <assembly.scad>
use <slab.scad>

module short_wall_holes()
{
    
}

short_wall_ext_x = tall_wall_x + ptol/2;
short_wall_ext_y = short_wall_y;
short_wall_ext_z = short_wall_z;

module ShortWall()
{
    difference()
    {
        _ShortWall();
        short_wall_cuts();
    }
}

module _ShortWall()
{
    cube([ short_wall_x, short_wall_y, short_wall_z]);
    translate([-short_wall_ext_x,0,0])
    {
        orange() cube([ short_wall_ext_x, short_wall_ext_y, short_wall_ext_z]);
    }
    translate([short_wall_x,0,0])
    {
        orange() cube([ short_wall_ext_x, short_wall_ext_y, short_wall_ext_z]);
    }

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
}

module short_wall_cuts()
{
    translate([-short_wall_ext_x + short_wall_cut_x,0,0])
    {
        cube([short_wall_cut_x, short_wall_cut_y, short_wall_cut_z]);
    }
    // account for tolerance spacing in short_wall_ext_x
    translate([short_wall_x + short_wall_ext_x - 2*short_wall_cut_x,0,0])
    {
        cube([short_wall_cut_x, short_wall_cut_y, short_wall_cut_z]);
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




