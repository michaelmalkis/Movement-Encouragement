
import java.util.ArrayList;


class CreateSession {
  Ball balls[][] = new Ball[NUM_OF_CHAMSHAS][utils.numOfBalls];
  ArrayList<Integer> session = new ArrayList<Integer>();
  Button ballsBtns[] = new Button[7];
  Child child;
  int chamshaHeight = 120;
  int newchamshaWidth = 700;
  int newchamshaHeight = 400;
  int newchamshaStartX = 20;
  int newchamshaStartY = 120;
  int curBallIdx = 0;
  int numOfLines = 4;
  boolean show = false;
  boolean first = true;


  CreateSession() {
    int posWidth = width/5;
    int ballSize = 40;
    int ballsHeight = height*2 / 16;
    ballsBtns[0] = new CircleButton(utils.ballsColors.get(0), utils.hoverBallsColors.get(0), #b7487b, ballSize, posWidth, ballsHeight, new AddNote(0), "", 0);
    ballsBtns[1] = new CircleButton(utils.ballsColors.get(1), utils.hoverBallsColors.get(1), #b7487b, ballSize, posWidth*2, ballsHeight, new AddNote(1), "", 0);
    ballsBtns[2] = new CircleButton(utils.ballsColors.get(2), utils.hoverBallsColors.get(2), #b7487b, ballSize, posWidth*3, ballsHeight, new AddNote(2), "", 0);
    ballsBtns[3] = new CircleButton(utils.ballsColors.get(3), utils.hoverBallsColors.get(3), #b7487b, ballSize, posWidth*4, ballsHeight, new AddNote(3), "", 0);
    ballsBtns[4] = new ImgButton(#b7488b, #8141be, #b7487b,min(width/6, height/6), width*27/32, height*8/14, new SaveSession(), "SAVE");
    ballsBtns[5] = new ImgButton(#b7488b, #8141be, #b7487b,min(width/6, height/6), width*27/32, height*5/14, new PlaySession(session, CREATE_SESSION_SCREEN), "play");
    ballsBtns[6] = new ImgButton(#b7488b, #8141be, #b7487b, 2*min(width/10, height/10),0,0, new BackFromCreateSession(), "back");
    ArrayList<Integer> randomSession = utils.createRandomSession(utils.numOfBalls);
    for (int i = 0; i < NUM_OF_CHAMSHAS; i++) {
      utils.createAllBalls(balls[i], utils.chamshaWidth, chamshaHeight, utils.numOfBalls, utils.chamshaStartX, (height/23)*(6*i+5), ballSize/2, randomSession, 0);
    }
  }


  void open() {
    lastScreen = screen;
    screen = Screens.CREATE_SESSION;
    if (!first) {
      initFields();
    }
    show = true;
    for (Button b : ballsBtns) {
      b.showBtn();
    }
    drawAllChamshas();
  }


  void initFields() {
    curBallIdx = 0;
    session.clear();
  }


  void drawAllChamshas() {
    background(#fadeed);
    PImage  p = loadImage("images\\backGround4.jpg");
    p.resize(1280, 720);
    background(p);
    for (int i = 0; i < NUM_OF_CHAMSHAS; i++) {
      utils.drawChamsha(utils.chamshaStartX, (height/14)*(3*i+3)+i*10, utils.chamshaWidth, chamshaHeight, numOfLines);
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
    checkClearVisualBoard();
    int chamshaNum = (idx / utils.numOfBalls) % NUM_OF_CHAMSHAS;
    int heightsGaps = chamshaHeight / utils.ballsColors.size();
    Ball b = balls[chamshaNum][idx % utils.numOfBalls];
    int colorNum = session.get(idx);
    b.changeColor(utils.ballsColors.get(colorNum), idx, (height/14)*(3*chamshaNum+3) + chamshaNum*10+ heightsGaps * colorNum);
    b.display(utils.ballsColors.get(colorNum));
  }


  void checkClearVisualBoard() {
    if ((session.size()-1) % (NUM_OF_CHAMSHAS * utils.numOfBalls) == 0) {
      drawAllChamshas();
    }
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
