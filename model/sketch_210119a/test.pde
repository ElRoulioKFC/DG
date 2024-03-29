PImage img;

void setup() {
  background(255, 255, 255);
  StringList instructions = getInstructionPourConnectionAuto();
  
  initArduino();
  for (int i=0; i<instructions.size(); i++){
    println(instructions.get(i));
  }
  save=new Save();
  pinceau = new Pinceau();
  PApplet.runSketch(platformNames, new SecondApplet());
    img = loadImage("opening_frame.png");

}

public void settings() {
  size(800, 800);
  
}

int delaiBoutonJaune = 0;
color c = color(255, 255, 255); //couleur background

boolean image_affiche = false;

void draw() {
  if (getConnection()){
    if (image_affiche){ //background(c);
  }
    getInfoArduino();  
    prendreScreenshot();
  }
  else{
    //image(img, 0, 0, width, height);
    image_affiche = true;
    connection();
    delay(2000);
  }
  // dessineTest(getValModifPot());
}

//prends un screenshot de la fenetre principal
private void prendreScreenshot(){ 
  if (delaiBoutonJaune > 0) {
      delaiBoutonJaune--;
  }
  if (boutonJauneAppuye() && delaiBoutonJaune == 0) { //quand on appuie sur le bouton jaune
    save("screenshot/screenshot-"+str(hour())+"."+str(minute())+"."+str(second())+".png");
    delaiBoutonJaune = 15;
  }
}

public class SecondApplet extends PApplet {
  MenuListe menu = new MenuListe(0,save);
  int dernierPot = getPot();
  int delaiBoutonBleu = 0;
  int delaiBoutonRouge = 0;


  public void settings() {
    size(400, 800);
  }

  public void setup() {
    surface.setTitle("Menu");
  }

  public void draw() {
    background(0, 0, 0);
    menu.actualise();
    if (delaiBoutonBleu > 0) {
      delaiBoutonBleu--;
    }
    if (delaiBoutonRouge > 0) {
      delaiBoutonRouge--;
    }
     if (boutonRougeAppuye() && delaiBoutonRouge == 0) { //quand on appuie sur le bouton bleu
      menu.cliqueBoutonRouge();
      delaiBoutonRouge = 15;
    }
    if (boutonBleuAppuye() && delaiBoutonBleu == 0) { //quand on appuie sur le bouton bleu
      menu.cliqueBoutonBleu();
      delaiBoutonBleu = 15;
    }
    if ( (dernierPot - 1 > getPot())) {
      menu.descendCurseur();
    } else if ( (dernierPot + 1 < getPot())) {
      menu.augmenteCurseur();
    }
    dernierPot = getPot();
   // background(0, 0, 0);
    textSize(32);
    text(menu.getCurseur(), 50, 50);
    text(menu.getMenuActuel(), 100, 50);
    if (menu.getMenuActuel() == 7){
      menu.menuSauvLettre();
    }
    for (int i = 0; i < menu.getListeBoutonTaille(); i++) {//dessine tous les boutons
      if (i == menu.getCurseur()) {
        menu.getListeBouton().get(i).active();
      } else {
        menu.getListeBouton().get(i).desactive();
      }
      noFill();
      if (menu.getListeBouton().get(i).getChoix()) {
        stroke(menu.getListeBouton().get(i).getCouleurOn().getCouleur());
      } else {
        stroke(menu.getListeBouton().get(i).getCouleurOff().getCouleur());
      }
      rect(menu.getListeBouton().get(i).getX(), menu.getListeBouton().get(i).getY(), menu.getListeBouton().get(i).getTailleX(), menu.getListeBouton().get(i).getTailleY());
      textSize(menu.getListeBouton().get(i).getTailleTexte());
      int  j = 0;
      int k = 1;
      for (int tailleI = 0; tailleI < menu.getListeBouton().get(i).getTabTexte().length; tailleI++) {//dessine le texte du bouton
        if (menu.getListeBouton().get(i).getChoix()) {
          fill(menu.getListeBouton().get(i).getCouleurOn().getCouleur());
        } else {
          fill(menu.getListeBouton().get(i).getCouleurOff().getCouleur());
        }       
        text(menu.getListeBouton().get(i).getTabTexte()[tailleI], menu.getListeBouton().get(i).getTabCoord()[j], menu.getListeBouton().get(i).getTabCoord()[k]);
        j = j+2;
        k = j+1;
      }
    };
  }
}
