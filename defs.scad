

// Special
function in2mm( mm ) = mm*25.4;
function mm( mm ) = mm;
module orange() { color("orange") children(); }
module red() { color("red") children(); }
module purple() { color("purple") children(); }
module blue() { color("blue") children(); }
module green() { color("green") children(); }
module black() { color("black") children(); }
$fs = 0.1;
forever = 1000;
//

// Configuration
SCALE = 1.65;  
model_threads = 0;  // inversely proportional to size
apply_pin_matrix = 1;
apply_mold = 1;
apply_fixture = 1;
inside_width = 130/SCALE;
matrix_x = 50.8;
//

// Walls

ptol = 1/SCALE;
_wall_thickness = 20/SCALE;

short_wall_x = inside_width + _wall_thickness*2;
short_wall_y = _wall_thickness;
short_wall_z = 40/SCALE;

tall_wall_x = _wall_thickness;
tall_wall_y = short_wall_x;
tall_wall_z = short_wall_z * 3;

short_wall_cut_y = short_wall_y;
short_wall_cut_x = tall_wall_x/2+ptol;
short_wall_cut_z = short_wall_z*4/5;
short_wall_cut_offset = tall_wall_x/2;

short_wall_ext_x = tall_wall_x + ptol/2;
short_wall_ext_y = short_wall_y;
short_wall_ext_z = short_wall_z;

tall_wall_ext_x = tall_wall_x;
tall_wall_ext_y = tall_wall_y/20;
tall_wall_ext_z = tall_wall_z;

tall_wall_cut_x = tall_wall_x/2;
tall_wall_cut_y = short_wall_y + ptol;

fixture_wall_x = matrix_x * .10;
fixture_wall_y = matrix_x * .10;
fixture_wall_z = matrix_x * .10;

fixture_x = matrix_x + fixture_wall_x*2;
fixture_y = matrix_x + fixture_wall_y*2;
fixture_z = matrix_x/2;

fixture_top_cut_x = fixture_x - fixture_wall_x*2 + ptol/2;
fixture_top_cut_y = fixture_y - fixture_wall_y*2 + ptol/2;
fixture_top_cut_z = fixture_z - fixture_wall_z;

fixture_bottom_hole_r = 5;



slab_shortener = 4/SCALE;
slab_wall = short_wall_z/2;

hole_rad = 2/SCALE;


//

// Slabs and holes

_slab_thickness = in2mm(1.0/4)*2;
_bearing_tightness_e = in2mm(1.0/4/20);

slab_x = tall_wall_y*14/20;
slab_y = _slab_thickness;
slab_z = short_wall_z/2;


linear_bearing_offset = slab_x/40;
linear_bearing_or = in2mm(1/4/2);
linear_bearing_ir = in2mm(1/8/2);



bearing_or = in2mm(1.0/4/2) - _bearing_tightness_e;
bearing_ir = in2mm(1.0/8/2);
bearing_y = in2mm(3.0/32);

threaded_rod_r_grip = in2mm(0.015);  // how much to shrink hole on threaded rod to get traction





//

// Assembly and appearance
slabx_o = in2mm(.3);
slaby_o = in2mm(.0);

pin_z = 150/SCALE;
pin_x = 2/SCALE;
pin_pad = 0.2;

mid_y = tall_wall_y/2;
mid_x = (short_wall_x + short_wall_ext_x*2)/2;

mx_pin_start = mid_x - matrix_x/2;
mx_pin_end = mid_x + matrix_x/2;

my_pin_start = mid_y - matrix_x/2;
my_pin_end = mid_y + matrix_x/2;

//


