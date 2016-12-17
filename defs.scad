
function in2mm( mm ) = mm*25.4;
function mm( mm ) = mm;

SCALE = 10/3.3;
forever = 1000/SCALE;
model_threads = 0;
apply_mold = 0;
apply_pin_matrix = 1;

inside_width = 130/SCALE;
short_wall_thickness = 20/SCALE;
tall_wall_thickness = 20/SCALE;
outside_width = inside_width + short_wall_thickness*2;
depth = 40/SCALE;
slab_shortener = 4/SCALE;
slab_wall = depth/2;
slab_protrusion = 1.25/SCALE;
hole_rad = 2/SCALE;
ptol = 1/SCALE;

short_wall_l = outside_width;
tall_wall_l = outside_width;

slab_thickness = in2mm(1.0/4);
slab_l = short_wall_l;
linear_rod_offset = slab_l/10;
linear_bearing_outside_r = in2mm(1/4/2);
linear_bearing_inside_r = in2mm(1/8/2);
bearing_outside_r = in2mm(1.0/4/2);
bearing_inside_r = in2mm(1.0/8/2);
rod_threading_r_offset = in2mm(0.015);
bearing_depth = in2mm(3.0/32);

slabx_o = in2mm(0.1);
slaby_o = in2mm(0.1);


pin_z = 150/SCALE;
pin_x = 2/SCALE;
matrix_pad_x = 8;
matrix_pad_y = 2;
pin_pad = 0.2;


wall_screw_ri = in2mm(0.06);
wall_screw_l = in2mm(1/2);


