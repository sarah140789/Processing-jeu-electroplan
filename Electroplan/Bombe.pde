class Bombe{
  PVector pos, vel, accel;
  float posX, posY, velX, velY;
  float radius;
  float ac;
  int counter;
  boolean stopped = false;
  
  Bombe(){
    counter = 0;
    radius = random(20,15);    
    pos = new PVector(random(radius, width - radius),1);
    vel = new PVector(0, random(1, 1));
    accel = new PVector(0.2,0.2);
  }
  
  void display(){
    noStroke();
    fill(6);
    rectMode(CENTER);
    circle(pos.x, pos.y, radius*2);
  }
  
  void move(){
    pos.add(vel);
    vel.add(accel);
    posX = pos.x;
    posY = pos.y;
  }
  
  void applyForce(PVector _force){
    accel.add(_force);
  }
  
  void stop(){
    if (pos.y + radius >= height){
      vel.y = 0;
      accel.y = 0;
      stopped = true;
    }
  }
  
  
  void kill(Plancton _p){
  if(dist(posX, posY, _p.posX, _p.posY) <= _p.w){
      //plancton mort
   pos.x=0;
   pos.y=0;
   score-=3;
  _p.alive = false;
    print("**** Bombe ***");;
  }
  }
  
}
