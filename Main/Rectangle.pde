class Rectangle{
  int x, y, w, h;
  public Rectangle(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
 
  
  // http://www.jeffreythompson.org/collision-detection/rect-rect.php
  boolean collidesWithRect(Rectangle other){
    return(this.x + this.w >= other.x &&
           this.x <= other.x + other.w &&
           this.y + this.h >= other.y &&
           this.y <= other.y + other.h);    
  } 
  
  
}
