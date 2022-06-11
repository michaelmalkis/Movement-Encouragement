
final int NUM_OF_INSTRUMENTS = 4;
final int devisorWidth = 5;
final int devisorHeight = 5;
final int multiplier = 3;




class ChooseSoundMenu {
  boolean showChooseSoundMenu = false;
  Button buttons[] = new Button[6];
  int NUM_OF_SONARS = 4;


  ChooseSoundMenu() {
    buttons[0] = new ImgButton(#c8ade3, #8141be, #b7487b, width*6/24, width*2/12, height/10, new SoundSetter(utils.guitarSounds), "Guitar");
    buttons[1] = new ImgButton(#c8ade3, #8141be, #b7487b, width/4, width*5/10, height/10, new SoundSetter(utils.drumsSounds), "Drums");
    buttons[2] = new ImgButton(#70c1e3, #2aa3d5, #70c1e3, width/4, width*2/12, height*5/10, new SoundSetter(utils.pianoSounds), "Piano");
    buttons[3] = new ImgButton(#70c1e3, #2aa3d5, #70c1e3, width/4, width*5/10, height*5/10, new SoundSetter(utils.electronicSounds), "Electronic");
    buttons[4] = new ImgButton(#2aa3d5, #70c1e3, #b7487b,2*min(width/10, height/10),0, 0, new BackToMenuFromSoundMenu(), "back");
    buttons[5] = new ImgButton(#70c1e3, #2aa3d5, #70c1e3, width/8, width*4/5 + width/35, height*5/20, new SoundSetterRandom(), "Random");
  }
  
  
  /**
  * Chooses a sound randomly from the four options.
  */
  SoundSetter randomSound(){
    int s = (int) random(0, 4);
    switch (s) {
      case 0: return new SoundSetter(utils.guitarSounds);
      case 1: return new SoundSetter(utils.drumsSounds);
      case 2: return new SoundSetter(utils.pianoSounds);
      default: return new SoundSetter(utils.electronicSounds);
    }
      
  }

  
  /**
  * Causes the layout to be shown.
  */
  void openChooseSoundMenu() {
    showChooseSoundMenu = true;
    drawBtns();
  }
  
  
  /**
  * Displays the buttons.
  */
  void drawBtns() {
    if (!showChooseSoundMenu) {
      return;
    }
    for (Button b : buttons) {
      b.showBtn();
    }
  }


  /**
  * Displays the layout.
  */
  void displayChooseSoundMenu() {
    if (!showChooseSoundMenu) {
      return;
    }
    background(#fadeed);
    PImage p = loadImage("images\\backGround3.jpg");
    p.resize(1280, 720);
    background(p);
    for (Button b : buttons) {
      b.drawBtn();
    }
  }

  
  /**
  * Closes the choose sound layout.
  */
  void closeChooseSoundMenu() {
    showChooseSoundMenu = false;
    for (Button b : buttons) {
      b.unShowBtn();
    }
  }


  void onPressed() {
    if (!showChooseSoundMenu) {
      return;
    }
    for (Button b : buttons) {
      b.btnMousePressed();
    }
  }
}
