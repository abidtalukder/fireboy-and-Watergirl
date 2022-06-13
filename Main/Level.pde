class Level{
    ArrayList<ButtonElevatorGroup> buttonGroups = new ArrayList<ButtonElevatorGroup>();
    ArrayList<Character> characters = new ArrayList<Character>();
    ArrayList<Door> doors = new ArrayList<Door>();
    ArrayList<Gem> gems = new ArrayList<Gem>();
    ArrayList<Platform> platforms = new ArrayList<Platform>();
    boolean hasWon = false;

    public Level(String[] tokens, Controller controller){
        String[] objTokens;
        for(int i = 0; i < tokens.length; i++){
            objTokens = split(tokens[i], " ");
            if(objTokens[0].equals("Character")){
                int x = new Integer(objTokens[1]);
                int y = new Integer(objTokens[2]);
                HashMap<Integer, Action> map = new HashMap<Integer, Action>();
                if(objTokens[3].equals("FIRE")){
                    map.put(KeyEvent.VK_UP, Action.Up);
                    map.put(KeyEvent.VK_LEFT, Action.Left);
                    map.put(KeyEvent.VK_RIGHT, Action.Right);
                    characters.add(new Character(x, y, ElementType.FIRE, map, controller));
                }
                if(objTokens[3].equals("WATER")){
                map.put(KeyEvent.VK_W, Action.Up);
                map.put(KeyEvent.VK_A, Action.Left);
                map.put(KeyEvent.VK_D, Action.Right);
                characters.add(new Character(x, y, ElementType.WATER, map, controller));
                }

            }

            if(objTokens[0].equals("Platform")){
                ElementType type = ElementType.DEFAULT;
                if(objTokens[5].equals("DEFAULT")){
                type = ElementType.DEFAULT;
                }
                if(objTokens[5].equals("FIRE")){
                type = ElementType.FIRE;
                }
                if(objTokens[5].equals("WATER")){
                type = ElementType.WATER;
                }
                if(objTokens[5].equals("POISON")){
                type = ElementType.POISON;
                }
                int x = new Integer(objTokens[1]);
                int y = new Integer(objTokens[2]);
                int w = new Integer(objTokens[3]);
                int h = new Integer(objTokens[4]);
                platforms.add(new Platform(x, y, w, h, type));
            }

            if(objTokens[0].equals("Gem")){
                ElementType type = ElementType.FIRE;
                if(objTokens[5].equals("FIRE")){
                type = ElementType.FIRE;
                }
                if(objTokens[5].equals("WATER")){
                type = ElementType.WATER;
                }
                int x = new Integer(objTokens[1]);
                int y = new Integer(objTokens[2]);
                int w = new Integer(objTokens[3]);
                int h = new Integer(objTokens[4]);
                gems.add(new Gem(x, y, w, h, type));
            }

            if(objTokens[0].equals("Door")){

                ElementType type = ElementType.FIRE;
                if(objTokens[5].equals("FIRE")){
                type = ElementType.FIRE;
                }
                if(objTokens[5].equals("WATER")){
                type = ElementType.WATER;
                }
                int x = new Integer(objTokens[1]);
                int y = new Integer(objTokens[2]);
                int w = new Integer(objTokens[3]);
                int h = new Integer(objTokens[4]);
                doors.add(new Door(x, y, w, h, type));
            }
            if(objTokens[0].equals("BUTTONGROUP")){
                ButtonElevatorGroup b = new ButtonElevatorGroup();
                i++;
                objTokens = split(tokens[i], " ");
                while(objTokens.length > 1){
                if(objTokens[0].equals("Button")){
                    int x = new Integer(objTokens[1]);
                    int y = new Integer(objTokens[2]);
                    int w = new Integer(objTokens[3]);
                    int h = new Integer(objTokens[4]);
                    b.add(new Button(x, y, w, h));
                }

                if(objTokens[0].equals("MovingPlatform")){
                    int x = new Integer(objTokens[1]);
                    int y = new Integer(objTokens[2]);
                    int w = new Integer(objTokens[3]);
                    int h = new Integer(objTokens[4]);
                    int yDisp = new Integer(objTokens[5]);
                    b.add(new MovingPlatform(x, y, w, h, yDisp));
                }

                i++;
                if(i < tokens.length){
                  objTokens = split(tokens[i], " ");
                }
                }
                buttonGroups.add(b);
            }
        }   
    }
    
    void characterCollisions(){
        // PLATFORMS //

        for(Platform p : platforms){
            for(Character Player : characters){
                CollisionType collision = Player.rectangleCollisions(p);
                if(collision != CollisionType.None){
                if((Player.type == ElementType.FIRE && p.type == ElementType.WATER) || (Player.type == ElementType.WATER && p.type == ElementType.FIRE) || p.type == ElementType.POISON){
                    reset();
                }
            }
                Player.collisions.add(collision);
            }
        }

        // GEMS //
        Gem removed = null;
        for(Gem g : gems){
          for(Character Player : characters){  
            if(Player.type == g.type && Player.isTouchingGem(g)){
                 removed = g; // This is to avoid ConcurrentModificationException (by deleting stuff in the collection while you're iterating through it)
            }
          }
        }
        if(removed != null){
            gems.remove(removed);
        }

        // BUTTONS / ELEVATORS //
        for(ButtonElevatorGroup bGroup : buttonGroups){
            bGroup.update(characters);
        }

        // DOORS //
        for(Door d : doors){
          d.update(characters);
        }
      for(Character Player : characters){
        Player.update();
      }
    }

    void update(){
        characterCollisions();
        for(Character c : characters){
            c.resetCollisions();
        }
        boolean haveWonTemp = false;
        for(Door d : doors){
            haveWonTemp = haveWonTemp || d.isOpen;
        }
        haveWon = haveWonTemp;
    }
    void display(){
        for(ButtonElevatorGroup b : buttonGroups){
            b.display();
        }
        for(Character c : characters){
            c.display();
        }
        for(Door d : doors){
            d.display();
        }
        for(Gem g : gems){
            g.display();
        }
        for(Platform p : platforms){
            p.display();
        }

    }
    
    public boolean getWinState(){
      return hasWon;
    }


}
