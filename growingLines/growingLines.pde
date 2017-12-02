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
    r_ = int(random(128,200));
    g_ = int(random(128,200));
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
void setup() {
  size(500, 500);
  int size_x = 500;
  int size_y = 500;
  
  background(30);
  int try_cnt = 500;
  for(int i=0; i != try_cnt; i++)
  {
    Pos start = new Pos(int(random(size_x)), int(random(size_y)));
    Pos end = new Pos(int(random(size_x)), int(random(size_y)));
    
    // choice long line
    float min_length = 150;
    if(sqrt(pow((end.x_-start.x_),2) + pow((end.y_-start.y_), 2)) > min_length)
      continue;
    
    line_list.add(new GrowingLine(start, end ,5, 300));
  }
}

boolean start = false;
void draw()
{
  if(mousePressed)
    start = true;
  if(!start)
    return;

  for(int i=0; i != line_list.size(); i++)
  {
    Pos p = line_list.get(i).GetPoint();
    stroke(line_list.get(i).r_, line_list.get(i).g_, line_list.get(i).b_);
    strokeWeight(p.weight_);  
    point(p.x_, p.y_);
  }
}