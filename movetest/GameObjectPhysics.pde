
import java.awt.Rectangle;

public abstract class GameObjectPhysics extends GameObject {

    // Velocity
    public float velX, velY;
    public float gravity;

    // Collision
    // Collision box / bounding rectangle for object. No rotations for now
    public Rectangle collisionBox;
    // List of all objects colliding with this one. Updates each frame
    //private LinkedList<GameObjectPhysics> collisionObjects;

    public GameObjectPhysics(float x, float y) {
        super(x,y);
        velX = 0;
        velY = 0;
        gravity = 0;
        collisionBox = new Rectangle(0,0);
    }

    @Override
    public void update() {
        velY += gravity;
        x += velX;
        y += velY;
    }
    
    // Returns collision box with actual position (where it is in WORLD not object-relative coordinates)
    public Rectangle getActualCollisionBox() {
        return new Rectangle(
            (int)x + collisionBox.x,
            (int)y + collisionBox.y,
            collisionBox.width,
            collisionBox.height);
    }

    /*public void setCollisions(LinkedList<GameObjectPhysics> collisionObjects) {
        this.collisionObjects = collisionObjects;
    }*/
    
}