
class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  int radius;


  Particle(PVector l, int r, int amount) {
    int multiply_a, multiply_v;
    lifespan =15.0;
    if(amount<10){
      multiply_a = 1;
      multiply_v = 1;
    }else{
      lifespan = 7;
      multiply_a = 5;
      multiply_v = 4;
    }
    radius = r/2;
    float angle = random(0, 1) * PI * 2;
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;
    int direction_x = (x>0)?1:-1;
    int direction_y = (y>0)?1:-1;
    float first, second;
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    first = x+l.x;
    second = y+l.y;
    position =new PVector(first, second);
    float x_vel = multiply_a * 2*random(0.2, 0.07);
    float y_vel = multiply_a * 2*random(0.2, 0.07);
    float x_acc = multiply_v * random(0.3, 0.5);
    float y_acc = multiply_v * random(0.3, 0.5);
    switch (direction_x+direction_y) {
    case -2:
      velocity = new PVector(-1*x_vel, -1*y_vel);
      acceleration = new PVector(-1*x_acc, -1*y_acc);
      break;
    case 2:
      velocity = new PVector(x_vel, y_vel);
      acceleration = new PVector(y_acc, y_acc);
      break;
    default:
      if (direction_x>0) {
        velocity = new PVector(x_vel, -1*y_vel);
        acceleration = new PVector(y_acc, -1*y_acc);
      } else {
        velocity = new PVector(-1*x_vel, y_vel);
        acceleration = new PVector(-1*y_acc, y_acc);
      }
      break;
    }
  }
  

  void run(int a, int b) {
    update();
    display(a, b);
  }

  
  /**
  * Method to update position.
  */
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }


  /** 
  * Method to display.
  */
  void display(int a, int b) {
    PImage img_particle = loadImage("images\\partical.png");
    int s = 15;
    image(img_particle, position.x-s/2, position.y-s/2, s, s);
  }


  /**
  * Checks if particle is alive or not.
  */
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
