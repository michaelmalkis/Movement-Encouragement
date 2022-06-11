
int B_MASK = 255;
int G_MASK = 255<<8; //65280
int R_MASK = 255<<16; //16711680
ArrayList<cords> black = new ArrayList<cords>();

class cords {
  
  int x, y, r;
  
  
  cords(int x_cord, int y_cord, int radius) {
    x = x_cord;
    y = y_cord;
    r = radius;
  }
}


class Ball {
  
  PImage[] images = new PImage[4];
  int mX;
  int mY;
  int mR;
  int mColor;
  int mNumOfColor;
  PImage mImg;
  ParticleSystem ps;
  int interval_flash;
  boolean origin_color = true;
  boolean drawing = false;
  int save_color;


  Ball(int x, int y, int r, int aColor, int numOfColor) {
    mX = x;
    mY = y;
    mR = r;
    mColor = aColor;
    mNumOfColor = numOfColor;
    mImg = images[mNumOfColor];
    interval_flash=millis();
    ps = new ParticleSystem(new PVector(mX, mY), mR);
  }
  
  /**
  * Turns finished circles black.
  */
  void cords_black_on_screen() {
    for (cords tmp : black) {
      stroke(0);
      fill(0);
      circle(tmp.x, tmp.y, tmp.r);
    }
  }

  /**
  * Creates particle system to the current ball to make the particles come out of it.
  */
  void updatePs() {
    ps=new ParticleSystem(new PVector(mX, mY), mR);
  }

  /**
  * aColor: the color to use for the ball.
  * Displays the ball with the received color.
  */
  void display(int aColor) {
    stroke(0);
    fill(aColor);
    circle(mX, mY, mR);
  }


  /**
  * newColor:New color for the ball.
  * colorNum: New number value for the ball.
  * height_value: New height value for the ball.
  * Updates the ball data.
  */
  void changeColor(int newColor, int colorNum, int height_value) {
    mY = height_value;
    mColor = newColor;
    mNumOfColor = colorNum;
  }

  /**
  * return: The color of the ball.
  */
  int getColor() {
    return mColor;
  }

  /**
  * return: The number of the ball in the current game.
  */
  int getNumOfColor() {
    return mNumOfColor;
  }

  /**
  * 
  * The distance that is shown on the sonar.
  */
  void explode(float distance) {
    distance = distanceFromSonar;
    if (mColor==0) {
      return;
    }
    int r = (mColor & R_MASK)>>16;
    int g = (mColor & G_MASK)>>8;
    int b = mColor & B_MASK;
    background(loadImage("images\\temp.png"));
    cords_black_on_screen();
    if (millis()-interval_flash>500) {
      origin_color=!origin_color;
      interval_flash = millis();
    }
    if (!origin_color) {
      int color_temp ;
      switch(mColor) {
      case #e61971:
        color_temp=color(163, 21, 82);
        break;
      case #28d763:
        color_temp=color(25, 156, 69);
        break;
      case #4a6eb5:
        color_temp=color(47, 82, 150);
        break;
      default:
        color_temp=color(179, 184, 90);
      }
      stroke(color_temp);
      fill(color_temp);
      circle(mX, mY, mR);
    } else {
      stroke(mColor);
      fill(mColor, 100);
      circle(mX, mY, mR);
    }
    if (distance < 0) {
      ps.addParticle(3);
      ps.run(10, 255);
    } else if (distance < 10) {
      ps.addParticle(1);
      ps.run(1, color(r, g, b));
    } else if (distance < 15) {
      ps.addParticle(2);
      ps.run(3, color(r-100, g-100, b-100));
    } else if (distance < 20) {
      ps.addParticle(3);
      ps.run(5, color(0, 0, 0));
    } else {
      ps.addParticle(3);
      ps.run(10, 255);
    }
  }
  
  /**
  * Changes the ball color to make him noticable compare to the other balls.
  */
  void shadesCheck() {
    if (mColor==0) {
      return;
    }
    if (drawing) {
      int r = max((save_color & R_MASK)>>16, 0);
      int g = max((save_color & G_MASK)>>8, 0);
      int b = max(save_color & B_MASK, 0);

      switch(mColor) {
      case #e61971:
        r = r - 13;
        g = g - 2;
        b = b - 5;
        break;
      case #28d763:
        r = r - 5;
        g = g - 12;
        b = b - 5;
        break;
      case #4a6eb5:
        r = r - 4;
        g = g - 6;
        b = b - 12;
        break;
      default:
        r = r - 14;
        g = g - 14;
        b = b - 6;
      }
      if (r <= 0 && g <= 0 && b <= 0) {
        save_color = 0;
        drawing=false;

        mColor=0;
        black.add(new cords(mX, mY, mR));
        cords_black_on_screen();
      } else
      {
        r = max(r, 0);
        g = max(g, 0);
        b = max(b, 0);
        save_color=color(r, g, b);
        stroke(save_color);
        fill(save_color);
        circle(mX, mY, mR);
      }
    }
  }
 
 
  void onPressed() {
    display(0);
    int r = (mColor & R_MASK)>>16;
    int g = (mColor & G_MASK)>>8;
    int b = mColor & B_MASK;
    save_color = mColor;
    drawing = true;
    distanceFromSonar = -1;
  }
}
