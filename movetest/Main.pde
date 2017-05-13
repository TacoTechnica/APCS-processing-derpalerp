/*******************************
 * Main Class
 *
 *******************************/

public class Main {


    public GameObjectHandler handler;

    public void initialize() {
        handler = new GameObjectHandler();
        //handler.addObject( new PlayerTest() );

        /*handler.addObject( new CollisionTest( 30, 30 ) );
        handler.addObject( new CollisionTest( 90, 30 ) );
        handler.addObject( new CollisionTest( 30, 90 ) );
        */
        for(int xx = 0; xx < 40; xx+=4) {
            for(int yy = 0; yy < 40; yy+=4) {
                handler.addObject( new CollisionTest(xx * 20, yy * 20) );
            }
        }
    }

    public void update() {

        background(0);

        handler.loopAll(true, true);
        Input.updatePostTick();
    }

}