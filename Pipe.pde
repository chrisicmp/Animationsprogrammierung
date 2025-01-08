class Pipe{
  boolean corner;
  PShape shape;
  float x;
  float y;
  float w;
  float h;
  float angle = 0;
  int rotationCounter = 0;
  boolean pressed = false;
  color c = 127;
  
  public Pipe(float x, float y, float w, float h, boolean corner, int startRotation){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.corner = corner;
    rotationCounter = startRotation;
  }
  
  void setPressed(boolean p){pressed = p;}
  boolean getPressed(){return pressed;}
  
  void makeShape(){
    shape = createShape();
    shape.setFill(c);
    shape.setStrokeWeight(1);
    shape.beginShape();
    if(corner){
      if(rotationCounter % 2 == 0){
        x = -w/2;
        y = -h/2;
        shape.vertex(x,y + h / 4);
        shape.vertex(x + w*.75, y + h / 4);
        shape.vertex(x + w*.75, y + h);
        shape.vertex(x + w / 4, y + h);
        shape.vertex(x + w / 4, y + h*.75);
        shape.vertex(x, y + h*.75);
        shape.vertex(x,y);
      }
      else{
        x = -h/2;
        y = -w/2;
        shape.vertex(x,y + w / 4);
        shape.vertex(x + h*.75, y + w / 4);
        shape.vertex(x + h*.75, y + w);
        shape.vertex(x + h / 4, y + w);
        shape.vertex(x + h / 4, y + w*.75);
        shape.vertex(x, y + w*.75);
      }
    }
    else{
      if(rotationCounter % 2 == 0){
        x = -w/2;
        y = -h/2;
        shape.vertex(x,y + h / 4);
        shape.vertex(x+w, y + h / 4);
        shape.vertex(x+w, y+h/2 + h / 4);
        shape.vertex(x, y+h/2 + h / 4);
        shape.vertex(x,y + h / 4);
      }
      else{
        x = -h/2;
        y = -w/2;
        shape.vertex(x,y + w / 4);
        shape.vertex(x+h, y + w / 4);
        shape.vertex(x+h, y+w/2 + w / 4);
        shape.vertex(x, y+w/2 + w / 4);
        shape.vertex(x,y + w / 4);
        
      }
    }
    
    endShape();
  }
  void display(float angle){
    pushMatrix();
    translate(x + w / 2,y + h / 2);
    
    float xTemp = x;
    float yTemp = y;
    
    makeShape();
    x = xTemp;
    y = yTemp;
    rotate(angle);
    shape(shape);
    popMatrix();
  }
  
  void incrementRotCounter(){
    rotationCounter++;
    rotationCounter %= 4;
  }
  
  boolean touches(){
    if(mouseX <= x + w && mouseX >= x){
      if(mouseY <= y + h && mouseY >= y) return true;
    
    }
    
    return false;
  }
  boolean pressed(){
    if(touches() && mousePressed) {
      pressed = true;
      return true;
      
    }
    return false;
  }
  

}
