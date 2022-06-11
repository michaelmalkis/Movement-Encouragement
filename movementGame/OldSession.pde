
class OldSessions implements ActionOnPress {
  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<Child> children = new ArrayList<Child>();
  AddChild addChildBtn;
  boolean showMenu = false;
  boolean drawPopUp = false;
 

  OldSessions() {
    screen = Screens.OLD_SESSIONS;
    addChildBtn = new AddChild();
    buttons.add(new ImgButton(#2aa3d5, #70c1e3, #b7487b,2*min(width/10, height/10),0, 0, new BackToSessionMenuFromOldSession(), "back"));
    buttons.add(new ImgButton(#70c1e3, #2aa3d5, #b7487b, width/6, width*9/12, height*1/26, addChildBtn, "Add Child"));
    try {
      children = readChildren();
      createBtnsFromChildren();
    }
    catch(Exception e) {
    }
  }


  void actionOnMousePressed() {
    sessionMenu.close();
    oldSessions.open();
  }


  void addChild(String name) {
    oldSessions.drawPopUp = false;
    Child child = new Child(name);
    children.add(child);
    int row = (children.size()-1)/3;
    int col = (children.size()-1)%3;
    int x = width/8 + width*col/8 + (col*width)/12;
    int y = height/6 + height*row/6 + (row*height)/12;
    buttons.add(new RectButton(#70c1e3, #5eebcc, #b7287b, width/8,x, y, new OpenChildSessions(children.size()-1), name));
    try {
      saveChildren(children);
    }
    catch(Exception e) {
    }
  }


  void createBtnsFromChildren() {
    int row, col, x, y;
    for (int i = 0; i<children.size(); i++) {
        row = i / 3;
        col = i % 3;
        x = width/8 + width*col/8 + (col*width)/12;
        y = height/6 + height*row/6 + (row*height)/12;
        buttons.add(new RectButton(#70c1e3, #5eebcc, #b7287b, width/8,x, y, new OpenChildSessions(i), children.get(i).name));
      }
  }


  void display() {
    if (!showMenu) {
      return;
    }
    PImage  p = loadImage("images\\backGround4.jpg");
    p.resize(1280, 720);
    background(p);
    p = loadImage("images\\children_word.png");
    image(p, width*4/14 , height/280 - 20, 380, 170);
    for (Button b : buttons) {
      b.drawBtn();
    }
    if (drawPopUp) {
      addChildBtn.showName();
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
    screen = Screens.OLD_SESSIONS;
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
