class Moveable {

float x, y, w, h, vx, vy, ax, ay;

  float g = 0.4; // Gravitational constant
  float friction = 0.7; // Friction constant
  float speedLimit = 1.5; // Speed Limit
  float jumpConstant = -8; // Jump constant (up y-accel when jumping)
  ElementType type;
  

  
  
  public Moveable(int x, int y, int w, int h, ElementType type){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
  }















}
