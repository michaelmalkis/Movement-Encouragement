
abstract class Button {

  int x, y;
  int btnSize;
  color btnColor, baseColor;
  color highlightColor;
  color currentColor;
  boolean btnOver = false;
  ActionOnPress action;
  boolean showBtn = true;
  String text;
  int textSize = min(height/24, width/24);


  Button(int cColor, int highlightCol, int baseColorCircle, int diameter, int xCoord, int yCoord, ActionOnPress act, String btnText) {
    btnSize = diameter;
    x = xCoord;
    y = yCoord;
    action = act;
    text = btnText;
    btnColor = color(cColor);
    highlightColor = color(highlightCol);
    baseColor = color(baseColorCircle);
    currentColor = baseColor;
    ellipseMode(CENTER);
  }
  
  
  /**
  * makes the button unactive and invisible.
  */
  void unShowBtn() {
    showBtn = false;
    btnOver = false;
    
  }


  /**
  * makes the button active and visible.
  */
  void showBtn() {
    showBtn = true;
  }


  /**
  * Draws the button.
  */
  void drawBtn() {
    if (!showBtn) {
      return;
    }
    update();
    if (btnOver) {
      fill(highlightColor);
    } else {
      fill(btnColor);
    }
    stroke(0);
  }

  
  /**
  * Updates the btnOver.
  */
  void update() {
    if (!showBtn){return;}
    if (overBtn(x, y, btnSize, btnSize)) {
      btnOver = true;
    } else {
      btnOver = false;
    }
  }

  /**
  * If button pressed activate the relevent action.
  */
  void btnMousePressed() {
    if (btnOver && showBtn) {
      action.actionOnMousePressed();
    }
  }


  abstract boolean overBtn(int x, int y, int w, int h);
}
