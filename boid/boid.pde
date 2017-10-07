class Vec2{
  Vec2(float inx, float iny){
    x = inx;
    y = iny;
  }
  float x;
  float y;
}

class Bird{
  Bird(Vec2 inPos, Vec2 inVel, int inR, int inG, int inB){
    position = inPos;
    velocity = inVel;
    r = inR;
    g = inG;
    b = inB;
  }
  Vec2 position;
  Vec2 velocity;
  int r, g, b;
}

int windowX=400, windowY = 400;
int numOfBird = 60;
boolean startFlag = false;
Bird[] birds;

void rule1(int index)
{
  Vec2 center = new Vec2(0,0);
  for(int i =0; i != numOfBird;i++){
    if(i != index)
    {
      center.x += birds[i].position.x;
      center.y += birds[i].position.y;
    }
  }
  center.x /= numOfBird -1;
  center.y /= numOfBird -1;
  
  birds[index].velocity.x += (center.x - birds[index].position.x)/100;
  birds[index].velocity.y += (center.y - birds[index].position.y)/100;
}

void rule2(int index)
{
  for(int i=0; i != numOfBird; i++)
  {
    if(i != index)
    {
      Vec2 distVec = new Vec2(birds[i].position.x - birds[index].position.x, birds[i].position.y - birds[index].position.y);
      float distance = sqrt(distVec.x * distVec.x + distVec.y * distVec.y);
      if(distance < 10)
      {
        birds[index].velocity.x -= birds[i].position.x - birds[index].position.x;
        birds[index].velocity.y -= birds[i].position.y - birds[index].position.y;
      }
    }
  }
}

void rule3(int index)
{
  Vec2 meanVel = new Vec2(0, 0);
  for(int i=0; i != numOfBird; i++)
  {
    if(i != index)
    {
      meanVel.x += birds[i].velocity.x;
      meanVel.y += birds[i].velocity.y;
    }
  }
  meanVel.x /= numOfBird -1;
  meanVel.y /= numOfBird -1;
  
  birds[index].velocity.x += (meanVel.x - birds[index].velocity.x) / 4;
  birds[index].velocity.y += (meanVel.y - birds[index].velocity.y) / 4;
  
}

void updatePosition(){
  for(int i=0; i != numOfBird; i++){
    rule1(i);
    rule2(i);
    rule3(i);
    
    Vec2 pos = birds[i].position;
    Vec2 vel = birds[i].velocity;
    
    float speed = sqrt(vel.x * vel.x + vel.y + vel.y);
    if(speed >= 7){
      float r = 7 / speed;
      birds[i].velocity.x *= r;
      birds[i].velocity.y *= r;

  }
    
    if(pos.x < 0 && vel.x < 0 || pos.x > windowX && vel.x > 0)
      birds[i].velocity.x *= -1;
    if(pos.y < 0 && vel.y < 0 || pos.y > windowY && vel.y > 0)
      birds[i].velocity.y *= -1;
      
    birds[i].position.x += birds[i].velocity.x;
    birds[i].position.y += birds[i].velocity.y;
  }
}

void setup(){
  size(400, 400);
  birds = new Bird[numOfBird];
  for(int i =0; i != numOfBird; i++){
    Vec2 position = new Vec2(random(windowX),random(windowY));
    Vec2 velocity = new Vec2(0,0);
    int r = (int)random(255);
    int g = (int)random(255);
    int b = (int)random(255);
    birds[i] = new Bird(position, velocity, r, g, b);
  }
}

void draw(){
  background(30);
    
  for(int i = 0; i != numOfBird; i++){
    stroke(birds[i].r, birds[i].g, birds[i].b);
    fill(birds[i].r, birds[i].g, birds[i].b);
    ellipse(birds[i].position.x, birds[i].position.y, 8,8);
  }

  if(!startFlag)
    return;
  updatePosition();
}

void keyPressed(){
  if(key == 'S' || key == 's')
    startFlag = true;
}