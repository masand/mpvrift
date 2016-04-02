const float maxr = sqrt(2.0);

vec4 sample(sampler2D tex, vec2 pos, vec2 tex_size)
{
  // central points for the 2 eyes assumed at (0.25, 0.5) and (0.75, 0.5)
  // -> shift both x and y to a 2 coordinate systems with a range of [-1;1] each
  vec2 mypos;
  mypos.y = 2.0*(pos.y - 0.5);
  mypos.x =(pos.x - 0.25); if (pos.x > 0.5) mypos.x = (pos.x - 0.75);
  mypos.x *= 4.0;
    
  float r = length(mypos);
  
  // needed to normalize r to have the transformation below working
  float rn = r;// / maxr;

  // -> range of f_r: [1, 1.46] -> factor of elongation
  float f_r = 0.24 * pow(rn, 4) + 0.22 * pow(rn, 2) + 1;

  float alpha = atan(mypos.y, mypos.x);

  float offset_x = r * f_r * cos(alpha);
  float newx = abs(0.25 + offset_x / 4.0);
  if (pos.x > 0.5) newx = abs(0.75 + offset_x / 4.0);
  float offset_y = r * f_r * sin(alpha);
  float newy = abs(0.5 + offset_y / 2.0);
  
  float startx = 0.0;
  if (pos.x > 0.5) startx = 0.5;
  float stopx = startx + 0.5;
  bool outside = true;
  
  // check for being outside of the boundaries
  if(offset_x > -1.0 && offset_y > -1.0 && offset_x < 1.0 && offset_y < 1.0)
	  outside = false;

  vec4 p = texture(tex, vec2(newx, newy));
  
  // set everything outside the "barrel" to black
  if (outside) p = vec4(0.0);
  
  return p;
}