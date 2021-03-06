/*
Classe permettant de faire la connection entre la carte arduino et le logiciel.
 Connection sur le deuxieme port disponible (example: port dispo : CM1 et CM4, L'arduino doit être branché sur CM4)
 
 */

import processing.serial.*; 

private Serial arduinoPort; //port usb de connection entre l'ordinateur et la carte
public final int EN_COUR_DE_CONNECTION = 0, EST_CONNECTE = 1, EST_PAS_CONNECTE = 2;
private int etatConnection;
private String[][] m = null; // valeur des input de l'arduino

void connection() { //etablie la connection arduino - logiciel
  int i = 0; //numero du port
  int connection = EN_COUR_DE_CONNECTION;
  while (connection == EN_COUR_DE_CONNECTION) {
    try {
      arduinoPort = new Serial(this, Serial.list()[i], 9600); // établie la connection
      delay(1000);
      if (getInput() != null) {
        connection = EST_CONNECTE;
      }
    }
    catch (Exception e) {
      connection = EST_PAS_CONNECTE;
    }
    i++;
  }
  etatConnection = connection;
}

public int getConnection() {
  return etatConnection;
}

private String getInput() { //recuperer 5 infos de l'arduino (pot/b1/b2/b3/b4)
  String s = null;
  while (arduinoPort.available() > 0) {
    s = arduinoPort.readStringUntil('\n');
  }
  return s;
}

private void getInfoArduino() { //recupere les info de l'arduino et les separe les info dans un tableau
  String s = getInput();
  if (s != null) {
    m = matchAll(s, "[0-9]+");
    //println(m[1][0]);
  }
  //return m;
}

//retourne la valeur en % du potentiometre
int getPot() {
  int val = -1;
  if (m != null) {
    val = Integer.parseInt(m[0][0]);
  }  
  return val;
}

//retourne vrais si le bouton 1 est appuye sinon faux
Boolean boutonJauneAppuye() {
  Boolean val = false;
  //String[][] m = getMatch();

  if (m != null) {
    if (m[1][0].equals("0")) {
      val = true;
    }
  }
  return val;
}

//retourne vrais si le bouton 2 est appuye sinon faux
Boolean boutonVertAppuye() {
  Boolean val = false;
  //String[][] m = getMatch();
  if (m != null) {
    if (m[2][0].equals("0")) {
      val = true;
    }
  }
  return val;
}

//retourne vrais si le bouton 3 est appuye sinon faux
Boolean boutonRougeAppuye() {
  Boolean val = false;
  //String[][] m = getMatch();
  if (m != null) {
    if (m[3][0].equals("0")) {
      val = true;
    }
  }
  return val;
}

//retourne vrais si le bouton 4 est appuye sinon faux
Boolean boutonBleuAppuye() {
  Boolean val = false;
  //String[][] m = getMatch();
  if (m != null) {
    if (m[4][0].equals("0")) {
      val = true;
    }
  }
  return val;
}
