class Rocket{
  int x;
  int y;
  int vy;
  ArrayList<Particle> particles = new ArrayList<Particle>();
  ArrayList<Particle> sparks = new ArrayList<Particle>();
  PShape shape;
  boolean visible = true;
  boolean exploded = false;
  float time;
  int sparksCount = 5;
  
  public Rocket(int x, int y, int vy, int n){
    this.x = x; 
    this.y = y;
    this.vy = vy;
    particles = initiateParticles(n);
    shape = makeShape();
    time = millis();
   
  }
  
  PShape makeShape(){
    PShape s = createShape();
    s.beginShape();
    s.fill(200,50,50);
    s.noStroke();
    s.vertex(0, 20);
    s.vertex(10, 20);
    s.vertex(10, 0);
    s.vertex(5, - 5);
    s.vertex(0, 0);
    s.endShape(CLOSE);
    return s;
  }

  ArrayList<Particle> initiateParticles(int n){
    ArrayList<Particle> p = new ArrayList<Particle>();
    char spectrum;
    float random = random(0,6);
    if(random < 1) spectrum = 'r';
    else if(random < 2) spectrum = 'g';
    else if(random < 3) spectrum = 'b';
    else if(random < 4) spectrum = 'c';
    else if(random < 5) spectrum = 'm';
    else spectrum = 'y';
    for(int i = 0; i < n; i++){
      color c = getRandomColor(spectrum);
      p.add(new Particle(x, y, 4, random(-5, 5), random(-5, 5), c, false));
      if(Math.abs(p.get(i).vx) + Math.abs(p.get(i).vy) >= 7) {
        p.get(i).vx *= random(0,.7);
        p.get(i).vy *= random(0,.7);
        
      }
    }
    return p;
  }
  color getRandomColor(char spectrum){
    color c = color(0,0,0);
    switch(spectrum){
      case 'r':{
        c = color(random(200, 255), random(127), random(127));
        break;
      }
      case 'g':{
        c = color(random(127), random(200, 255), random(127));
        break;
      }
      case 'b':{
        c = color(random(127), random(127), random(200, 255));
        break;
      }
      case 'c':{
        c = color(random(127), random(200, 255), random(200, 255));
        break;
      }
      case 'm':{
        c = color(random(200, 255), random(127), random(200, 255));
        break;
      }
      case 'y':{
        c = color(random(200, 255), random(200, 255), random(127));
        break;
      }
    }
    
    return c;
  }
  
  void display(){
    if(visible) shape(shape, x, y);
  }
  void update(){
    y -= vy;
    if(y < 75){
      explode();
    }
    
    for(int i = 0; i < particles.size(); i++){
      if(visible){
        particles.get(i).x = this.x;
        particles.get(i).y = this.y;
      }
      particles.get(i).display();
      particles.get(i).update();
    }
    handleSparks();
  }
  
  void explode(){
    
    visible = false;
    for(int i = 0; i < particles.size(); i++){
      particles.get(i).visible = true;
    }
  }
  
  void handleSparks(){
    if(visible){
      for(int i = 0; i < sparksCount; i++) sparks.add(new Particle(x + random(0,5), y + 40, 3, random(-4,4), random(1,8), color(random(200, 255), random(127, 190), 0), true)); 
       
      for(int i = 0; i < sparks.size(); i++){
        if(millis() - sparks.get(i).time >= 100) sparks.remove(i);
        sparks.get(i).display();
        sparks.get(i).update();
      }
    }
    
  }
    
}
