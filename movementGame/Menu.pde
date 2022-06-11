
final boolean START = true;
final boolean DONT_START = false;


class Menu {
  Button buttons[] = new Button[3];
  boolean showMenu = false;


  Menu() {
    PImage p = loadImage("images\\backGround3.jpg");
    p.resize(1280, 720);
    background(p);
    buttons[0] = new ImgButton(#c8ade3, #8141be, #b7487b, min(height/3, width/3), width*6/12, height/3, new RandomGame(), "play");
    buttons[1] = new RectButton(#70c1e3, #5eebcc, #b7487b, min(height/4, width/4), width*4/14, height/4, new ChooseSound(), "  Choose\n  Sound");
    buttons[2] = new RectButton(#70c1e3, #5eebcc, #b7487b, min(height/4,width/4), width*4/14, height*2/4, new OpenSessionMenu(), "  Open\n Sessions");
  }


  void displayMenu() {
    if (!showMenu) {
      return;
    }
    PImage  p = loadImage("images\\backGround3.jpg");
    p.resize(1280, 720);
    background(p);
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


  void openMenu() {
    showMenu = true;
    lastScreen = screen;
    screen = Screens.MENU;
    for (Button b : buttons) {
      b.showBtn();
    }
  }


  void closeMenu() {
    showMenu = false;

    for (Button b : buttons) {
      b.unShowBtn();
    }
  }
}
