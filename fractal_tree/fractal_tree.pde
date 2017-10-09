// recursive function to render a fractal tree
//   start_x, start_y: start position of rendering a branch
//   degree: branch degree
//   depth: depth of the recursive function
//   length: rendering length of a branch
void RenderFractalTree(int start_x, int start_y, double degree, int depth, double length)
{
  int end_x = start_x + (int)(Math.cos(degree) * length);
  int end_y = start_y - (int)(Math.sin(degree) * length);

  strokeWeight(depth / 2);  //change the weight of a line  
  line(start_x, start_y, end_x, end_y);

  if (depth > 0)
  {
    double diff_degree = Math.random() * PI/5;
    double shrink_rate = random(8, 10) / 10.0;
    RenderFractalTree(end_x, end_y, degree - diff_degree, depth-1, length * shrink_rate);
    RenderFractalTree(end_x, end_y, degree + diff_degree, depth-1, length * shrink_rate);
  }
}

void setup() {
  size(500, 500);
}

void draw()
{
  if (mousePressed) {
    float render_color = random(0, 64);  //create monochrome color
    stroke(render_color);

    RenderFractalTree(mouseX, mouseY, PI/2, 10, 15);
    delay(100);
  }
}