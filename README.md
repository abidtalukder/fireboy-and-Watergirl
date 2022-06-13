# fireboy-and-Watergirl

Our game is a remake version of fireboy and watergirl along with other added features such as having enemies and portals that generate enemies for the user.

# Compile and Runtime instructions

Running this project has been made a simple process for the user. The following details that the steps that are necessary:

1. Open and clone the repo
2. Open the sketch folder in processing
3. Press the play button
4. You have to beat one level in order to get to the next level.
5. GIT GUD

# Abid Talukder Dev Logs

May 24, 2022 - Abid Branch
I worked on making the Moveable class skeleton, which is the super class of Platform.

May 30, 2022 - Abid-1
I created an extension of Vansh's branch, and I made the methods for box. This includes seeing if box touches player, if box touches buttons, checkingboundaries, adjusting speed, and moving around the map. Basically the physics, constructors, and main requirements for box.

May 31, 2022 - Abid-1

I had extra features for players interacting with boxes so that boxes move when they collide with players, and that players can stand on boxes. I created the elevator class, and made it move up and down.

Jun 1, 2022 - Abid-1

I worked on the Moveable class so that it was a true superclass to Character. It held features for colliding with other interactable objects in the game. I started the enemy class and made methods for its constructors, display, and movement.

Jun 2, 2022 - Abid-1

I focused on some bug fixes for enemies that allowed them to properly jump over boxes, and reset the game if players touched them. Players bounce and kill enemies when they step on top of them.

Jun 3, 2022 - Abid-1

I put a method for characters to detect collisions with enemies.

Jun 7, 2022 - Abid-1

I created the map and MapContainer class, which would arrange the screen into a grid where different objects could be placed. I fixed an issue where characters couldn't stand on boxes.

# Vansh Saboo Dev Logs

May 23

I created the Character and Platform classes, as well as "Element" enums to distinguish between different 'elemental' objects

May 24

- I updated Character to involve movement
- I deleted setDirections in order to try and merge with the main Branch
- I created "Action" enums for distinguishing Character movement. I also made HashMaps in order to map the current keys pressed to the action enums, which would be stored in each of the characters.

May 25

- Implemented acceleration and a hashset of 'currentlyHeld' keys for Character. Made a currActions() method that would do the work of mapping keys to actions. Also fixed update to have velocity / acceleration.
- (Second commit was a mistake, the commit didn't properly account for the changes)
- Added gravity, speed limits, friction, and a jumpConstant (jump "force") for smoother movement (instead of just velocity w/out acceleration and friction)
- (Fourth commit was made at the end of class and I was trying out how to work with text files)
- Made a reset that would register when a user presses "r"
- Made a checkBoundaries() method that would keep the players within the grid, and worked on update()
- Switched keys Pressed to account for the Integer keyCodes instead of the String / char keyCodes, so that it would be easier to implement Fireboy's movement type with the arrow keys


May 26:
- Made a controller class for storing the keys pressed (instead of in main). Tried making a Rectangle to avoid repetitive code in the future
- I implemented rectangleCollisions for determining relative direction of the platforms that the Character is interacting with

May 27:
- Transferred collisions from Main to Character, and updated / fixed code so that the Character could properly interact with platforms
- Created the first level through an array list of Platforms, and created the corresponding collisions


May 28:
- I made doors, and had them open in a 'smooth' way by incrementing or decrementing its 'time' depending on whether a corresponding Player was touching it or not
- Cleaned up the code, added more platforms and doors

May 30:
- I made buttons that would enable elevator movement, and made some work on MovingPlatform (elevators)
- Deleted checkBoundaries because the Player would never be touching the outer border anyhow due to Platforms
