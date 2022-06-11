
class ImgButton extends Button {

  PImage [] pics = new PImage[15];
  float rectWidth, rectHeight;
  
  
  ImgButton(int cColor, int highlightCol, int baseColorCircle, int diameter, int xCoord, int yCoord, ActionOnPress act,  String btnText) {
    super(cColor, highlightCol, baseColorCircle, diameter, xCoord, yCoord, act, btnText);
    pics[0] = loadImage("images\\piano.jpg");
    pics[1] = loadImage("images\\guitar.jpg");
    pics[2] = loadImage("images\\drums.jpg");
    pics[3] = loadImage("images\\electronic.jpg");
    pics[4] = loadImage("images\\back2.png");
    pics[5] = loadImage("images\\library.png");
    pics[6] = loadImage("images\\children.png");
    pics[7] = loadImage("images\\add-child.png");
    pics[8] = loadImage("images\\next-page.png");
    pics[9] = loadImage("images\\prev-page.png");
    pics[10] = loadImage("images\\garbage.png");
    pics[11] = loadImage("images\\save.png");
    pics[12] = loadImage("images\\add.png");
    pics[13] = loadImage("images\\random.png");
    pics[14] = loadImage("images\\play.png");
    rectWidth = 1.2 * diameter;
    rectHeight = 0.8 * diameter;
  }


  void drawBtn() {
    super.drawBtn();
    PFont f=createFont("Arial",16,true); 
    if (btnOver) {
      fill(highlightColor);
    } else {
      fill(btnColor);
    }
    switch (text) {
      case "Piano":
            rect(x,y, rectWidth, rectHeight, 16);
            image(pics[0], x + width/34, y+ height/20, btnSize, 0.6 * btnSize);
        break;
      case "Guitar":
            rect(x,y, rectWidth, rectHeight, 16);
            image(pics[1], x + width/34, y+ height/20, btnSize, 0.6 * btnSize);
        break;
      case "Drums":
            rect(x,y, rectWidth, rectHeight, 16);
            image(pics[2], x + width/34, y+ height/20, btnSize, 0.6 * btnSize);
        break;
      case "Electronic":
            rect(x,y, rectWidth, rectHeight, 16);
            image(pics[3], x + width/34, y+ height/20, btnSize, 0.6 * btnSize);
        break;
      case "back":
             image(pics[4], min(width/30,height/30), min(width/80,height/80), 70 + min(width/30,height/30), 70 + min(width/30,height/30));
        break;
      case "Library":
            rect(x, y, rectHeight, rectWidth, 16);
            image(pics[5], x - width/34, y+ height/20, btnSize, btnSize);
           break;
      case "Children":
            rect(x,y, rectWidth, rectHeight, 16);
           image(pics[6], x + width/34, y, btnSize, btnSize);   
           break;
       case "Add Child":
           image(pics[7], x, y, btnSize, btnSize);   
           break;
      case "nextPage":
           image(pics[8], x, y, btnSize, btnSize);   
          break;
      case "prevPage":
         image(pics[9], x, y, btnSize, btnSize);   
          break;
      case "Delete":
         image(pics[10], x, y, btnSize, btnSize);  
         fill(0);  
         textFont(f,16);
         text("Delete\nSession", x + btnSize/3, y +1.2* btnSize);
         break;              
      case "SAVE":
       image(pics[11], x, y, btnSize, btnSize);  
        break;
      case "add in lib":
          fill(0);
          textSize(36);
          text("Add", x + btnSize/3,y + btnSize/6);
          image(pics[12], x, y, btnSize, btnSize);  
          break;
      case "Random":
          image(pics[13], x, y, btnSize, btnSize); 
          break;
      case "play":
        image(pics[14], x, y, btnSize, btnSize);
        break;
    }
  }

  
  boolean overBtn(int x, int y, int w, int h) {
      if (text == "Guitar" || text == "Drums" || text == "Electronic" || text == "Piano"){
            if (mouseX >= x && mouseX <= x+1.2*w &&
                mouseY >= y && mouseY <= y+0.8*h) {             
              return true;
            } else {
              return false;
            }
      }
      if (mouseX >= x && mouseX <= x+w &&
          mouseY >= y && mouseY <= y+h) {
          return true;
      } else {
          return false;
      }
  }
}
