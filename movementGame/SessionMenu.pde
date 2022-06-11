
int OPEN_OLD_SESSION = 1;
int BACK = 0;
int NUM_OF_CHILDREN = 20;
int NUM_OF_SESSIONS_SUPPRTED = 10;
int LIBRARY_BTN = 2;
int BACK_SYMBOL = 3;


class SessionMenu {

  ArrayList<Button> sessions = new ArrayList<Button>();
  Button buttons[] = new Button[3];
  int check = (int)sqrt((height- min(width/10, height/10)) *(width /2));
  boolean showMenu = false;
  
  
  SessionMenu() {
    buttons[OPEN_OLD_SESSION] = new ImgButton(#c8ade3, #8141be, #b7487b,min(height/2, width/2), width/7, height/3, new OldSessions(), "Children");
    buttons[LIBRARY_BTN] = new ImgButton(#70c1e3, #2a22d5, #b7287b, min(height/2, width/2), width*4/7, height/4, new OpenLibrary(), "Library");
    buttons[BACK] = new ImgButton(#2aa3d5, #70c1e3, #b7487b, 2*min(width/10, height/10), 0, 0, new BackToMenuFromSessionMenu(), "back");
  }


  void display() {
    if (!showMenu) {
      return;
    }
    PImage p = loadImage("images\\backGround4.jpg");
    p.resize(1280, 720);
    background(p);
    p = loadImage("images\\lib.png");
    image(p, width/2 + 10, height/14, 400, 80);  
    p = loadImage("images\\children_word.png");
    image(p, width/6 - 20, height/100, 380, 170);  
    for (Button b : buttons) {
      b.drawBtn();
    }
  }


  void onPressed() {
    if (!showMenu) {
      return;
    }
    for (Button b : buttons) {
      b.btnMousePressed();
    }
  }


  void open() {
    showMenu = true;
    lastScreen = screen;
    screen = Screens.SESSION_MENU;
    for (Button b : buttons) {
      b.showBtn();
    }
  }


  void close() {
    showMenu = false;
    for (Button b : buttons) {
      b.unShowBtn();
    }
  }
}
