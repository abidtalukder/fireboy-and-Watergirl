public class Rectangle{
  int x, y, w, h;
  public Rectangle(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void display(){
    rect(x, y, w, h);
  }
  boolean isTouching(Rectangle r){
      return (this.x + this.w >= r.x &&    
      this.x <= r.x + r.w &&    
      this.y + this.h >= r.y &&    
      this.y <= r.y + r.h);     
  }
  
  CollisionType rectangleCollisions(Rectangle r){
  
  // Rectangular collision occurs when the components distances between the centers
  // is less than the the sum of half the widths and the sum of half the heights
  
  
  // Displacements between the centers
  // Identify the center coordinates (left top translated by halfWidth, halfHeight) and subtract
  
  float dx = (this.x + this.w / 2.0) - (r.x + r.w / 2.0);
  float dy = (this.y + this.h / 2.0) - (r.y + r.h / 2.0);
  
  // The combined half dimensions are essentially component "radii"
  float combinedHalfWidths = (this.w / 2.0) + (r.w / 2.0);
  float combinedHalfHeights = (this.h / 2.0) + (r.h / 2.0);
  
  if(abs(dx) < combinedHalfWidths && abs(dy) < combinedHalfHeights){
    // Overlap is "signed" here (positive / negative) for simplicity
    float overlapX = combinedHalfWidths - abs(dx);
    float overlapY = combinedHalfHeights - abs(dy);
    if(overlapX >= overlapY){
      if(dy > 0){
        this.y += overlapY;
        return CollisionType.Top;
      }
      
      this.y -= overlapY;
      return CollisionType.Bottom;
    }
    
    if(dx > 0){
      this.x += overlapX;
      return CollisionType.Right;
    }
    this.x -= overlapX;
    return CollisionType.Left;
    
  }
  return CollisionType.None;
}
}
