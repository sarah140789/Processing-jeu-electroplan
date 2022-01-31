/** 
 * PROJET SARAH BITAN
 * Jeu du Plankton
 * Theme Musical et oceanographique  
 **/

import ddf.minim.*;
import ddf.minim.signals.*;
Minim minim;
AudioPlayer mySound,mySoundplancton;
int timer=0;
float score=10;

ArrayList<Plancton> plancton;
ArrayList < Algue > algue = new ArrayList < Algue > ();
ArrayList < Bombe > bombe = new ArrayList < Bombe  > ();
ArrayList < Vitamine > vitamine = new ArrayList < Vitamine  > ();

//Parametres utils au lancer de Bombes
PVector bombGravity;
int bombCounter;

//Parametres utils a la diffusion de vitamines oxygenees
PVector vitaGravity;
int vitaCounter;

//plancton accroissement largeur
int ballWidth = 60;



void setup() {
  size(800,800);
  noStroke();
  surface.setTitle("Electro Sarah Bitan");
  surface.setResizable(true);
  surface.setLocation(100, 100);
  
  // Creer ArrayList vide placton objects
  plancton = new ArrayList<Plancton>();
  // on initialise en ajoutant un plancton
  plancton.add(new Plancton(width/2, height/2, ballWidth)); 
  
  //on initialise le fond de notre ecran bleu avec 
  // une cinquantaine d algues vertes placees aleatoirement
  algue.add(new Algue(20));
  for(int i = 1; i < 50; i++){
    algue.add(new Algue(random(0, width)));
  }
  
  //bombe ini
  bombe.add(new Bombe());
  bombGravity = new PVector(0.0, -0.0008);
  bombCounter = 0;

  //vitamine  ini
  vitamine.add(new Vitamine());
  vitaGravity = new PVector(0.0, -0.005);
  vitaCounter = 0;
  
  // son intro
  minim = new Minim(this);
  mySound = minim.loadFile("..//sounds//a.mp3");
 
}

void draw() {
  background(3, 61, 196);
  textSize(31);
  fill(255);
  text("Score = "+int(score), 10, 24);  // score 
  textSize(12);
  fill(255);
  text("===> clique avec la souris pour creer du plancton... clique sur la touche espace pour creer des algues", 250, 12);  // score 
  text("===> le plancton mange les vitamines oxygenees +5 et les algues en evitant les bombes -3 ", 250, 24);  // score 
  text("===> clique avec la souris pour creer du plancton... clique sur la touche espace pour creer des algues", 250, 12);  // score 
  text("===> Bonne partie GAIN A 100... la musique change aleatoirment a chaque BOUM explosion", 250, 36);  // score 
if ( (score<100) && (score>0)){
    //algue
    for(Algue a : algue){
      a.display();
      a.growth(); // les algues ont une vie ... elles grandissent seules
    }
    
  //bombes interaction
  // gestion de la trajectoire des bombes via la fonction move 
  // qui est definie dans le fichier bombe.pde
    for(Bombe b : bombe){
      b.applyForce(bombGravity);
      b.move();
      b.display();
      b.stop();
    }

    //vitamine interaction
    // gestion de la trajectoire des vitamines via la fonction move 
    // qui est definie dans le fichier vitamine.pde
    for(Vitamine v : vitamine){
      v.applyForce(vitaGravity);
      v.move();
      v.display();
      v.stop();
    }
  
  ///
  /// GESTION DE L ENSEMBLE DU PLANCTON CREES
  ///
  
  // Pour chaque plancton cree
  // on gere sa trajectoire via la fonction move 
  // on controle s il touche les bords via la fonction checkedge
  // on gere sa faim via la fonction huner
  // on controle sa colision avec une algue via la fonction  eat... il accelere et grossit
  // on controle sa colision avec une vitamine via la fonction  vita... il augmente le score de 5 et ne disparait pas
  // on controle sa colision avec une bombe via la fonction  kill... il meurt dans ce cas et baisse le score de 3
 
  for (int i = plancton.size()-1; i >= 0; i--) { 
    Plancton p = plancton.get(i);
    p.move();
    p.display();
    p.checkEdges();
    p.hunger();
    
    //mange Algue
    for(Algue a : algue){
      p.eat(a);
    }
    //Bombe tue un plancton
    for(Bombe b : bombe){
      b.kill(p);
    }
    //Vitamine nourrit plancton
    for(Vitamine v: vitamine){
      v.vita(p);
    }
    
    // changement de musique quand bombe tue plancton
    if(!p.alive){
      p.musix();
      plancton.remove(i);
    }
  }
  
  
  
  ///
  /// GESTION DE L ENVOI DES BOMBES ET VITAMINES : 
  // il y a 4 fois moins de Vitamines que de Bombes
  //
  
  //larguage de bombes toutes les X secondes
  if(bombCounter%10 == 0) {
    bombe.add(new Bombe());
  }
  bombCounter += 1;

   //Difusion des  vitamines oxygenees toutes les X/4 secondes
  if(vitaCounter%40 == 0) {
    vitamine.add(new Vitamine());
  }
  vitaCounter += 1;
  
}

if(score<0)
{ // score perdant
  textSize(80);
  fill(255,127,0);
  text("VOUS AVEZ PERDU", 100, 300);  
}

if(score>99)
{ // score 
  textSize(80);
  fill(57,255,20);
  text("VOUS AVEZ GAGNE", 100, 300);  // Default depth, no z-value 
}

}

// CREATION DU PLANCTON VIA LE POSITIONNEMENT SOURIS
void mousePressed() {
  // Creation d un nouveau plancton a chaque clique de souris
 plancton.add(new Plancton(mouseX, mouseY, ballWidth)); 
}
// FIN CREATION PLANCTON



// CREATION DES ALGUES : NOURRITURE DU PLANCTON AVEC LES VITAMINES OXYGENEES
void keyPressed() {
// creation de nouvelles algues ralentit la vitesse des bombes on clique sur la barre espace  
  if(keyCode == 32){
    algue.add(new Algue(20)); // on cree par groupe de 2 algues
    for(int i = 1; i < 3; i++){
      algue.add(new Algue(random(0, width)));
    }
  }
}
