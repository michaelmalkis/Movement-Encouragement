
int NUM_OF_CHAMSHAS = 3;

class OnSessionPressed implements ActionOnPress {
  
  Ball balls[][] = new Ball[NUM_OF_CHAMSHAS][utils.numOfBalls];
  Child child;
  ArrayList<Integer> session = new ArrayList<Integer>();
  ArrayList<Button> ballsBtns = new ArrayList<Button>();  
  int sessionIdx = 0;
  
  int curBallIdx = 0;
  int numOfLines = 4;
  int chamshaHeight = (360-120)/2;
  int newchamshaWidth = 700;
  int newchamshaHeight = 400;
  int newchamshaStartX =20;
  int newchamshaStartY = 120;
  boolean first = true;
  boolean show = false;

  
  void actionOnMousePressed() {
  
  }


  OnSessionPressed() {
    ArrayList<Integer> randomSession = utils.createRandomSession(utils.numOfBalls);
    for (int i = 0; i < NUM_OF_CHAMSHAS; i++) {
      utils.createAllBalls(balls[i], newchamshaWidth, chamshaHeight, utils.numOfBalls, utils.chamshaStartX, (height/14)*(3*i+3), 20, randomSession, 0);
    }
  }


  void createBtns() {
    int posWidth = width/5;
    int ballSize = 40;
    int ballsHeight = height*2 / 16;
    ActionOnPress backBtn =  new BackToChildsFromOnSession();
    ArrayList<Child> children = new ArrayList<Child> ();
    session = new ArrayList<Integer>();
    switch (lastScreen) {
    case LIBRARY:
      backBtn = new BackToLibraryFromOnSession();
      children = library.children;
      utils.printChildren(children);
      if (children.get(sessionIdx).sessions.size() == 0){
        children.get(sessionIdx).addSession(new ArrayList<Integer>());      
      }
      session = new ArrayList<Integer>(children.get(sessionIdx).sessions.get(0));
      utils.printChildren(children);
      break;
    case CHILD_SESSION_MENU:
      backBtn = new BackToChildsFromOnSession();
      children = oldSessions.children;
      session = new ArrayList<Integer>(children.get(childSessionMenu.childIdx).sessions.get(sessionIdx));
      break;
    default:
      backBtn = new BackToChildsFromOnSession();
      children = oldSessions.children;
      session = new ArrayList<Integer>(children.get(childSessionMenu.childIdx).sessions.get(sessionIdx));
      break;
    }
    utils.printChildren(children);
    if (!library.addFromLibrary) {
      ballsBtns.add(new ImgButton(utils.ballsColors.get(0), #8141be, #b7487b, height/5, width*20/24, height*10/20, new DeleteSession(), "Delete"));
      ballsBtns.add(new TriangleButton(utils.ballsColors.get(1), #8141be, #b7487b, height/5, width*21/24, height*4/20, new PlaySession(session, CHILD_SESSION_MENU_SCREEN), "Play",  min(height/30, width/30)));} else {
      ballsBtns.add(new ImgButton(utils.ballsColors.get(0), #8141be, #b7487b, 200 ,width*3/4 + width/30, height*1/3, new AddSession(), "add in lib"));
  }
    ballsBtns.add(new ImgButton(#2aa3d5, #70c1e3, #b7487b,2*min(width/10, height/10),0, 0, backBtn, "back"));
    ballsBtns.add(new ImgButton(#2aa3d5, #70c1e3, #b7487b,min(width/8, height/8), width*6/12, height*17/20, new Next(), "nextPage"));
    ballsBtns.add(new ImgButton(#2aa3d5, #70c1e3, #b7487b,min(width/8, height/8), width*5/12, height*17/20, new BackInSession(), "prevPage"));
  }

  
  void open() {
    lastScreen = screen;
    screen = Screens.ON_SESSION_PRESSED;
    if (!first) {
      initFields();
    }
    createBtns();
    show = true;
    for (Button b : ballsBtns) {
      b.showBtn();
    }
    drawAllChamshas();
    drawBalls();
  }


  void initFields() {
    curBallIdx = 0;
    session = new ArrayList<Integer>();
    ballsBtns = new ArrayList<Button>();
  }


  void drawAllChamshas() {
    background(#fadeed);
    PImage  p = loadImage("images\\backGround4.jpg");
    p.resize(1280, 720);
    background(p);
    for (int i = 0; i < NUM_OF_CHAMSHAS; i++) {
      utils.drawChamsha(utils.chamshaStartX, (height/23)*(6*i+5) - 40, newchamshaWidth, chamshaHeight, numOfLines);
    }
  }


  void display() {
    if (!show) {
      return;
    }
    for (Button b : ballsBtns) {
      b.drawBtn();
    }
  }


  void displayBall(int idx) {
    int chamshaNum = (idx / utils.numOfBalls) % NUM_OF_CHAMSHAS;
    int heightsGaps = chamshaHeight / utils.ballsColors.size();
    Ball b = balls[chamshaNum][idx % utils.numOfBalls];
    int colorNum = session.get(idx);
    b.changeColor(utils.ballsColors.get(colorNum), idx, (height/23)*(6*chamshaNum+5)+ heightsGaps * colorNum - 40);
    b.display(utils.ballsColors.get(colorNum));
  }


  void checkClearVisualBoard() {
    if ((curBallIdx-1) % (NUM_OF_CHAMSHAS * utils.numOfBalls) == 0  && (curBallIdx % (NUM_OF_CHAMSHAS * utils.numOfBalls + 1) != 0)) {
      drawAllChamshas();
    }
  }


  void drawBalls() {
    if (curBallIdx < session.size()) {
      drawAllChamshas();
    }
    for (int i=0; i< utils.numOfBalls*NUM_OF_CHAMSHAS; i++) {
      if (curBallIdx < session.size()) {
        displayBall(curBallIdx);
        curBallIdx++;
      }
    }
  }


  void backInSession() {
    int res = curBallIdx % (utils.numOfBalls*NUM_OF_CHAMSHAS);
    if (res > 0) {
      curBallIdx -= (utils.numOfBalls*NUM_OF_CHAMSHAS + res);
    } else {
      curBallIdx -= 2*utils.numOfBalls*NUM_OF_CHAMSHAS;
    }
    if (curBallIdx < 0) {
      curBallIdx = 0;
    }
    drawBalls();
  }


  void setChild(Child c) {
    child = c;
  }


  void close() {
    show = false;
    for (Button b : ballsBtns) {
      b.unShowBtn();
    }
    first = false;
  }


  void onPressed() {
    if (!show) {
      return;
    }
    for (Button b : ballsBtns) {
      b.btnMousePressed();
    }
  }
}
