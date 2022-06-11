
class Library implements ActionOnPress {
  
  AddChildLibrary addChildBtn;
  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<ImgButton> imgs = new ArrayList<ImgButton>();
  ArrayList<Child> children = new ArrayList<Child>();
  int childIdx = 0;
  boolean showMenu = false;
  boolean drawPopUp = false;
  boolean addFromLibrary = false;


  Library() {
    lastScreen = screen;
    screen = Screens.LIBRARY;
    initAllBtns();
  }


  void initAllBtns() {
    buttons.clear();
    imgs.clear();
    addChildBtn = new AddChildLibrary();
    if (!addFromLibrary) {
      imgs.add(new ImgButton(#c8ade3, #8141be, #b7487b, 200, width*4/5, height*1/20, addChildBtn, "add in lib"));
    }
    imgs.add(new ImgButton(#2aa3d5, #70c1e3, #b7487b,2*min(width/10, height/10),0, 0, new BackToSessionMenuFromLibrary(), "back"));
    createSessionsBtnsInit();
  }


  void createSessionsBtnsInit() {
    try {
      children = readChildren();
      createBtnsFromChildren();
    }
    catch(Exception e) {
    }
  }


  void actionOnMousePressed() {
    sessionMenu.close();
    library.open();
  }


  void addChild(String name) {
    drawPopUp = false;
    Child child = new Child(name);
    children.add(child);    
    int row = (children.size()-1)/3;
    int col = (children.size()-1)%3;
    int x = width/8 + width*col/8 + (col*width)/12;
    int y = height/6 + height*row/6 + (row*height)/12;
    buttons.add(new RectButton(#70c1e3, #5eebcc, #b7287b, width/8,x, y, new CreateSessionBtnFromLibrary(children.size()-1), name));  
    try {
      saveChildren(children);
    }
    catch(Exception e) {
    }
  }


  void createBtnsFromChildren() {
    for (int i=0; i<children.size(); i++) {
      int row = i/3;
      int col = i%3;  
      int x = width/8 + width*col/8 + (col*width)/12;
      int y = height/6 + height*row/6 + (row*height)/12;
      buttons.add(new RectButton(#70c1e3, #5eebcc, #b7287b, width/8,x, y, new OpenOnSessionPressed(i), children.get(i).name));
    }
  }


  void display() {
    if (!showMenu) {
      return;
    }
    PImage  p = loadImage("images\\backGround4.jpg");
    p.resize(1280, 720);
    background(p);
    p = loadImage("images\\lib.png");
    image(p, width*4/14 , height/50 , 380, 100);
    for (Button b : buttons) {
      b.drawBtn();
    }
    for(ImgButton b:imgs){
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
    for (ImgButton b : imgs) {
      b.btnMousePressed();
    }
    for (Button b : buttons) {
      b.btnMousePressed();
    }
  }


  void open() {
    showMenu = true;
    lastScreen = screen;
    screen = Screens.LIBRARY;
    initAllBtns();
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
