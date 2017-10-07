public enum State{
  DEATH(0),
  LIFE(1);
  private int id;
  private State(int id){
    this.id = id;
  }  
  public int GetValue(){
    return this.id;
  }
}

static int DisplaySize = 500;
static int FieldSize = 100;
State field[][] = new State[FieldSize + 2][FieldSize + 2];  //define buffer around the field.

void setup(){
  size(500, 500);  //size function cannot be used numbers.

  //initialize field
  for(int i=0; i != FieldSize + 2; i++){
    for(int j=0; j != FieldSize + 2; j++){
      
      //initialize buffer as death cell.
      if(i == 0 || i == FieldSize + 1 || j == 0 || j == FieldSize + 1){
        field[i][j] = State.DEATH;
        continue;
      }
      
      //initialize field as death or life.
      float rnd = random(1);
      if(rnd > 0.5)
        field[i][j] = State.DEATH;
      else
        field[i][j] = State.LIFE;      
    }
  }
}

void UpdateField()
{
  //copy and clear field
  State field_copy[][] = new State[FieldSize+2][FieldSize+2];
  for(int i=0; i != FieldSize + 2; i++){
    for(int j=0; j != FieldSize + 2; j++){
      field_copy[i][j] = field[i][j];
      field[i][j] = State.DEATH;
    }
  }
  
  //update field
  for(int i=1; i != FieldSize + 1; i++){
    for(int j=1; j != FieldSize + 1; j++){
      //count life cell around target cell
      int life_cnt = 0;
      life_cnt += field_copy[i-1][j-1].GetValue();
      life_cnt += field_copy[i-1][j].GetValue();
      life_cnt += field_copy[i-1][j+1].GetValue();
      life_cnt += field_copy[i][j-1].GetValue();
      life_cnt += field_copy[i][j+1].GetValue();
      life_cnt += field_copy[i+1][j-1].GetValue();
      life_cnt += field_copy[i+1][j].GetValue();
      life_cnt += field_copy[i+1][j+1].GetValue();
      
      if((field_copy[i][j] == State.DEATH) && (life_cnt == 3))
        field[i][j] = State.LIFE;
      else if((field_copy[i][j] == State.LIFE) && (life_cnt == 2 || life_cnt == 3))
        field[i][j] = State.LIFE;
    }
  }
  return;
}

boolean start = false;
void draw()
{
  if(mousePressed)
    start = true;
  if(!start)
    return;

  UpdateField();
  for(int i=1; i != FieldSize + 1; i++){
    for(int j=1; j != FieldSize + 1; j++){
      int CellSize = DisplaySize / FieldSize;
      if(field[i][j] == State.DEATH)
        fill(0);
      else
        fill(0,255,0);
        
      rect((j-1)*CellSize, (i-1)*CellSize, CellSize, CellSize);
    }
  }
  delay(10);

}