import menuThreePoint.*;
Animation anim;
MenuThreePoint mtp;
Donnee donnee = new Donnee();
Menu menuDemarrage;
Menu menuDessin;
Menu menuCouleurUn;
Menu menuCouleurDeux;
Menu menuCouleurTrois;
Menu menuCouleurChoix;
Menu menuResume;
Menu menuForme;
Menu menuSauv ;
Menu menuChargement;
public class Animation {
  private int i;
  private ArrayList<int[]> triangles;

  public Animation() {
    i=0;
    triangles=new ArrayList();
    String[] lines = loadStrings("Triangle.txt");
    for (int c=0; c<lines.length; c++) {
      String[] line=lines[c].split("/");
      if (line.length!=1) {
        int[] triangle=new int[6];
        for (int c2=0; c2<6; c2++) {
          triangle[c2]=int(line[c2]);
        }
        triangles.add(triangle);
      }
    }
  }

  public void dessine() {
    triangle2(triangles.get(i));
    i++;
  }

  public boolean isEnd() {
    return triangles.size()<=i;
  }
}

public void triangle2(int[] triangle) {
  triangle(triangle[0]/9600f*800, triangle[1]/5400f*800, triangle[2]/9600f*800, triangle[3]/5400f*800, triangle[4]/9600f*800, triangle[5]/5400f*800);
}

void setup() {
  background(255, 255, 255);
  StringList instructions = getInstructionPourConnectionAuto();

  initArduino();
  for (int i=0; i<instructions.size(); i++) {
    println(instructions.get(i));
  }
  save=new Save();
  pinceau = new Pinceau();


  Settings reglageLightThemeWithTitle = new Settings(Settings.LIGHTTHEMEWITHTITLE);
  Settings reglageLightTheme = new Settings(Settings.LIGHTTHEME);

  menuDemarrage = new Menu(reglageLightTheme);
  menuDessin = new Menu(reglageLightTheme);
  menuCouleurUn = new Menu(reglageLightTheme);
  menuCouleurDeux = new Menu(reglageLightTheme);
  menuCouleurTrois = new Menu(reglageLightTheme);
  menuCouleurChoix = new Menu(reglageLightTheme);
  menuResume = new Menu(reglageLightTheme);
  menuForme = new Menu(reglageLightTheme);
  menuSauv = new Menu(reglageLightThemeWithTitle);
  menuChargement = new Menu(reglageLightTheme);
  int[] size = new int[2];
  size[0] = 500;
  size[1] = 1200;
  mtp = new MenuThreePoint(size);
  PApplet.runSketch(platformNames, mtp);

//menuDemarrage
  menuDemarrage.addButton("start->", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuDessin);
    }
  }
  );
  menuDemarrage.addButton("quitter", new ButtonListener() {
    public void buttonListener() {
      exit();
    }
  }
  );
  menuDemarrage.addButton("sauver", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuSauv);
    }
  }
  );
  menuDemarrage.addButton("<-charger", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuChargement);
    }
  }
  );

  //menuDessin
  menuDessin.addButton("couleur->", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuCouleurChoix);
    }
  }
  );
  menuDessin.addButton("forme", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuForme);
    }
  }
  );
  menuDessin.addButton("<-menu", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuDemarrage);
    }
  }
  );

  //menuCouleurUn
  for (int i = 0; i<256; i++) {
    final int j = i;
    menuCouleurUn.addButton(i+"", new ButtonListener() {
      public void buttonListener() {
        donnee.setRouge(j);
      }
    }
    );
  }
  menuCouleurUn.addButton("<-couleur", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuCouleurChoix);
    }
  }
  );
  menuCouleurUn.addButton("vert->", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuCouleurDeux);
    }
  }
  );


  //menuCouleurDeux
  for (int i = 0; i<256; i++) {
    final int j = i;
    menuCouleurDeux.addButton(i+"", new ButtonListener() {
      public void buttonListener() {
        donnee.setVert(j);
      }
    }
    );
  }
  menuCouleurDeux.addButton("<-rouge", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuCouleurUn);
    }
  }
  );
  menuCouleurDeux.addButton("bleu->", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuCouleurTrois);
    }
  }
  );


  //menuCouleurTrois
  for (int i = 0; i<256; i++) {
    final int j = i;
    menuCouleurTrois.addButton(i+"", new ButtonListener() {
      public void buttonListener() {
        donnee.setBleu(j);
      }
    }
    );
  }
  menuCouleurTrois.addButton("<-bleu", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuCouleurDeux);
    }
  }
  );
  menuCouleurTrois.addButton("forme->", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuForme);
    }
  }
  );

  //menuCouleurChoix
  menuCouleurChoix.addButton("noir", new ButtonListener() {
    public void buttonListener() {
      donnee.setRouge(0);
      donnee.setVert(0);
      donnee.setBleu(0);
    }
  }
  );
  menuCouleurChoix.addButton("bleu", new ButtonListener() {
    public void buttonListener() {
      donnee.setRouge(255);
      donnee.setVert(255);
      donnee.setBleu(255);
    }
  }
  );
  menuCouleurChoix.addButton("rouge", new ButtonListener() {
    public void buttonListener() {
      donnee.setRouge(255);
      donnee.setVert(0);
      donnee.setBleu(0);
    }
  }
  );
  menuCouleurChoix.addButton("vert", new ButtonListener() {
    public void buttonListener() {
      donnee.setRouge(0);
      donnee.setVert(255);
      donnee.setBleu(0);
    }
  }
  );

  menuCouleurChoix.addButton("R", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuCouleurUn);
    }
  }
  );

  menuCouleurChoix.addButton("G", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuCouleurDeux);
    }
  }
  );


  menuCouleurChoix.addButton("<-B", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuCouleurTrois);
    }
  }
  );

  menuCouleurChoix.addButton("forme->", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuForme);
    }
  }
  );


  //menuResume
  menuResume.addButton("couleurActu", null);
  menuResume.addButton("forme", null);
  menuResume.addButton("<-menu", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuDemarrage);
    }
  }
  );

  menuResume.addButton("<-forme", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuForme);
    }
  }
  );

  menuResume.addButton("sauver->", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuSauv);
    }
  }
  );

  //menuForme
  ArrayList<String> listeForme = creeListeDeForme();

  for (int i = 0; i < listeForme.size(); i++) {
    final int j = i;
    menuForme.addButton(listeForme.get(i),new ButtonListener() {
    public void buttonListener() {
            stroke(donnee.getCouleur());
            fill(donnee.getCouleur());
            dessineForme(j, new Couleur(donnee.getCouleur()));    }
  }
  );
  }
  menuForme.addButton("<-B", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuCouleurTrois);
    }
  }
  );

  //menuSauv
  menuSauv.addTitle(donnee.nomJoueur);
  for (int i = 65; i < 91; i++) {
    final int j = i;
    menuSauv.addButton(char(i) + "", new ButtonListener() {
    public void buttonListener() {
      donnee.setNomJoueur(donnee.getNomJoueur()+char(j));
      menuSauv.addTitle(donnee.getNomJoueur());
    }
  }
  );
  }
  menuSauv.addButton("charger->", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuChargement);
    }
  }
  );

  menuSauv.addButton("<-resume", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuResume);
    }
  }
  );
  menuSauv.addButton("SAUVER", new ButtonListener() {
    public void buttonListener() {
      save.save(donnee.nomJoueur);
    }
  }
  );

  //menuChargement
  String cheminFichier = getCheminDossier("saves");
  java.io.File dossierSaves = new java.io.File(dataPath(cheminFichier));
  String[] listeNomFichier= dossierSaves.list();
    menuChargement.addButton("retour", new ButtonListener() {
    public void buttonListener() {
      mtp.setMenuCurrent(menuDemarrage);
    }
  }
  );
  if ( listeNomFichier.length > 0) {
    for (int i = 0; i < listeNomFichier.length; i++) {
      final String cour = listeNomFichier[i];
      menuChargement.addButton(listeNomFichier[i],new ButtonListener() {
    public void buttonListener() {
      save.load(cour);
    }
  }
  );
    }
  }

    mtp.setMenuCurrent(menuDemarrage);


  noFill();
  strokeWeight(2);
  anim=new Animation();
  frameRate(30);

}

public void settings() {
  size(800, 800);
  hmin=lmax=0;
  hmax=lmax=800;
}



int cooldownButton = 30;

boolean appuyeBoutonJaune = false;
boolean appuyeBoutonVert = false;
color c = color(255, 255, 255); //couleur background


boolean firstConnection = false;

void draw() {

  if (getConnection()) {
    if (!firstConnection) {
      firstConnection = true;
      background(c);
    }
    getInfoArduino();  
    prendreScreenshot();
    if (save.getAfficheSave()) {
      afficheForme();
      save.setAfficheSave(false);
    }
    effaceDessin();
  } else {
    if (anim==null || anim.isEnd()) {
      anim=null;
      connection();
    } else anim.dessine();
  }
  // dessineTest(getValModifPot());
  gestionControleur();
}

private void afficheForme() {
  ArrayList<Historique> historiques = save.getHistorique();
  if (historiques.size()>0) {
    ArrayList<String> lines=new ArrayList();
    for (int i=0; i<historiques.size(); i++) {
      Historique historique=historiques.get(i);
      lines.add(historique.getId()+"/");
      ArrayList arg=historique.getArg();
      for (int j=0; j<arg.size(); j++) {
        lines.set(i, lines.get(i)+arg.get(j));
        if (j!=arg.size()-1)lines.set(i, lines.get(i)+"/");
      }
    }
    for (int i=0; i<lines.size(); i++) {
      String[] line=lines.get(i).split("/");
      pinceau.setCouleur(new Couleur(int(line[1])), new Couleur(int(line[2])));
      save.dessineFormeParId(line);
    }
  }
}

//prends un screenshot de la fenetre principal
private void prendreScreenshot() { 
  if (!boutonJauneAppuye()) {
    appuyeBoutonJaune = false;
  }
  if (boutonJauneAppuye() && appuyeBoutonJaune == false) { //quand on appuie sur le bouton jaune
    save("screenshot/screenshot-"+str(hour())+"."+str(minute())+"."+str(second())+".png");
    appuyeBoutonJaune = true;
  }
}

//efface tout les dessins de la fenetre dessin
private void effaceDessin() { 
  if (!boutonVertAppuye()) {
    appuyeBoutonVert = false;
  }
  if (boutonVertAppuye() && appuyeBoutonVert == false) { //quand on appuie sur le bouton jaune
    save.supprimeHistorique();
    background(c);
    appuyeBoutonVert = true;
  }
}

/* JOYSTICK VERSION */


boolean appuyeBoutonBleu = false;
boolean appuyeBoutonRouge = false;
private void gestionControleur() {
  if (!boutonBleuAppuye()) {
    appuyeBoutonBleu = false;
  }
  if (!boutonRougeAppuye()) {
    appuyeBoutonRouge = false;
  }
  if (boutonRougeAppuye() && appuyeBoutonRouge == false) { //quand on appuie sur le bouton bleu
    appuyeBoutonRouge = true;
  }
  if (boutonBleuAppuye() && (appuyeBoutonBleu == false )) { //quand on appuie sur le bouton bleu
    mtp.getMenuCurrent().click();
    appuyeBoutonBleu = true;
  }
  gestionJoystick();
}



private int indexY = 0;
private void gestionJoystick() {
  int jy = getJoystickY();
  /*if (jy < 5 && jy > -5){
   indexY = 0;
   }
   
   if (jy <= 25 && jy > 0){
   indexY ++;
   }
   if (jy < 45 && jy > 26){
   indexY += 2;
   }
   if(jy >= 45){
   indexY += 6;
   }
   
   if (jy <= -25 && jy < 0){
   indexY --;
   }
   if (jy < -45 && jy < -26){
   indexY -= 2;
   }
   if(jy <= -45){
   indexY -= 6;
   }*/


  int time = 250;
  if (jy >= 40) {
    mtp.getMenuCurrent().downCursor();
    delay(time);
    //indexY = 25;
  }
  if (jy <= -40) {
    mtp.getMenuCurrent().upCursor();
    delay(time);
    //indexY = -25;
  }

}
