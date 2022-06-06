class MovingPlatform implements Displayable{
  int initialY, t, yDisp, numIterations;
  Rectangle Hitbox;
  public MovingPlatform(int x, int y, int w, int h, int yDisp){
    Hitbox = new Rectangle(x, y, w, h);
    this.initialY = y;
    this.yDisp = yDisp;
    t = 0;
    numIterations = 30;
  }
  
  
   void update(boolean isPushed){
    
    if(isPushed){
      if(t != numIterations){
        t += 1;
      }
    }
    else if(t > 0){
       t -= 1;
    }
    Hitbox.y = initialY + ((t * yDisp) / (numIterations));
  }
  
  void display(){
    fill(124);
    Hitbox.y = initialY + ((t * yDisp) / (numIterations));
    Hitbox.display();
  }
  
}
