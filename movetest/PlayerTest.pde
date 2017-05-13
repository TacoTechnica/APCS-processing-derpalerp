/***************
 * PlayerTest
 * Test for player using GameObject inheritance.
 **************/

public class PlayerTest extends GameObjectPhysics {

    public PlayerTest() {
        super(100,100);
        collisionBox = new Rectangle(10, 10);
    }

    @Override
    public void update() {
        super.update();

        float spd = 0.3f;

        int axisX = (Input.keyPress( RIGHT ) ? 1 : 0) + (Input.keyPress( LEFT ) ? -1 : 0);
        int axisY = (Input.keyPress( DOWN ) ? 1 : 0) + (Input.keyPress( UP ) ? -1 : 0);

        velX += axisX * spd;
        velY += axisY * spd;

        velX *= 0.9;
        velY *= 0.9;

    }

    @Override
    public void render() {
        fill(255);
        rect(x, y, collisionBox.width, collisionBox.height);
    }
}