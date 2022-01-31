class Vitamine{
  PVector pos, vel, accel;
  float posX, posY, velX, velY;
  float radius;
  boolean stopped = false;
  
  
  // les vitamines suivent un mouvement lineaire
  // initialise par un vecteur vitesse et acceleration
  // ici le mouvement est verticale
  Vitamine(){
    radius = random(20,15); 
    pos = new PVector(random(radius, width - radius),1);
    vel = new PVector(0, random(4, 4));
    accel = new PVector(0,0.2);
  }

  
  // La vitamine a une forme 
  // de Rectangle
  // de couleur orange 
  void display(){
    noStroke();
    fill(255,204,51); // couleur vitamine
    rectMode(CENTER);
    rect(pos.x, pos.y, radius*2, radius*2);
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
  

  //// LA fonction VITA permet de faire grimper le score de 5
  /// en mangeant la vitamine , le plancton la fait disparaitre
  /// stoppe le procerssus
  
  void vita(Plancton _p){
  if(dist(posX, posY, _p.posX, _p.posY) <= 50){
   //plancton vitalise
   pos.x=0;
   pos.y=0;
   score+=5;
  _p.alive = true;
  stopped = true;
  }
  }
  
}
