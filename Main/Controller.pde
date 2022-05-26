class Controller{
  HashSet<Integer> currentlyHeld;
  
  public Controller(){
    currentlyHeld = new HashSet<Integer>();
  }
  
  void keyAdd(int Int){
    currentlyHeld.add(Int);
  }
  
  void keyRemove(int Int){
    currentlyHeld.remove(Int);
  }
  
 
}
