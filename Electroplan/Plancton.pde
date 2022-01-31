class Plancton {
  
  PVector location;
  PVector speed;
  PVector acceleration;
  float w; // largeur du plancton qui grossit en mangeant des algues
  float posX, posY;
  boolean alive = true;
  int randomColor;
  
  Plancton(float x, float y, float tempW) {
    //vecteur Plancton
    location = new PVector(x,y);
    w = tempW;
    speed = new PVector(random(1,2.5),random(-0.2, 0.2));
    acceleration = new PVector(0.2,0.2);
    randomColor = int(random(0,255));
  }
  
  void musix (){
    // une musique aleatoire est chargée a chaque explosion
  if (int(random(11)+1)%2==0 )minim.stop();
  String f1="..//sounds//"+int(random(11)+1)+".mp3";
  mySoundplancton = minim.loadFile(f1);
  mySoundplancton.play();
}
    void move() {
    // Ajout acceleration a la vitesse
    speed.add(acceleration);
    // Ajout vitesse a la trajectoire
    location.add(speed);
    // si la bombe touche le fond 
    // elle ne bouge plus
    posX = location.x;
    posY = location.y;
  }
  
  
  void display() {
      strokeWeight(3);
      stroke(0);
 // antennes 
      line(location.x,location.y-10,location.x + 5,location.y + 10);
      line(location.x + 30,location.y-10, location.x + 25, location.y + 10);
      fill(255,randomColor,75,score + 25); 
      strokeWeight(1);
 // corps en ellipse     
      ellipse(location.x + 15, location.y + 50, 50+w/100, 100+w/100);
 // creation de l oeil via 2 cercles     
      fill(244, 242, 140);
      circle(location.x + 15,location.y + 40, 20);
      fill(255, 53, 12);
      circle(location.x + 15, location.y + 40, 10);
  }

void checkEdges() {
    //verifie si le plancton touche les bords
    // vitesse inverse deplacement contraire
    if(location.x + w/2 >= width){
      location.x = width - w/2;
      speed.x *= -1;
    }
    else if(location.x - 45 < 0){
      location.x = 50;
      speed.x *= -1;
    }
    if(location.y + w/2 >= height || location.y <= 0){
      speed.y *= -1;
      location.y = height - w/2;
    }
  }
  
  
// si mange algue => vit + , vitesse +, acceleration + largeur
  void eat(Algue _a){
    if(dist(posX, posY, _a.posX, _a.posY) <= 1 && _a.H >= 1 && score <= 50){
      score += 0.0001;
      _a.H -= 3;
      w += 1; // influence la largeur du plancton 
      speed.x *= 1.001;
    }
}

// Si le plancton ne mange pas d algues
// il est affame 
// son score de vie diminue, il maigrit et.... il va moins vite
void hunger(){
  score -= 0.0001;
  w -= 0.001; // le plancton maigrit legerement
  speed.x /= 1.00001;
}
  
}
