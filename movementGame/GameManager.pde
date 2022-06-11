
import java.util.Map;
import java.util.Random;
import processing.sound.*;

class GameManager {
  SoundFile audioSounds[] = new SoundFile[utils.NUM_OF_SONARS];
  Ball ballsArr[] = new Ball[utils.numOfBalls];
  Button backToMenuBtn = new ImgButton(#2aa3d5, #70c1e3, #b7487b, 2*min(width/10, height/10), 0, 0, new BackToMenu(), "back");
  ArrayList<Integer> session;
  int timer = millis();
  int ballRadius = 55;
  int curBallIdx = 0;
  boolean showGame = false;
  boolean rightBall = false;
  boolean gameStarted = false;


  GameManager(boolean b) {
    if (b) {
      initSounds();
    }
  }


  void onPressed() {
    backToMenuBtn.btnMousePressed();
  }


  void setAudioSounds(SoundFile[] sounds) {
    audioSounds = sounds;
  }


  void setSession(ArrayList<Integer> s) {
    session = s;
  }


  void drawGame() {
    if (!showGame) {
      return;
    }
    PImage p = loadImage("images\\backGround3.jpg");    
    p.resize(1280, 720);
    background(p);
    backToMenuBtn.drawBtn();
    utils.drawChamsha(utils.chamshaStartX, utils.chamshaStartY, utils.chamshaWidth, utils.chamshaHeight, utils.numOfLines);
    utils.createAllBalls(ballsArr, utils.chamshaWidth, utils.chamshaHeight, utils.numOfBalls, utils.chamshaStartX, utils.chamshaStartY, ballRadius, session, 0);
  }


  void displayGame(float distance) {
    if (!showGame) {
      return;
    }
    backToMenuBtn.drawBtn();
    if (gameStarted) {
      ballsArr[curBallIdx % utils.numOfBalls].explode(distance);
    if (curBallIdx % utils.numOfBalls > 0 && curBallIdx % utils.numOfBalls<utils.numOfBalls) {
        for (int i=0; i<curBallIdx % utils.numOfBalls; i++) {
          ballsArr[i % utils.numOfBalls].shadesCheck();
        }
      }
    }
  }


  void initSounds() {
    audioSounds[0] = new SoundFile(final_project.this, "sounds\\1.wav");
    audioSounds[1] = new SoundFile(final_project.this, "sounds\\2.wav");
    audioSounds[2] = new SoundFile(final_project.this, "sounds\\3.wav");
    audioSounds[3] = new SoundFile(final_project.this, "sounds\\4.wav");
  }


  void closeGame() {
    showGame = false;
  }

  void openGame() {
    gameStarted = true;
    newGameSession();
    backToMenuBtn.showBtn();
  }


  void newGameSession() {
    showGame = true;
    drawGame();
    curBallIdx = 0;
    utils.displayAllBalls(ballsArr, session, curBallIdx, utils.chamshaHeight);
  }


  void successBall() {
    if (curBallIdx >=session.size()) {
      winning();
      black = new ArrayList<cords>();
      return;
    }
    ballsArr[curBallIdx % utils.numOfBalls].onPressed();
    audioSounds[ballsArr[curBallIdx % utils.numOfBalls].getNumOfColor()].play();
    curBallIdx++;
    if (curBallIdx >= session.size()) {
      winning();
      return;
    }
    if ((curBallIdx) % utils.numOfBalls == 0 ) {
      black = new ArrayList<cords>();
      ballsArr[curBallIdx % utils.numOfBalls].onPressed();
      PImage  p = loadImage("images\\backGround3.jpg");
      p.resize(1280, 720);
      background(p);
      backToMenuBtn.drawBtn();
      utils.drawChamsha(utils.chamshaStartX, utils.chamshaStartY, utils.chamshaWidth, utils.chamshaHeight, utils.numOfLines);
      utils.displayAllBalls(ballsArr, session, curBallIdx, utils.chamshaHeight);
      rightBall = false;
      return;
    }
    distanceFromSonar = -1;
  }


  void winning() {
    gameStarted = false;
    PImage  p = loadImage("images\\win.png");    
    image(p, width*3/16  , height*1/5, 760, 340);
  }


  void checkBall(int ballNum, int distance) {
    if (ballNum == ballsArr[curBallIdx % utils.numOfBalls].getNumOfColor()) {
      rightBall = true;
      if (distance < 5 && distance >= 0) {
        successBall();
        distanceFromSonar = -1;
      }
    } else {
      rightBall = false;
      if (numOfSonar !=  ballsArr[curBallIdx % utils.numOfBalls].getNumOfColor()) {
        distanceFromSonar = -1;
      }
    }
  }
}
