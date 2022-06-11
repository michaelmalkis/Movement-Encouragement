
class CircleButton extends Button {
  int _textSize;

  CircleButton(int cColor, int highlightCol, int baseColorCircle, int diameter, int xCoord, int yCoord, ActionOnPress act,  String btnText, int textSize) {
    super(cColor, highlightCol,  baseColorCircle,  diameter,  xCoord,  yCoord, act, btnText);
    _textSize = textSize;
  }


  void drawBtn() {
    super.drawBtn();
    ellipse(x, y, btnSize, btnSize);
    fill(0);
    textSize(max(_textSize,2));
    text(text, x-0.3*btnSize, y);
  }


  boolean overBtn(int x, int y, int w, int h) {
    float disX = x - mouseX;
    float disY = y - mouseY;
    if (sqrt(sq(disX) + sq(disY)) < w/2 ) {
      return true;
    } else {
      return false;
    }
  }
}
