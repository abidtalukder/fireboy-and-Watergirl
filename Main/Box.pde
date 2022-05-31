class Box {

  int x, y, w, h;
  float vx,vy,ax,ay = 0;
  
  boolean isOnGround = true;

  public Box(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
  }

  void display() {
    fill(204, 102, 0);
    rect(x, y, w, h);
  }
  
  void update(){
  
    y += vy;
    x += vx;
    vx += ax;
    vy += ay;
    
    checkBoundaries();
    gravity();
    
    
    
  }
  
  void gravity(){
  
  if (!isOnGround){
  ay = 0.4;
  
  } else ay = 0;
  
  }
  
  
  
  void friction(){}
  
  void checkBoundaries(){
   if(x < 0){
     x = 0;
     vx = 0;
   }

   if(x + w > width){
     x = width - w;
     vx = 0;
   }

   if(y < 0){
     y = 0;
     vy = 0;
   }

   if(y + h > height){
     y = height - h;
     vy = 0;
   }
  }
  
  boolean isTouchingButton(Button b){
      return (this.x + this.w >= b.x &&    
      this.x <= b.x + b.w &&    
      this.y + this.h >= b.y &&    
      this.y <= b.y + b.h);     
  }
  
  CollisionType rectangleCollisions(Platform p){
  
  // Rectangular collision occurs when the components distances between the centers
  // is less than the the sum of half the widths and the sum of half the heights
  
  
  // Displacements between the centers
  // Identify the center coordinates (left top translated by halfWidth, halfHeight) and subtract
  
  float dx = (this.x + this.w / 2.0) - (p.x + p.w / 2.0);
  float dy = (this.y + this.h / 2.0) - (p.y + p.h / 2.0);
  
  // The combined half dimensions are essentially component "radii"
  float combinedHalfWidths = (this.w / 2.0) + (p.w / 2.0);
  float combinedHalfHeights = (this.h / 2.0) + (p.h / 2.0);
  
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

  CollisionType rectangleCollisions(Character p){
  
  // Rectangular collision occurs when the components distances between the centers
  // is less than the the sum of half the widths and the sum of half the heights
  
  
  // Displacements between the centers
  // Identify the center coordinates (left top translated by halfWidth, halfHeight) and subtract
  
  float dx = (this.x + this.w / 2.0) - (p.x + p.w / 2.0);
  float dy = (this.y + this.h / 2.0) - (p.y + p.h / 2.0);
  
  // The combined half dimensions are essentially component "radii"
  float combinedHalfWidths = (this.w / 2.0) + (p.w / 2.0);
  float combinedHalfHeights = (this.h / 2.0) + (p.h / 2.0);
  
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
