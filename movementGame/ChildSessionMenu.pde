
int CREATE_NEW_SESSION = 1;
int ADD_FROM_LIBRARY = 2;


class ChildSessionMenu {

  Button buttons[] = new Button[3];
  ArrayList<Button> sessions = new ArrayList<Button>();
  int childIdx;
  boolean showMenu = false;


  ChildSessionMenu() {
    buttons[BACK] = new ImgButton(#2aa3d5, #70c1e3, #b7487b, min(width/10, height/10), 0, 0, new BackToOldSessionsFromChildSessionMenu(), "back");
    buttons[CREATE_NEW_SESSION] = new CircleButton(#c8ade3, #8141be, #b7287b, width/9, width*15/20 + 15, height*3/20, new CreateSessionBtn(), " Create\nSession", min(height/25, width/25));
    buttons[ADD_FROM_LIBRARY] = new CircleButton(#c8ade3, #8141be, #b7287b, width/9, width*18/20 + 10, height*3/20, new AddFromLibrary(), "Add From\n Library", min(height/25, width/25));
  }


  void setChild(int idx) {
    childIdx = idx;
    createChildSessionsBtns();
  }


  /**
  * Gets the current chield sessions and show them on screen.
  */
  void createChildSessionsBtns() {
    Child child = oldSessions.children.get(childIdx);
    for (int i=0; i<child.sessions.size(); i++) {
      String s = "Session "+String.valueOf(i);
      int  row = i / 3;
      int col = i % 3;
      int x = width/8 + width*col/8 + (col*width)/12;
      int y = height/6 + height*row/6 + (row*height)/12;
      sessions.add(new RectButton(#70c1e3, #5eebcc, #b7287b, width/8, x, y, new OpenOnSessionPressed(i), s));
    }
    utils.printChildren(oldSessions.children);
  }

  
  /**
  * Prints the name of the child on screen.
  */
  void showChildsName() {
    Child child = oldSessions.children.get(childIdx);
    fill(0);
    textSize(50);
    text(child.name, width*5/14, height*2/20);
  }


  void display() {
    if (!showMenu) {
      return;
    }
    PImage  p = loadImage("images\\backGround4.jpg");
    p.resize(1280, 720);
    background(p);
    for (Button b : buttons) {
      b.drawBtn();
    }
    for (Button b : sessions) {
      b.drawBtn();
    }
    showChildsName();
  }


  void onPressed() {
    if (!showMenu) {
      return;
    }
    for (Button b : buttons) {
      b.btnMousePressed();
    }
    for (Button b : sessions) {
      b.btnMousePressed();
    }
  }

  /**
  * Shows the screen layout. 
  */
  void open() {
    showMenu = true;
    lastScreen = screen;
    screen = Screens.CHILD_SESSION_MENU;
    library.addFromLibrary = false;
    createChildSessionsBtns();
    for (Button b : buttons) {
      b.showBtn();
    }
    for (Button b : sessions) {
      b.showBtn();
    }
  }


  /**
  * Unshows the screen layout.
  */
  void close() {
    showMenu = false;
    for (Button b : buttons) {
      b.unShowBtn();
    }
    for (Button b : sessions) {
      b.unShowBtn();
    }
    sessions = new ArrayList<Button>();
  }
}
