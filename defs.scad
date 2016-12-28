

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
SCALE = 2;  
model_threads = 0;  // inversely proportional to size
apply_mold = 0;
apply_pin_matrix = 0;
inside_width = 130/SCALE;
//

// Walls

_wall_thickness = 20/SCALE;

short_wall_x = inside_width + _wall_thickness*2;
short_wall_y = _wall_thickness;
short_wall_z = 40/SCALE;

tall_wall_x = _wall_thickness;
tall_wall_y = short_wall_x;
tall_wall_z = short_wall_z * 3;


short_wall_cut_y = short_wall_y;
short_wall_cut_x = tall_wall_x/2;
short_wall_cut_z = short_wall_z*4/5;
short_wall_cut_offset = tall_wall_x/2;

slab_shortener = 4/SCALE;
slab_wall = short_wall_z/2;

hole_rad = 2/SCALE;
ptol = 1/SCALE;
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

slabx_o = in2mm(0.1);
slaby_o = in2mm(0.1);

pin_z = 150/SCALE;
pin_x = 2/SCALE;
matrix_pad_x = 8;
matrix_pad_y = 2;
pin_pad = 0.2;
//
