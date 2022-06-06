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

  void update(Character one, Character two){
    for(Button b : buttons){
      b.update(one.isTouchingButton(b) || two.isTouchingButton(b));
    }

    boolean buttonPushed = false;
    for(Button b : buttons){
      buttonPushed = buttonPushed || b.isPushed; // Concatenate all buttons to determine if at least one button is pushed
    }
    for(MovingPlatform m : elevators){
      m.update(buttonPushed);
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
