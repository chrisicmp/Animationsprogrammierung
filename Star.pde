class Star{
  int x;
  int y;
  int w;
  int delay;
  int scale;
  int oldScale;
  color c = color(255,255,255);
  int amount;
  int timer;
  
  public Star(int x, int y, int w, int delay){
    this.x = x;
    this.y = y;
    this.w = w;
    scale = 5*w;
    this.delay = delay;
    oldScale = scale;
    calcAmount();
  }
  
  void display(){
    fill(c);
    rect(x, y, w, w);
    int counter = 1;
    for(int i = w; i < scale / 2; i+= w){
      fill(twinkle(counter));
      rect(x, y - i, w, w);
      rect(x, y + i, w, w);
      rect(x - i, y, w, w);
      rect(x + i, y, w, w);
      counter++;
    }
  }
  
  color twinkle(int n){
    color newC = color(255,255,255);
    newC = color(255 - n * amount, 255 - n * amount, 255 - n * amount);
    if(millis() - timer >= delay) {
      float rand = random(0,1);

         if(rand >= .5f) {
        if(scale > 5*w) scale-= w;
        else scale+=w;
      }
      else{            
        if(scale < 15*w) scale+=w;
        else scale-=w;
      }
      timer = millis();
    }
    calcAmount();
    return newC;
  }
   
  void calcAmount(){
    amount = 255 / ((scale / 2) / w);

  }
}
