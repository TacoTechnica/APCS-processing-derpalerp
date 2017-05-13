/*******************************
 * MASTA CLASS
 *
 * ALL PROCESSING SPECIFIC FUNCTIONS GO HERE
 * avoid using processing functions (setup, draw, ect) anywhere else
 *******************************/

// Universal Objects
Main main;
Camera camera;
GameObjectHandler handler;


final int PORT_WIDTH = 640;
final int PORT_HEIGHT = 480;

void setup() {
    // We use surface.setSize(w,h) and not "size(w,h)" because this can accept variables
    // and proccessing's "special" method for some reason is MAGIC
    // and refuses to use variables.
    // Screw that I say!
    surface.setSize(PORT_WIDTH, PORT_HEIGHT);
    main = new Main();
    camera = new Camera();
    main.initialize();
    handler = main.handler;
}

void draw() {
    // Translate to camera

    camera.viewAngle = millis() / 10000f;

    scale( PORT_WIDTH / camera.viewWidth, PORT_HEIGHT / camera.viewHeight );
    translate(camera.viewWidth/2, camera.viewHeight/2);
    rotate( camera.viewAngle);
    translate(-camera.viewWidth/2, -camera.viewHeight/2);
    translate(-camera.xPos, -camera.yPos);

    // Draw border to make rotation visible
    stroke(255);
    fill(0);
    rect(0,0,PORT_WIDTH, PORT_HEIGHT);
    

    main.update(); 
    // Undo camera translation
    //translate(camera.xPos, camera.yPos);
}

void keyPressed() {
    Input.updateKeyPress(keyCode, true);
}
void keyReleased() {
    Input.updateKeyPress(keyCode, false);
}