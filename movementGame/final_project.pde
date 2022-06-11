import java.util.Map; //<>// //<>// //<>//
import java.util.Random;
import processing.sound.*;
import processing.serial.*;    // Importing the serial library to communicate with the Arduino
import java.io.File;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.io.FileInputStream;
import java.io.ObjectInputStream;

Serial myPort;      // Initializing a vairable named 'myPort' for serial communication
Menu menu;
GameManager game;
ChooseSoundMenu chooseSoundMenu;
CreateSession createSession;
Utils utils;
SessionMenu sessionMenu;
OldSessions oldSessions;
ChildSessionMenu childSessionMenu;
OnSessionPressed onSessionPressed;
Library library;
String cur_project_path;
String PATH_OF_SAVED_DATA_CHILDREN = "DB\\children1.txt";
String PATH_OF_SAVED_DATA_LIBRARY = "DB\\library1.txt";
enum Screens {
  LIBRARY, CHILD_SESSION_MENU, OLD_SESSIONS, ADD_FROM_LIBRARY, GAME, CREATE_SESSION, SESSION_MENU, MENU, ON_SESSION_PRESSED
}
Screens screen;
Screens lastScreen;

int numOfSonar = -1;
int distanceFromSonar = -1;
boolean withErduino = false;
String childName = "";
boolean showTheName = false;


/**
* inits the game: the screens and DB.
*/
void setup() {
  size(1280, 720);
  PFont font;
  font = createFont("Segoe Print", 16, true);
  textFont(font);
  cur_project_path = sketchPath("");
  PATH_OF_SAVED_DATA_CHILDREN = cur_project_path + PATH_OF_SAVED_DATA_CHILDREN;
  PATH_OF_SAVED_DATA_LIBRARY = cur_project_path + PATH_OF_SAVED_DATA_LIBRARY;
  if (withErduino) {
    // Set the com port and the baud rate according to the Arduino IDE
    myPort  =  new Serial (this, "COM6", 9600);
    //Receiving the data from the Arduino IDE
    myPort.bufferUntil ( '\n' );
  }
  utils = new Utils();
  menu = new Menu();
  sessionMenu = new SessionMenu();
  createSession = new CreateSession();
  menu.openMenu();
  game = new GameManager(START);
  chooseSoundMenu = new ChooseSoundMenu();
  oldSessions = new OldSessions();
  childSessionMenu = new ChildSessionMenu();
  onSessionPressed = new OnSessionPressed();
  library = new Library();
}


/**
* saves the children at the relevent path based on the current screen.
* children: array the represents children objects to save.
*/
void saveChildren(ArrayList<Child> children) {
  utils.printChildren(children);
  String path = "";
  switch (screen) {
  case OLD_SESSIONS:
    path = PATH_OF_SAVED_DATA_CHILDREN;
    break;
  case LIBRARY:
    path = PATH_OF_SAVED_DATA_LIBRARY;
    if (library.addFromLibrary) {
      path = PATH_OF_SAVED_DATA_CHILDREN;
    }
    break;
  default:
    path = PATH_OF_SAVED_DATA_CHILDREN;
    switch (lastScreen) {
    case OLD_SESSIONS:
      path = PATH_OF_SAVED_DATA_CHILDREN;
      break;
    case LIBRARY:
      path = PATH_OF_SAVED_DATA_LIBRARY;
      break;
    default:
      path = PATH_OF_SAVED_DATA_CHILDREN;
      break;
    }
    if (library.addFromLibrary) {
      path = PATH_OF_SAVED_DATA_CHILDREN;
    }
  }
  try {
    ObjectOutputStream os = new ObjectOutputStream(new FileOutputStream(path));
    os.writeObject(children);
    os.close();
  }
  catch (Exception e) {
    println(e);
  }
}


/**
* reads the children from the relevent path based on the current screen.
* incase of error return a new object.
* return: ArrayList of children.
*/
ArrayList<Child> readChildren() {
  String path = "";
  switch (screen) {
  case OLD_SESSIONS:
    path = PATH_OF_SAVED_DATA_CHILDREN;
    break;
  case LIBRARY:
    path = PATH_OF_SAVED_DATA_LIBRARY;
    break;
  default:
    path = PATH_OF_SAVED_DATA_CHILDREN;
    break;
  }
  try {
    ObjectInputStream is = new ObjectInputStream(new FileInputStream(path));
    ArrayList<Child> children = (ArrayList<Child>) is.readObject();
    is.close();
    utils.printChildren(children);
    return children;
  }
  catch (Exception e) {
    println(e);
  }
  return new ArrayList<Child>();
}


/**
* Gets data from arduino and responds accordingly.
* myPort: Data from arduino.
*/
void serialEvent  (Serial myPort) {
  String str = (myPort.readStringUntil ( '\n' ) ) ; 
  str = str.substring(0, str.length()-1);
  if (str != null) {
    String[] splitS = str.split(" ");
    int s=Integer.parseInt(splitS[0]);
    int distance = Integer.parseInt(splitS[1]);
    int k = Math.round(s);
    if (0 <= k && k <= 3) {
      numOfSonar = k;
      distanceFromSonar = distance;
      
    }        
  }
}


/**
* Activates the onPressed function of each screen class.
* The current screen on press will act accurdenly and the other will ignore the call.
*/
void mousePressed() {
  menu.onPressed();
  sessionMenu.onPressed();
  game.onPressed();
  chooseSoundMenu.onPressed();
  createSession.onPressed();
  oldSessions.onPressed();
  childSessionMenu.onPressed();
  onSessionPressed.onPressed();
  library.onPressed();
}


/**
* Function that connects the game functinality with keyboard presses.
*/
void keyPressed() {
  if (key == TAB) {
    game.successBall();
  } else if (key == '{') {
    game.newGameSession();
  } else if ( key == DELETE) {
    game.closeGame();
    chooseSoundMenu.closeChooseSoundMenu();
    createSession.close();
    menu.openMenu();
  }
  if ( (key>='a' && key<='z') ||
    (key>='a' && key<='z') ||
    (key>='0' && key<='9') || (key == ' ')
    ) {
    childName += key;
  } else if (key == ENTER) {
    switch (screen) {
    case LIBRARY:
      library.addChild(childName);
      break;
    default:
      oldSessions.addChild(childName);
    }
  } else if (key == BACKSPACE) {
    childName = childName.substring(0, childName.length() - 1);
  } 
}


/**
* draws the current screen.
*  
*/
void draw() {  
  if (numOfSonar != -1 && game.showGame) {
    game.checkBall(numOfSonar, distanceFromSonar);
    numOfSonar = -1; 
  }
  menu.displayMenu();
  sessionMenu.display();
  game.displayGame(distanceFromSonar);
  chooseSoundMenu.displayChooseSoundMenu();
  createSession.display();
  oldSessions.display();
  childSessionMenu.display();
  onSessionPressed.display();
  library.display();
}


static class Child implements Serializable {  
  String name;
  ArrayList<ArrayList<Integer>> sessions = new ArrayList<ArrayList<Integer>> ();


  Child(String name) {
    this.name = name;
  }
  
  
  Child(Child child) {
    name = child.name;
    sessions = new ArrayList<ArrayList<Integer>> (child.sessions);
  }
  
  
  void addSession(ArrayList<Integer> session) {
    sessions.add(new ArrayList<Integer> (session));
  }
}
