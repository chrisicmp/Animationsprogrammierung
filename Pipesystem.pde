class Pipesystem{
  ArrayList<Pipe> pipes;
  boolean path = false;
  Pipesystem(){
    pipes = new ArrayList<Pipe>();
    
  }
  
  ArrayList<Pipe> getPipes(){return pipes;}
  
  void addPipe(Pipe p){
    pipes.add(p);
  }
  void resetPipes(){
    for(int i = 0; i < pipes.size(); i++){
      pipes.get(i).c = 127;
    }
  }
  
  void displayPipes(){
    for(int i = 0; i < pipes.size(); i++){
      pipes.get(i).display(0);
    }
  }
  void updatePipes(){
    
      for(int i = 0; i < pipes.size(); i++){
        Pipe p = pipes.get(i);
        p.display(radians(90 * (p.rotationCounter)));
      }
    
  }
  
  void paintPath(color compare, color replace){
    for(int i = 0; i < pipes.size(); i++){
      if(pipes.get(i).c == compare) pipes.get(i).c = replace;
    }
  }  
  
  void findPath(int start, int rot){
    Pipe s = pipes.get(start);
    path = false;
    if(start == pipes.size()-1){
      if((s.rotationCounter == 2 && s.corner) || (s.rotationCounter %2 == 0 && !s.corner)){
          System.out.println("Path Found!");
          pipes.get(pipes.size()-1).c = #fcba03;
          paintPath(#20ff20, #fcba03);
          path = true;
        }
    }
    else if(start >= 0){
      if(start == 0){
        if(((s.rotationCounter == 0 || s.rotationCounter == 1) && s.corner) || (s.rotationCounter %2 == 0 && !s.corner)){
          s.c = #20ff20;
        }
        else s.c= 127;
      }
      else s.c = #20ff20;
      if((pipes.get(0).rotationCounter == 0 && pipes.get(0).corner) || (pipes.get(0).rotationCounter %2 == 0 && !pipes.get(0).corner)){

        //Pipe Area width: 21, height: 14
        if(start >= 21 && (((rot == 1 || rot == 2) && s.corner) || ((rot == 1 || rot == 3) && !s.corner))){  //if up is available
          Pipe up = pipes.get(start - 21);
          if(((((up.rotationCounter == 0 || up.rotationCounter == 3) && up.corner) 
           || ((up.rotationCounter == 1 || up.rotationCounter == 3) && !up.corner)))
           && (((s.rotationCounter == 1 || s.rotationCounter == 2) && s.corner) 
           || ((s.rotationCounter == 1 || s.rotationCounter == 3) && !s.corner))){
            if(up.c == 127){
              s.c = #20ff20;
              findPath(start - 21, up.rotationCounter);
            }
          }
        }
        if(start % 21 != 0 && start > 0 && (((rot == 0 || rot == 1) && s.corner) || ((rot == 0 || rot == 2) && !s.corner))){  //if left is available
          Pipe left = pipes.get(start - 1);
          if(((((left.rotationCounter == 2 || left.rotationCounter == 3) && left.corner) 
           || ((left.rotationCounter == 0 || left.rotationCounter == 2) && !left.corner)))
           && (((s.rotationCounter == 0 || s.rotationCounter == 1) && s.corner) 
           || ((s.rotationCounter == 0 || s.rotationCounter == 2) && !s.corner))){
            if(left.c == 127){
              s.c = #20ff20;
              findPath(start - 1, left.rotationCounter);
            }
          }
        }
        if(start + 21 < pipes.size() && (((rot == 0 || rot == 3) && s.corner) || ((rot == 1 || rot == 3) && !s.corner))){  //if down is available
          Pipe down = pipes.get(start + 21);
          if(((((down.rotationCounter == 1 || down.rotationCounter == 2) && down.corner) 
           || ((down.rotationCounter == 1 || down.rotationCounter == 3) && !down.corner)))
           && (((s.rotationCounter == 0 || s.rotationCounter == 3) && s.corner) 
           || ((s.rotationCounter == 1 || s.rotationCounter == 3) && !s.corner))){
            if(down.c == 127){
              s.c = #20ff20;
              findPath(start + 21, down.rotationCounter);
            }
          }
        }
        if((start - 20) % 21 != 0 && start < pipes.size() - 1){  //if right is available
          Pipe right = pipes.get(start + 1);
          if(((((right.rotationCounter == 0 || right.rotationCounter == 1) && right.corner) 
           || ((right.rotationCounter == 0 || right.rotationCounter == 2) && !right.corner)))
           && (((s.rotationCounter == 2 || s.rotationCounter == 3) && s.corner) 
           || ((s.rotationCounter == 0 || s.rotationCounter == 2) && !s.corner))){
            
            if(right.c == 127){
              s.c = #20ff20;
              findPath(start + 1, right.rotationCounter);
            }
          }
  
        }
      }
    }  
    
    
  }
  void findPath2(int end, int rot){
    if(!path){
      Pipe s = pipes.get(end);
      if(end <= pipes.size()-1){
        if(end == pipes.size()-1){
          if(((s.rotationCounter == 2 || s.rotationCounter == 3) && s.corner) || (s.rotationCounter %2 == 0 && !s.corner)){
            s.c = #ff4040;
          }
          else s.c= 127;
        }
        else s.c = #ff4040;
        if((pipes.get(pipes.size()-1).rotationCounter == 2 && pipes.get(pipes.size()-1).corner) || (pipes.get(pipes.size()-1).rotationCounter %2 == 0 && !pipes.get(pipes.size()-1).corner)){
  
          //Pipe Area width: 21, height: 14
          if(end >= 21 && (((rot == 1 || rot == 2) && s.corner) || ((rot == 1 || rot == 3) && !s.corner))){  //if up is available
            Pipe up = pipes.get(end - 21);
            if(((((up.rotationCounter == 0 || up.rotationCounter == 3) && up.corner) 
             || ((up.rotationCounter == 1 || up.rotationCounter == 3) && !up.corner)))
             && (((s.rotationCounter == 1 || s.rotationCounter == 2) && s.corner) 
             || ((s.rotationCounter == 1 || s.rotationCounter == 3) && !s.corner))){
              if(up.c == 127){
                s.c = #ff4040;
                findPath2(end - 21, up.rotationCounter);
              }
            }
          }
          if(end % 21 != 0 && end > 0 && (((rot == 0 || rot == 1) && s.corner) || ((rot == 0 || rot == 2) && !s.corner))){  //if left is available
            Pipe left = pipes.get(end - 1);
            if(((((left.rotationCounter == 2 || left.rotationCounter == 3) && left.corner) 
             || ((left.rotationCounter == 0 || left.rotationCounter == 2) && !left.corner)))
             && (((s.rotationCounter == 0 || s.rotationCounter == 1) && s.corner) 
             || ((s.rotationCounter == 0 || s.rotationCounter == 2) && !s.corner))){
              if(left.c == 127){
                s.c = #ff4040;
                findPath2(end - 1, left.rotationCounter);
              }
            }
          }
          if(end + 21 < pipes.size() && (((rot == 0 || rot == 3) && s.corner) || ((rot == 1 || rot == 3) && !s.corner))){  //if down is available
            Pipe down = pipes.get(end + 21);
            if(((((down.rotationCounter == 1 || down.rotationCounter == 2) && down.corner) 
             || ((down.rotationCounter == 1 || down.rotationCounter == 3) && !down.corner)))
             && (((s.rotationCounter == 0 || s.rotationCounter == 3) && s.corner) 
             || ((s.rotationCounter == 1 || s.rotationCounter == 3) && !s.corner))){
              if(down.c == 127){
                s.c = #ff4040;
                findPath2(end + 21, down.rotationCounter);
              }
            }
          }
          if((end - 20) % 21 != 0 && end < pipes.size() - 1){  //if right is available
            Pipe right = pipes.get(end + 1);
            if(((((right.rotationCounter == 0 || right.rotationCounter == 1) && right.corner) 
             || ((right.rotationCounter == 0 || right.rotationCounter == 2) && !right.corner)))
             && (((s.rotationCounter == 2 || s.rotationCounter == 3) && s.corner) 
             || ((s.rotationCounter == 0 || s.rotationCounter == 2) && !s.corner))){
              
              if(right.c == 127){
                s.c = #ff4040;
                findPath2(end + 1, right.rotationCounter);
              }
            }
          }
        }
      }  
    }
  }
}
