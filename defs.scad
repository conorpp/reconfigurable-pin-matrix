
SCALE = 150;
forever = 1000/SCALE;
model_threads = 0;
apply_mold = 1;

inside_width = 130/SCALE;
short_wall_thickness = 20/SCALE;
tall_wall_thickness = 20/SCALE;
outside_width = inside_width + short_wall_thickness*2;
depth = 20/SCALE;
slab_shortener = 4/SCALE;
slab_wall = depth/2;
slab_protrusion = 1.25/SCALE;
hole_rad = 2/SCALE;
ptol = 1/SCALE;

short_wall_l = outside_width;
tall_wall_l = outside_width;

slab_thickness = depth/2;
slab_l = short_wall_l;
slab_thickness = depth/2;
linear_rod_offset = slab_l/10;
linear_bearing_outside_r = 3/SCALE;
linear_bearing_inside_r = 1.5/SCALE;
bearing_outside_r = 5/SCALE;
bearing_inside_r = 2.5/SCALE;
bearing_depth = 5/SCALE;

slabx_o = 20/SCALE;
slaby_o = 15/SCALE;


pin_z = 150/SCALE;
pin_x = 2/SCALE;
matrix_pad = 15/SCALE;
pin_pad = 0.0000/SCALE;



