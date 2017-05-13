/***********
 * Central GameObject class.
 * Has position, basic rendering and is abstract
 * For every single physial object in the game.
 ***********/

// DEFINE ALL TAGS HERE
public static enum OBJECT_TAG {
    Default
}

public abstract class GameObject {
  
    public float x, y;
    
    public OBJECT_TAG tag = OBJECT_TAG.Default;

    // Marker for whether object should be destroyed
    // Destroyed in loop
    private boolean destroy;

    // Don't call render() if "visible" is false
    public boolean visible = true; 

    public GameObject(float x, float y) {
       this.x = x;
       this.y = y;
    }

    // All physics and math is done here
    public abstract void update();

    // All rendering is done here
    public abstract void render();
    
    // Mark object to destroy before next tick
    public void destroy() {
        destroy = true;
    }

    // Returns whether object is marked for destroy
    public boolean shouldDestroy() {
       return destroy; 
    }
}