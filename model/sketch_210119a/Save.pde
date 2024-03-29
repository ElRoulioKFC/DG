class Save {
  private ArrayList<Historique> historiques;

  public Save() {
    historiques=new ArrayList();
  }

  public void addHistorique(Historique historique) {
    historique.addCouleur();
    historiques.add(historique);
  }

  public void save(String nom) {
    String[] lines=new String[historiques.size()];
    for (int i=0; i<historiques.size(); i++) {
      Historique historique=historiques.get(i);
      lines[i]=historique.getId()+"/";
      ArrayList arg=historique.getArg();
      for (int j=0; j<arg.size(); j++) {
        lines[i]+=arg.get(j);
        if (j!=arg.size()-1)lines[i]+="/";
      }
    }
    saveStrings("saves/"+nom+".save", lines);
  }

  public void load(String nom) {
    //String[] lines = loadStrings("saves/"+nom);
    String[] lines = loadStrings(getCheminFichier("saves", nom));
    for (int i=0; i<lines.length; i++) {
      String[] line=lines[i].split("/");
      pinceau.setCouleur(new Couleur(int(line[1])),new Couleur(int(line[2])));
      dessineFormeParId(line);
    }
  }
  
    /*
  * retourne le chemin du fichier du dossier se trouvant dans le dossier sketch (en s'adaptant en fonction de l'OS)
  * dossier : dossier cible
  * fichier : fichier rechercher
  * retourne un String du chemin associé 
  */
  private String getCheminFichier(String dossier, String fichier){
    String chemin = "";
    String cheminSketch = sketchPath();
    char separateur = '0';
    char sepMacos = '/';
    char sepWindows = '\\';
    for (int i = 0; i < cheminSketch.length(); i++){
      char sep = cheminSketch.charAt(i);
      if (sep == sepMacos){
        separateur = sepMacos;
      }
      if (sep == sepWindows){
        separateur = sepWindows;
      }
    }
    if (separateur != '0'){
      chemin = dossier + separateur + fichier;
    }
    else{
      chemin = "erreur, dossier \"" + dossier + "\" ou fichier \"" + fichier + "\" introuvable";
    }
    return chemin;
  }

  
  public void dessineFormeParId(String [] line){
  switch(line[0]) {
    case "0":
      dessineCarre(float(line[3]),float(line[4]),float(line[5]));
      break;
    case "1":
      dessineRectangle(float(line[3]),float(line[4]),float(line[5]),float(line[6]));
      break;
    case "2":
      dessineTriangle(float(line[3]),float(line[4]),float(line[5]),float(line[6]),float(line[7]),float(line[8]));
      break;
    case "3":
      dessineEllipse(float(line[3]),float(line[4]),float(line[5]),float(line[6]));
      break;
    case "4":
      dessineCercle(float(line[3]),float(line[4]),float(line[5]));
      break;
    case "5":
      dessinePoly(float(line[3]),float(line[4]),float(line[5]),float(line[6]),int(line[7]));
      break;
    case "6":
      fractalKock(float(line[3]),float(line[4]),float(line[5]),float(line[6]),float(line[7]));
      break;  
    //case "7":
    //  polyParfait(float(line[3]),float(line[4]),float(line[5]),float(line[6]),float(line[7]),int(line[8]));
    //  break;
     case "8":
      spiralrOr(float(line[3]),float(line[4]));
      break;
     case "9":
      courbeBezier(loadCoord(line));
      break;
  }
}

  private float[][] loadCoord(String [] line) {
    float[][] coord=new float[int(line[3])][2];
    for (int i=0; i<int(line[3]); i++) {
      coord[i][0]=float(line[i*2+4]);
      coord[i][1]=float(line[i*2+5]);
    }
    return coord;
  }
}
