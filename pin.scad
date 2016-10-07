
include <definitions.scad>

_v_offset = -pheight/2;
_h_offset = -pbwidth/2;

module pin()
{
    translate([_h_offset,_h_offset, 0])
    {
        translate([0, 0, _v_offset])
        {
            cube([pbwidth, pbwidth, pheight]);
        }
        translate([0, 0, -_v_offset])
        {
            cube([ptwidth, ptwidth, pheight]);
        }
    }
}

pin();
