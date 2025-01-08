import processing.sound.*;
SoundFile sound;

Star[] star;
Pipesystem ps = new Pipesystem();
boolean pressed = false;
boolean game_running = true;
boolean won = false;
ArrayList<Rocket> rockets = new ArrayList<Rocket>();
float boxWidth = 40;
float boxHeight = 40;
float[] randomX = new float[100];
float[] randomY = new float[100];
void setup(){
  size(1000, 640);
  surface.setResizable(true);
  makePipes();
  star = new Star[100];
  for(int i = 0; i < 100; i++){
    randomX[i] = random(0,1);
    randomY[i] = random(0,1);
    star[i] = new Star((int)(width * randomX[i]), (int)(height * randomY[i]), 1, (int) random(100,200));

  }
  sound = new SoundFile(this, "source/Explosion.wav");
  sound.amp(.2);
}

void draw() {
  if(game_running){
    boxWidth = width / 25;
    boxHeight = height / 16;
    background(200);
    stroke(127);
    for(int k = 0; k < ps.pipes.size(); k++){
      Pipe p = ps.pipes.get(k);
      p.w = boxWidth;
      p.h = boxHeight;
      if(k <= 20) {
        p.x = k * boxWidth + 2 * boxWidth;
        p.y = boxHeight;
      }
      else {
        p.x = ((k % 21) * boxWidth) + 2 * boxWidth;
        p.y = ((k - 21) / 21) * boxHeight + 2 * boxHeight;
      }
      
        
      
    }
    for(int i = 0; i < width; i += boxWidth){
      for(int j = 0; j < height; j += boxHeight){
        if(i == boxWidth && j == boxHeight) fill(#20ff20);  
        else if(i == 23 * boxWidth && j == 14 * boxHeight) fill(#ff2020);   
        else if(i < 2 * boxWidth || i > width - 3*boxWidth || j == 0 || j > height - 2*boxHeight) fill(50);
        else fill(200);
        rect(i, j, boxWidth, boxHeight);
      }
    }
   
    
    ps.updatePipes();
    for(int i = 0; i < ps.getPipes().size(); i++){
      if(ps.getPipes().get(i).touches()){
        strokeWeight(3);
        stroke(50);
        fill(0, 1);
        rect(ps.getPipes().get(i).x, ps.getPipes().get(i).y, boxWidth, boxHeight);
        strokeWeight(1);
        stroke(127);
      }
    }
    game_running = !ps.path;
    
  }
  else{
    if(!won){
      won = true;
      delay(1000);
    }
    background(0);
    //Stars
    for(int i = 0; i < 100; i++) {
      star[i].x = (int)(width * randomX[i]); 
      star[i].y = (int)(height * randomY[i]);
      star[i].display();
    }
    //
    fill(200);
    textSize(100);
    text("Winner!", width / 2 - 190, height / 2);
    stroke(200);
    strokeWeight(10);
    line(50, height / 2 + 10, width - 50, height/ 2 + 10);
    textSize(25);
    text("click anywhere to enjoy being a winner!", width / 2 - 240, height / 2 + 50);
    noStroke();
    
    rect(10, height - 60, 125, 40);
    fill(0);
    textSize(15);
    text("CLOSE", 45, height - 35);
    updateRockets();
    
    
  }
}

void makePipes(){
  for(float i = 0; i < height; i+=40){
    for(float j = 0; j < width; j+=40){
      if((i >= 40 && j > 40) && (i < height - 40 && j < width - 80)){
        if(!(i == 0 || i == height - 40 || j == 0 || j == width - 40)){
          
          float r = random(0,1);
          int rRotation = (int)random(0,3);
          Pipe newP;
          if(r >= .5) newP = new Pipe(j, i, boxWidth, boxHeight, true, rRotation);
          else newP = new Pipe(j,i, boxWidth, boxHeight, false, rRotation);
          ps.addPipe(newP);
        }
      }
    }
  }
  ps.findPath(0, ps.getPipes().get(0).rotationCounter);
  ps.findPath2(ps.getPipes().size() - 1, ps.getPipes().get(ps.getPipes().size() - 1).rotationCounter);
}


void mouseReleased(){
  if(game_running){
    for(int i = 0; i < ps.getPipes().size(); i++){
      if(ps.getPipes().get(i).touches()) {
        ps.getPipes().get(i).setPressed(!ps.getPipes().get(i).getPressed());
        ps.getPipes().get(i).incrementRotCounter();
      }
      else if(mouseX >= width / 2 - 40 && mouseX <= width / 2 + 80){
        if(mouseY >= height - 38 && mouseY <= height - 2){
          ps.resetPipes();
          ps.findPath(0, ps.getPipes().get(0).rotationCounter);
          ps.findPath2(ps.getPipes().size() - 1, ps.getPipes().get(ps.getPipes().size() - 1).rotationCounter);
        }
      }
    }
    ps.resetPipes();
    ps.findPath(0, ps.getPipes().get(0).rotationCounter);
    ps.findPath2(ps.getPipes().size() - 1, ps.getPipes().get(ps.getPipes().size() - 1).rotationCounter);

  }
  else{
    if(mouseX > 0 && mouseX < 135 && mouseY > height - 70 && mouseY < height) exit();
    else if(frameRate >= 50) rockets.add(new Rocket(mouseX, mouseY, 10, 1000));
    

  }
}

void updateRockets(){
  for(int i = 0; i < rockets.size(); i++){
    rockets.get(i).display();
    rockets.get(i).update();
    if(!(rockets.get(i).visible || rockets.get(i).exploded)){
      rockets.get(i).exploded = true;
      sound.play();
    }
    if(millis() - rockets.get(i).time >= 6000) rockets.remove(i);
  }
}
