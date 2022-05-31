class Box {

  int x, y, w, h;
  float vx, vy, ax, ay = 0;
  float g = 0.4; // Gravitational constant
  float friction = 0.7; // Friction constant
  float speedLimit = 3; // Speed Limit

  boolean isOnGround = true;
  HashSet<CollisionType> collisions = new HashSet<CollisionType>();

  boolean fire, water = false;

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

  void checkCollisions() {

    collisions.clear();

    CollisionType f = rectangleCollisions(Fireboy);
    CollisionType w = rectangleCollisions(Watergirl);

    if (f != CollisionType.None) {
      fire = true;
      collisions.add(f);
    }
    if (w != CollisionType.None) {
      water = true;
      collisions.add(w);
    }
  }

  void update() {
    //System.out.println(rectangleCollisions(Fireboy));

    //y += vy;
    //x += vx;
    //vx += ax;
    //vy += ay;

    //checkBoundaries();
    //gravity();

    if (y + h >= height || collisions.contains(CollisionType.Bottom)) {
      ay -= g; // Normal force cancels out gravity force
      vy = 0;
    }
    
    checkCollisions();
    collisionMovement();


    friction = 1;
    if (collisions.size() == 0) {
      friction = 0.95;
    }
    vx += ax;
    vy += ay;

    vx *= friction;
    if (Math.abs(vx) < 0.2) {
      vx  = 0;
    }

    if (Math.abs(vx) >= speedLimit) {
      vx = Math.signum(vx) * speedLimit;
    }

    x += vx;
    y += vy;

    checkBoundaries();
  }

  void gravity() {

    if (!isOnGround) {
      ay = 0.4;
    } else ay = 0;
  }
  
  
  void collisionMovement() {
    
  if (water && !fire) {

      if (collisions.contains(CollisionType.Left) || collisions.contains(CollisionType.Right)) {

        vx = Watergirl.vx;
      }
    } else if (fire && !water) {

      if (collisions.contains(CollisionType.Left) || collisions.contains(CollisionType.Right)) {

        vx = Fireboy.vx;
      }
    } else if (fire && water) {

      if (collisions.contains(CollisionType.Left) && collisions.contains(CollisionType.Right)) {

        vx = Fireboy.vx - Watergirl.vx;
      } else if (collisions.contains(CollisionType.Right) && !collisions.contains(CollisionType.Left) && collisions.contains(CollisionType.Top) && collisions.contains(CollisionType.Bottom)) {

        vx = Fireboy.vx + Watergirl.vx;
      } else if (collisions.contains(CollisionType.Left) && !collisions.contains(CollisionType.Right) && collisions.contains(CollisionType.Top) && collisions.contains(CollisionType.Bottom)) {

        vx = Fireboy.vx + Watergirl.vx;
      }
    } else {

      vx *= 0.95;
    }
  
  }





  void checkBoundaries() {
    if (x < 0) {
      x = 0;
      vx = 0;
    }

    if (x + w > width) {
      x = width - w;
      vx = 0;
    }

    if (y < 0) {
      y = 0;
      vy = 0;
    }

    if (y + h > height) {
      y = height - h;
      vy = 0;
    }
  }

  boolean isTouchingButton(Button b) {
    return (this.x + this.w >= b.x &&    
      this.x <= b.x + b.w &&    
      this.y + this.h >= b.y &&    
      this.y <= b.y + b.h);
  }

  CollisionType rectangleCollisions(Platform p) {

    // Rectangular collision occurs when the components distances between the centers
    // is less than the the sum of half the widths and the sum of half the heights


    // Displacements between the centers
    // Identify the center coordinates (left top translated by halfWidth, halfHeight) and subtract

    float dx = (this.x + this.w / 2.0) - (p.x + p.w / 2.0);
    float dy = (this.y + this.h / 2.0) - (p.y + p.h / 2.0);

    // The combined half dimensions are essentially component "radii"
    float combinedHalfWidths = (this.w / 2.0) + (p.w / 2.0);
    float combinedHalfHeights = (this.h / 2.0) + (p.h / 2.0);

    if (abs(dx) < combinedHalfWidths && abs(dy) < combinedHalfHeights) {
      // Overlap is "signed" here (positive / negative) for simplicity
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      if (overlapX >= overlapY) {
        if (dy > 0) {
          this.y += overlapY;
          return CollisionType.Top;
        }

        this.y -= overlapY;
        return CollisionType.Bottom;
      }

      if (dx > 0) {
        this.x += overlapX;
        return CollisionType.Right;
      }
      this.x -= overlapX;
      return CollisionType.Left;
    }
    return CollisionType.None;
  }

  CollisionType rectangleCollisions(Character p) {

    // Rectangular collision occurs when the components distances between the centers
    // is less than the the sum of half the widths and the sum of half the heights


    // Displacements between the centers
    // Identify the center coordinates (left top translated by halfWidth, halfHeight) and subtract

    float dx = (this.x + this.w / 2.0) - (p.x + p.w / 2.0);
    float dy = (this.y + this.h / 2.0) - (p.y + p.h / 2.0);

    // The combined half dimensions are essentially component "radii"
    float combinedHalfWidths = (this.w / 2.0) + (p.w / 2.0);
    float combinedHalfHeights = (this.h / 2.0) + (p.h / 2.0);

    if (abs(dx) < combinedHalfWidths && abs(dy) < combinedHalfHeights) {
      // Overlap is "signed" here (positive / negative) for simplicity
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      if (overlapX >= overlapY) {
        if (dy > 0) {
          this.y += overlapY;
          return CollisionType.Top;
        }

        this.y -= overlapY;
        return CollisionType.Bottom;
      }

      if (dx > 0) {
        this.x += overlapX;
        return CollisionType.Right;
      }
      this.x -= overlapX;
      return CollisionType.Left;
    }
    return CollisionType.None;
  }
}
