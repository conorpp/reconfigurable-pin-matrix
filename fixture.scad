include <defs.scad>



module Fixture()
{
    difference()
    {
        _Fixture();
        fixture_cuts();
    }
}


module _Fixture()
{
    cube([fixture_x, fixture_y, fixture_z]);
}

module fixture_cuts()
{
    // cut
    translate([(fixture_x - fixture_top_cut_x)/2, (fixture_y - fixture_top_cut_y)/2, fixture_z-fixture_top_cut_z])
    {
        cube([fixture_top_cut_x, fixture_top_cut_y, fixture_top_cut_z]);
    }

    // hole
    translate([fixture_x/2,fixture_y/2, 0])
    {
        cylinder([fixture_wall_z, fixture_bottom_hole_r, fixture_bottom_hole_r]);
    }

}



Fixture();

