
final int CREATE_SESSION_SCREEN = 0;
final int CHILD_SESSION_MENU_SCREEN = 1;


class CreateSessionBtn implements ActionOnPress {

  void actionOnMousePressed() {
    childSessionMenu.close();
    screen = Screens.CHILD_SESSION_MENU;
    createSession.open();
  }
}


class OpenLibrary implements ActionOnPress {

  void actionOnMousePressed() {
    sessionMenu.close();
    library.open();
  }
}


class OpenOnSessionPressed implements ActionOnPress {
  int sessionIdx;


  OpenOnSessionPressed(int childIdx) {
    this.sessionIdx = childIdx;
  }


  void actionOnMousePressed() {
    onSessionPressed.sessionIdx = sessionIdx;
    library.childIdx = sessionIdx;
    switch (screen) {
    case CHILD_SESSION_MENU:
      childSessionMenu.close();
      break;
    case LIBRARY:
      library.close();
      break;
    default:
      break;
    }
    onSessionPressed.open();
  }
}


class OpenSessionMenu implements ActionOnPress {
  
  void actionOnMousePressed() {
    menu.closeMenu();
    sessionMenu.open();
  }
}


class ChooseSound implements ActionOnPress {
  
  void actionOnMousePressed() {
    menu.closeMenu();
    chooseSoundMenu.openChooseSoundMenu();
  }
}




class SaveSession implements ActionOnPress {

  void actionOnMousePressed() {   
    switch (lastScreen) {
    case CHILD_SESSION_MENU:
      oldSessions.children.get(childSessionMenu.childIdx).addSession(createSession.session);
      saveChildren(oldSessions.children);
      utils.printChildren(oldSessions.children);
      break;
    case LIBRARY:
      library.children.get(library.childIdx).addSession(createSession.session);
      saveChildren(library.children);
      break;
    default:
      break;
    }
  }
}





class OpenChildSessions implements ActionOnPress {
  
  int idx;


  OpenChildSessions(int idxInChildrenArr) {
    idx = idxInChildrenArr;
  }

  void actionOnMousePressed() {
    oldSessions.close();
    childSessionMenu.setChild(idx);
    childSessionMenu.open();
  }
}



class BackToMenu implements ActionOnPress {

  void actionOnMousePressed() {
    if (!game.showGame) {
      return;
    } 
    black = new ArrayList<cords>();
    game.closeGame();
    menu.openMenu();
  }
}


//---------------------------------------------------------- Menu -----------------------------------------------------------
class RandomGame implements ActionOnPress {

  void actionOnMousePressed() {
    menu.closeMenu();
    game.setSession(utils.createRandomSession(12));
    game.openGame();
  }
}
//------------------------------------------------------- ChooseSound -------------------------------------------------------

class SoundSetter implements ActionOnPress {
  SoundFile[] sounds = new SoundFile[utils.NUM_OF_SONARS];
  
  SoundSetter(SoundFile[] audioSounds){
    sounds = audioSounds;
  }
  void actionOnMousePressed() {
    game.setAudioSounds(sounds);
    chooseSoundMenu.closeChooseSoundMenu();
    menu.openMenu();
    
  }
}

class SoundSetterRandom implements ActionOnPress {
  SoundFile[] sounds = new SoundFile[utils.NUM_OF_SONARS];
  void actionOnMousePressed() {
    float rnd = random(0, 4);
    if(rnd < 1){
      sounds = utils.guitarSounds;
    }else if(rnd<2){
      sounds = utils.drumsSounds;
    }else if(rnd<3){
      sounds = utils.pianoSounds;
    }else{
      sounds = utils.electronicSounds;
    }
    game.setAudioSounds(sounds);
    chooseSoundMenu.closeChooseSoundMenu();
    menu.openMenu();  
  }
}


class BackToMenuFromSoundMenu implements ActionOnPress {

  void actionOnMousePressed() {
    chooseSoundMenu.closeChooseSoundMenu();
    menu.openMenu();
  }
}


//--------------------------------------------------------- Library ---------------------------------------------------------
class CreateSessionBtnFromLibrary implements ActionOnPress {
  
  int childIdx;
  
    
  CreateSessionBtnFromLibrary(int childIdx) {
    this.childIdx = childIdx;
  }

  void actionOnMousePressed() {
    library.childIdx = childIdx;
    library.close();
    screen = Screens.LIBRARY;
    createSession.open();
  }
}


class AddChildLibrary implements ActionOnPress {
  String enterNameTxt = "Enter session name:";
  int textSize = 10;

  void actionOnMousePressed() {
    library.drawPopUp = true;
    childName = "";
  }


  void drawPopUp() {
    showTheName = true;
    stroke(0);
    fill(255);
    rect(width*4/12, height*3/12, width*2/5, height/4);
    fill(0);
    textSize(min(height/24, width/24));
    text(enterNameTxt, width*5/12, height*4/12);
    
  }


  void showName() {
    drawPopUp();

    fill(0);
    textSize(min(height/24, width/24)*0.6);
    text(childName, width*5/12, height*5/12);
  }
}


class BackToSessionMenuFromLibrary implements ActionOnPress {

  void actionOnMousePressed() {
    library.close();
    switch (lastScreen) {
    case ADD_FROM_LIBRARY:
      childSessionMenu.open();
      break;
    case SESSION_MENU:
    case ON_SESSION_PRESSED:
    case CREATE_SESSION:
      sessionMenu.open();
      break;
    default:
      break;
    };
  }
}
//-------------------------------------------------------- OldSession -------------------------------------------------------
class AddChild implements ActionOnPress {
  String enterNameTxt = "Enter child name:";
  int textSize = min(height/24, width/24);


  void actionOnMousePressed() {
    oldSessions.drawPopUp = true;
    childName = "";
  }


  void drawPopUp() {
    showTheName = true;
    stroke(0);
    fill(255);
    rect(width*4/12, height*3/12, width*2/5, height/4);
    fill(0);
    textSize(max(textSize,5));
    text(enterNameTxt, width*5/12, height*4/12);
  }


  void showName() {
    drawPopUp();

    fill(0);
    textSize(max(textSize*0.6,5));
    text(childName, width*5/12, height*5/12);
  }
}


class BackToSessionMenuFromOldSession implements ActionOnPress {

  void actionOnMousePressed() {
    oldSessions.close();
    sessionMenu.open();
  }
}


//----------------------------------------------------- ChildSessionMenu ----------------------------------------------------
class AddFromLibrary implements ActionOnPress {

  void actionOnMousePressed() {
    screen = Screens.ADD_FROM_LIBRARY;
    library.addFromLibrary = true;
    childSessionMenu.close();
    library.open();
  }
}


class BackToOldSessionsFromChildSessionMenu implements ActionOnPress {

  void actionOnMousePressed() {
    childSessionMenu.close();
    sessionMenu.open();
  }
}


//----------------------------------------------------- OnSessionPressed ----------------------------------------------------

class PlaySession implements ActionOnPress {
  
  ArrayList<Integer> session;
  int screenToClose;


  PlaySession(ArrayList<Integer> s, int screenToClose) {    
    session = s;
    this.screenToClose = screenToClose;
  }


  void actionOnMousePressed() {
    game.setSession(session);
    switch (screenToClose) {
    case CREATE_SESSION_SCREEN:
      createSession.close();
      break;
    case CHILD_SESSION_MENU_SCREEN:
      onSessionPressed.close();
      break;
    }
    game.openGame();
  }
}


class AddSession implements ActionOnPress {

  void actionOnMousePressed() {
    oldSessions.children.get(childSessionMenu.childIdx).addSession(onSessionPressed.session);
    saveChildren(oldSessions.children);
    onSessionPressed.close();
    childSessionMenu.open();
  }
}


class BackInSession implements ActionOnPress {

  void actionOnMousePressed() {
    onSessionPressed.backInSession();
  }
}


class DeleteSession implements ActionOnPress {

  void actionOnMousePressed() {
    switch (lastScreen) {
    case LIBRARY:
      library.children.remove(library.childIdx);
      saveChildren(library.children);
      onSessionPressed.close();
      library.open();
      break;
    default:
      oldSessions.children.get(childSessionMenu.childIdx).sessions.remove(onSessionPressed.sessionIdx);
      onSessionPressed.close();
      childSessionMenu.open();
      break;
    }
  }
}


class BackToChildsFromOnSession implements ActionOnPress {

  void actionOnMousePressed() {
    onSessionPressed.close();
    childSessionMenu.open();
  }
}


class Next implements ActionOnPress {

  void actionOnMousePressed() {
    onSessionPressed.drawBalls();
  }
}


class BackToLibraryFromOnSession implements ActionOnPress {

  void actionOnMousePressed() {
    onSessionPressed.close();
    library.open();
  }
}


//------------------------------------------------------- CreateSession -----------------------------------------------------

class AddNote implements ActionOnPress {
  int colorNum;

  AddNote(int num) {
    colorNum = num;
  }


  void actionOnMousePressed() {
    createSession.session.add(colorNum);
    createSession.displayBall(createSession.curBallIdx);
    createSession.curBallIdx++;
  }
}


class BackFromCreateSession implements ActionOnPress {

  void actionOnMousePressed() {
    createSession.close();
    switch (lastScreen) {
    case CHILD_SESSION_MENU:
      childSessionMenu.open();
      break;
    case LIBRARY:
      library.open();
      break;
    default:
      break;
    }
  }
}


//-------------------------------------------------------- SessionMenu ------------------------------------------------------
class BackToMenuFromSessionMenu implements ActionOnPress {

  void actionOnMousePressed() {
    sessionMenu.close();
    menu.openMenu();
  }
}
