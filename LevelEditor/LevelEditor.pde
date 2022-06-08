import java.util.ArrayList;
import java.util.Arrays;
ArrayList<Integer[]> rectangles;
Integer[] currRect;
boolean isCurrRect;
void setup(){
  size(500, 500);
  background(255);
  rectangles = new ArrayList<Integer[]>();
}

void draw(){
  background(255);
  fill(186, 135, 89);
  noStroke();
  for(Integer[] rectangle : rectangles){
    rect(rectangle[0], rectangle[1], rectangle[2], rectangle[3]);
  }
  if(isCurrRect){
    rect(currRect[0], currRect[1], mouseX - currRect[0], mouseY - currRect[1]);
  }  
}

void mousePressed(){
  currRect = new Integer[4];
  currRect[0] = mouseX;
  currRect[1] = mouseY;
  isCurrRect = true;
}

void mouseReleased(){
  currRect[2] = mouseX - currRect[0];
  currRect[3] = mouseY - currRect[1];
  rectangles.add(currRect);
  isCurrRect = false;
}

void keyPressed(){
  switch(key){
    case('z'):
      rectangles.remove(rectangles.size() - 1);
      break;
    case('p'): 
      for(Integer[] r : rectangles){
         print(Arrays.toString(r) + '\n');
      }
  }
}
