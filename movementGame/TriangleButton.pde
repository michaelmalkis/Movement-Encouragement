
class TriangleButton extends Button {

  PShape triangle;
  int _textSize;
    
    
  TriangleButton(int cColor, int highlightCol, int baseColorCircle, int diameter, int xCoord, int yCoord, ActionOnPress act,  String btnText, int textSize) {
    super(cColor, highlightCol,  baseColorCircle,  diameter,  xCoord,  yCoord, act, btnText);
    _textSize = textSize;

  }


  void drawBtn() {
    super.drawBtn();
    triangle(x, y, x, y+btnSize, x+(btnSize/2), y+(btnSize/2));
    fill(0);
    textSize(_textSize);
    text(text, x+btnSize/14,y+btnSize/2);
  }


  boolean overBtn(int x, int y, int w, int h) {
    int px = mouseX;
    int py = mouseY;
    float Area = 0.5 *(-(y+(btnSize/2))*x +y*(-(x+btnSize/2) + x) + x*(y+(btnSize/2) - (y+(btnSize/2))) + (x+btnSize/2)*(y+btnSize/2));
    float s = 1/(2*Area)*(y*x - x*(y+btnSize/2) + (y+btnSize/2 - y)*px + (x - x)*py);
    float t = 1/(2*Area)*(x*(y+btnSize/2) - y*(x+btnSize/2) + (y -    ( y+btnSize/2))*px + (x+btnSize/2 - x)*py);
    return s>0 && t>0 && 1-s-t>0;
  }
}
