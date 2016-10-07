
include <definitions.scad>
use <pin.scad>

module base()render(convexity = 1)
{ 
    translate([-bwidth/2, -bwidth/2, 0])
    {
        cube([bwidth,bwidth,bthickness]); 
    } 
}

module pin_hole_row() render(convexity = 1)
{
    translate([pbasewidth/2, pbasewidth/2,0])
    {

        for (i = [0 : ptwidth : pbasewidth])
        {
            translate([-i,0,0])
            {
                cube([pbwidth,pbwidth,bthickness]);
            }
        }
    }
}


module all_pin_holes()
{

    for (i = [0 : ptwidth : pbasewidth])
    {
        translate([0,-i,0])
        {
            pin_hole_row();
        }
    } 
}

module base_holes()
{
    difference()
    {
        base();
        all_pin_holes();
    }
}

module place_pins_on_base()
{
    translate([pbasewidth/2 + pbspacing, pbasewidth/2 + pbspacing,0])
    {
        for (i = [0 : ptwidth : pbasewidth])
            for (j = [0 : ptwidth : pbasewidth])
                if (i != 0)
                {
                    translate([-i,-j, j*j/40-i*i/40])
                    {
                        pin();
                    }
                }
                else
                {
                    translate([-i,-j, j*j/40-i*i/40+7])
                    {
                        pin();
                    }
                }

    }
}

base_holes();
translate([0,0, 1.1])
{
    base_holes();
}
translate([0,0,-1.1])
{
    base_holes();
}
place_pins_on_base();
