class Algue{
  float posX, posY;
  float radius;
  float rectW, rectH;
  float H;

  
  
  /// Un algue est composee de petits rectangles arrondis
  Algue(float _x){
    radius = 20; // arrondi
    posX = _x; // position
    H = random(1,3)*10;// hauteur
  }
  
  void display(){
    noStroke();
    fill(73, 147, 60,70);
    rectMode(CENTER);
    
    // algue constituee de petits rectangles arrondis superposes de hauteur totale H 
    for (int i = 0; i <= H; i++){
      posY = height - i*radius;
      rect(posX, posY, radius, radius,10);
    }
  }
  
  // croissance de l algue automatique
  void growth(){
    if(H <= 40){
      H += random(0.001, 0.005);
    }
  }
}
