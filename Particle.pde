class Particle{
  float x;
  float y;
  float w;
  float vx;
  float vy;
  color c;
  float g;
  boolean visible;
  float time;
  
  public Particle(float x, float y, float w, float vx, float vy, color c, boolean visible){
    this.x = x;
    this.y = y;
    this.w = w;
    this.vx = vx;
    this.vy = vy;
    this.c = c;
    this.visible = visible;
    this.time = millis();
    g = .99;
  }
  
  void display(){
    
    fill(c);
    noStroke();
    if(visible){
      rect(x,y,w,w);
    }
  }
  void update(){
    if(visible){
      x += vx;
      y += vy;
      vx *= g;
      vy *= g;
      if(w > 0) w -= .02;
    }
  }
  
  
}
