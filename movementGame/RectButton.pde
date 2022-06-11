
class RectButton extends Button {
  float rectWidth, rectHeight;
  
  RectButton(int cColor, int highlightCol, int baseColorCircle, int diameter, int xCoord, int yCoord, ActionOnPress act,  String btnText) {
    super(cColor, highlightCol, baseColorCircle, diameter, xCoord, yCoord, act, btnText);
    rectWidth = 1.2 * diameter;
    rectHeight = 0.8 * diameter;
  }


  void drawBtn() {
    super.drawBtn();
    rect(x, y, rectWidth, rectHeight, 16);
    fill(0);
    textSize(textSize);
    text(text, x+0.2*btnSize,y+0.3*btnSize);
  }
  

   boolean overBtn(int x, int y, int w, int h) {
    if (mouseX >= x && mouseX <= x+1.2*w &&
      mouseY >= y && mouseY <= y+0.8*h) {
      return true;
    } else {
      return false;
    }
  }
}
