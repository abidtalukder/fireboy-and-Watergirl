class ButtonElevatorGroup implements Displayable{
/**
A CLASS FOR REGULATING BUTTON / MOVING PLATFORM INTERACTIONS
**/

  ArrayList<Button> buttons;
  ArrayList<MovingPlatform> elevators;
  public ButtonElevatorGroup(){
    buttons = new ArrayList<Button>();
    elevators = new ArrayList<MovingPlatform>();
  }

  void add(Button b){
    buttons.add(b);
  }

  void add(MovingPlatform m){
    elevators.add(m);
  }

  void add(Object o){
    if(o instanceof Button){
      buttons.add((Button) o);
    }
    if(o instanceof MovingPlatform){
      elevators.add((MovingPlatform) o);
    }
  }

  //void update(Character one, Character two){
  //  for(Button b : buttons){
  //    b.update(one.isTouchingButton(b) || two.isTouchingButton(b));
  //  }

  //  boolean buttonPushed = false;
  //  for(Button b : buttons){
  //    buttonPushed = buttonPushed || b.isPushed; // Concatenate all buttons to determine if at least one button is pushed
  //  }
  //  for(MovingPlatform m : elevators){
  //    m.update(buttonPushed);
  //  }
  
  //}
    void update(ArrayList<Character> characters){
    boolean isTouched;
    for(Button b : buttons){
      isTouched = false;
      for(Character c : characters){
        isTouched = isTouched || c.isTouchingButton(b);
      }
      
       b.update(isTouched);
    }

    boolean buttonPushed = false;
    for(Button b : buttons){
      buttonPushed = buttonPushed || b.isPushed; // Concatenate all buttons to determine if at least one button is pushed
    }
    for(MovingPlatform m : elevators){
      m.update(buttonPushed);
    }
    for(Character Player : characters){
      // Player.collisions.add(Player.rectangleCollisions(mp1));
      for(MovingPlatform mp : elevators){
        Player.collisions.add(Player.rectangleCollisions(mp));
      }
    }
  }
  
  

  void display(){
    
    for(Button b : buttons){
      b.display();
    }
    for(MovingPlatform m : elevators){
      m.display();
    }
  }

}
