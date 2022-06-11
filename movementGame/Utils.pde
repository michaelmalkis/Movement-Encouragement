
class Utils {

    SoundFile[] guitarSounds = {
    new SoundFile(final_project.this, "sounds\\guitar\\1.wav"),    
    new SoundFile(final_project.this, "sounds\\guitar\\2.wav"),
    new SoundFile(final_project.this, "sounds\\guitar\\3.wav"),
    new SoundFile(final_project.this, "sounds\\guitar\\4.wav")};

  SoundFile[] drumsSounds = {
    new SoundFile(final_project.this, "sounds\\drums\\d1.wav"),    
    new SoundFile(final_project.this, "sounds\\drums\\d2.wav"),
    new SoundFile(final_project.this, "sounds\\drums\\d3.wav"),
    new SoundFile(final_project.this, "sounds\\drums\\d4.wav")};

  SoundFile[] electronicSounds = {
    new SoundFile(final_project.this, "sounds\\electronic\\1.wav"),    
    new SoundFile(final_project.this, "sounds\\electronic\\2.wav"),
    new SoundFile(final_project.this, "sounds\\electronic\\3.wav"),
    new SoundFile(final_project.this, "sounds\\electronic\\4.wav")};
    
  SoundFile[] pianoSounds = {
    new SoundFile(final_project.this, "sounds\\piano\\1.wav"),    
    new SoundFile(final_project.this, "sounds\\piano\\2.wav"),
    new SoundFile(final_project.this, "sounds\\piano\\3.wav"),
    new SoundFile(final_project.this, "sounds\\piano\\4.wav")};
  
  
  int boardWidth = 1280;
  int boardHeight = 720;
  int NUM_OF_SONARS = 4;
  int chamshaStartX = width/5;
  int chamshaStartY = height/3;
  int chamshaWidth = boardWidth-2*chamshaStartX;
  int chamshaHeight = boardHeight-2*chamshaStartY;
  int numOfLines = 4;
  int COLORS_NUM = 4;
  int numOfBalls = 6;
  float gapBtwLines = chamshaHeight / numOfLines;
  final boolean ACTIVATE_PRINT = false;  

  Map<Integer, Integer> ballsColors  = new HashMap<Integer, Integer>()    
  {{
      put(0, #e61971);
      put(1, #28d763);
      put(2, #4a6eb5);
      put(3, #eff486);
  }};
    
  Map<Integer, Integer> hoverBallsColors  = new HashMap<Integer, Integer>() 
  {{
    put(0, #bb0d58);
    put(1, #08ae40);
    put(2, #254c9a);
    put(3, #cad047);
  }};
         
         
  /**
  * Prints the children if ACTIVATE_PRINT macro equal to 1.
  * children: ArrayList containing children.
  */
  public void printChildren(ArrayList<Child> children ) { 
    if(ACTIVATE_PRINT){
      for (Child c : children) {
        for (ArrayList<Integer> session : c.sessions) {
          for (int i : session) {
            print(i+", ");
          }
          println();
        }
        println("................");
      }
    }
  }
  
  
  void drawChamsha(int chamshaStartX, int chamshaStartY, int chamshaWidth, int chamshaHeight, int numOfLines) {
    float gapBtwLines = chamshaHeight / numOfLines;
    strokeWeight(2);
    stroke(0);
    fill(#b5b9da);
    rect(chamshaStartX, chamshaStartY-gapBtwLines, chamshaWidth, chamshaHeight+gapBtwLines);
    stroke(#151629);
    for (int i =0; i < numOfLines; i++) {
      line(chamshaStartX, chamshaStartY+i*gapBtwLines, chamshaStartX+chamshaWidth, chamshaStartY+i*gapBtwLines);
    }
  }


  ArrayList<Integer> createRandomSession(int sessionLen) {
    ArrayList<Integer> session = new ArrayList<Integer>();
    Random r = new Random();
    for (int i =0; i < sessionLen; i++) {
      int ballNum = r.nextInt(utils.COLORS_NUM);
      session.add(ballNum);
    }
    return session;
  }


  void createAllBalls(Ball[] ballsArr, int chamshaWidth, int chamshaHeight, int numOfBalls, int chamshaStartX, int chamshaStartY,
    int ballRadius, ArrayList<Integer> session, int startIdx) {
    int gapBtwBalls = chamshaWidth / numOfBalls;
    int originGap = gapBtwBalls / 2;
    int heightsGaps = chamshaHeight / utils.ballsColors.size();
    heightsGaps = chamshaHeight / numOfLines;
    for (int i =startIdx; i < startIdx+numOfBalls; i++) {
      if (i < session.size()){
      int ballNum = session.get(i);
      int ballColor = utils.ballsColors.get(ballNum);
      Ball b = new Ball(chamshaStartX +originGap + i*gapBtwBalls, chamshaStartY + heightsGaps * ballNum, ballRadius, ballColor, ballNum);
      ballsArr[i % numOfBalls] = b;
      }
    }
  }


  void displayAllBalls(Ball[] ballsArr, ArrayList<Integer> session, int startIdx, int chamshaHeight) {
    int heightsGaps = chamshaHeight / utils.ballsColors.size();
    for (int i =0; i < utils.numOfBalls; i++) {
      if ( startIdx+i < session.size()) {
        int ballNum = session.get(startIdx+i);
        int ballColor = utils.ballsColors.get(ballNum);
        ballsArr[i].changeColor(ballColor, ballNum, chamshaStartY + heightsGaps * ballNum);
        ballsArr[i].display(ballsArr[i].getColor());
        ballsArr[i].updatePs();
      }
    }
     saveFrame("images\\temp.png");
  }
}
