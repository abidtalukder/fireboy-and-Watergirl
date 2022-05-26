class Controller{
  HashSet<Integer> currentlyHeld;
  
  Platform p;
  
  public Controller(){
    currentlyHeld = new HashSet<Integer>();
    p = new Platform(80, 470, 380, 30, ElementType.DEFAULT);
  }
  void keyAdd(int Int){
    currentlyHeld.add(Int);
  }
  
  void keyRemove(int Int){
    currentlyHeld.remove(Int);
  }
  
 
}
