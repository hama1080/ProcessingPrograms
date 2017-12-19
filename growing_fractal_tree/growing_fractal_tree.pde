class Pos{
  Pos(){
    x_=0;
    y_=0;
  }
  Pos(float x, float y){
    x_=x;
    y_=y;
  }
  
  Pos Add(Pos rhs){
    Pos tmp = new Pos(x_, y_);
    tmp.x_ += rhs.x_;
    tmp.y_ += rhs.y_;
    return tmp;
  }

  Pos Sub(Pos rhs){
    Pos tmp = new Pos(x_, y_);
    tmp.x_ -= rhs.x_;
    tmp.y_ -= rhs.y_;
    return tmp;
  }
  
  Pos Div(float rhs){
    Pos tmp = new Pos(x_, y_);
    tmp.x_ /= rhs;
    tmp.y_ /= rhs;
    return tmp;
  }

  Pos Mul(float rhs){
    Pos tmp = new Pos(x_, y_);
    tmp.x_ *= rhs;
    tmp.y_ *= rhs;
    return tmp;
  }

  float x_;
  float y_;
  float weight_;
}

class GrowingLine
{
  GrowingLine(Pos start, Pos end, int max_weight, int split_cnt)
  {
    diff_ = new Pos();
    start_ = start;
    end_ = end;
    max_weight_ = max_weight;
    split_cnt_ = split_cnt;
    r_ = int(random(128,256));
    g_ = int(random(128,256));
    b_ = int(random(128,256));
    
    diff_ = end.Sub(start_);
    diff_ = diff_.Div(split_cnt_);
    diff_.weight_ = (float)max_weight_ / split_cnt_;
    cnt_ = 0;
  }
  
  Pos GetPoint()
  {
    cnt_++;
    Pos data = new Pos();
    data = start_.Add(diff_.Mul(cnt_));
    data.weight_ = diff_.weight_ * cnt_;
    if(cnt_ == split_cnt_)
      cnt_ = 0;
    return data;
  }
  
  private Pos start_;
  private Pos end_;
  private Pos diff_;
  
  private int max_weight_;
  private int r_, g_, b_;
  private int split_cnt_;
  private int cnt_;
}

ArrayList<GrowingLine> line_list = new ArrayList<GrowingLine>();
HashMap<Integer, ArrayList<GrowingLine>> line_map = new HashMap<Integer, ArrayList<GrowingLine>>();

// recursive function to render a fractal tree
//   start_x, start_y: start position of rendering a branch
//   degree: branch degree
//   depth: depth of the recursive function
//   length: rendering length of a branch
void CreateFractalTree(int start_x, int start_y, double degree, int depth, double length)
{
  int end_x = start_x + (int)(Math.cos(degree) * length);
  int end_y = start_y - (int)(Math.sin(degree) * length);

  line_list.add(new GrowingLine(new Pos(start_x, start_y), new Pos(end_x, end_y) ,5, 20));

  if (depth > 0)
  {
    double diff_degree = Math.random() * PI/5;
    double shrink_rate = random(8, 10) / 10.0;
    CreateFractalTree(end_x, end_y, degree - diff_degree, depth-1, length * shrink_rate);
    CreateFractalTree(end_x, end_y, degree + diff_degree, depth-1, length * shrink_rate);
  }
}

void CreateFractalTree2(int start_x, int start_y, double degree, int depth, double length)
{
  int end_x = start_x + (int)(Math.cos(degree) * length);
  int end_y = start_y - (int)(Math.sin(degree) * length);

  if(!line_map.containsKey(depth))
    line_map.put(depth, new ArrayList());
    
  line_map.get(depth).add(new GrowingLine(new Pos(start_x, start_y), new Pos(end_x, end_y) ,5, 20));
  if (depth > 0)
  {
    double diff_degree = Math.random() * PI/5;
    double shrink_rate = random(8, 10) / 10.0;
    CreateFractalTree2(end_x, end_y, degree - diff_degree, depth-1, length * shrink_rate);
    CreateFractalTree2(end_x, end_y, degree + diff_degree, depth-1, length * shrink_rate);
  }
}

void setup() {
  size(500, 500);
  int size_x = 500;
  int size_y = 500;
  
  background(30);
  CreateFractalTree(250, 400, PI/2, 6, 40);
  //CreateFractalTree2(250, 400, PI/2, 8, 40);

}

boolean start = false;
int draw_cnt = 0;
int line_list_i = 0;

int degree_i = 8;
void draw()
{
  if(mousePressed)
    start = true;
  if(!start)
    return;

  draw_cnt++;

  Pos p = line_list.get(line_list_i).GetPoint();
  stroke(line_list.get(line_list_i).r_, line_list.get(line_list_i).g_, line_list.get(line_list_i).b_);
  strokeWeight(p.weight_);  
  point(p.x_, p.y_);

  if(draw_cnt % 20 == 0)
    line_list_i++;

  if(line_list_i == line_list.size())
  {
    draw_cnt = 0;
    line_list_i = 0;
  }
  
  //ArrayList<GrowingLine> line_list = line_map.get(degree_i);
  //Pos p = line_list.get(line_list_i).GetPoint();
  //stroke(line_list.get(line_list_i).r_, line_list.get(line_list_i).g_, line_list.get(line_list_i).b_);
  //strokeWeight(p.weight_);  
  //point(p.x_, p.y_);

  //if(draw_cnt % 20 == 0)
  //  line_list_i++;
  
  //if(line_list_i == line_list.size())
  //{
  //  draw_cnt = 0;
  //  line_list_i = 0;
  //  degree_i--;
  //}
  //if(degree_i < 0)
  //  degree_i = 8;
  
}