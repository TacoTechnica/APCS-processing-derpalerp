/***********
 * GameObjectHandler.
 * Stores GameObjects, iterates through them each frame
 * to update and render
 ***********/

import java.util.LinkedList;
import java.util.ArrayList;
import java.util.ListIterator;

public class GameObjectHandler {
    // Linked list because
    // we want to add fast and we iterate each frame
    // (ArrayList gives no advantage for iterating
    // but is worse for adding)
    private LinkedList<GameObject> objects;

    // Maps object class to linkedlists of gameObjects
    private HashMap<Class, LinkedList<GameObject>> objectsByClass;

    // ArrayList of objects by tag
    // Possible because the types of tags are static
    private ArrayList<LinkedList<GameObject>> objectsByTag;

    // For physics objects with collisions
    private QuadTree collisionTree;

    public GameObjectHandler() {
        objects = new LinkedList<GameObject>();
        objectsByClass = new HashMap<Class, LinkedList<GameObject>>();
        objectsByTag = new ArrayList< LinkedList<GameObject> >();
        for(int i = 0; i < OBJECT_TAG.values().length; i++) {
            objectsByTag.add( new LinkedList<GameObject>() );
        }

        collisionTree = new QuadTree(new Rectangle(PORT_WIDTH, PORT_HEIGHT));
    }

    public void addObject(GameObject obj) {
        objects.add(obj);
    }

    // Master tick, goes through all obects
    // You control whether to update, render or do both for ALL objects
    public void loopAll(boolean update, boolean render) {

        HashMap<Class, LinkedList<GameObject>> newObjectsByClass = null;
        ArrayList<LinkedList<GameObject>> newObjectsByTag = null;

        // Create empty containers
        newObjectsByClass = new HashMap<Class, LinkedList<GameObject>>();
        newObjectsByTag = new ArrayList<LinkedList<GameObject>>();
        for(int i = 0; i < OBJECT_TAG.values().length; i++) {
            newObjectsByTag.add( new LinkedList<GameObject>() );
        }

        // Create LinkedList storing collision objects ONLY to prevent redundant scrolling
        //LinkedList<GameObjectPhysics> allCollisionObjects = new LinkedList<GameObjectPhysics>();
        // Reset collision quadtree
        collisionTree.clear();

        // Loop through once to add objects to collision tree
        for( GameObject obj : objects ) {
            if (obj instanceof GameObjectPhysics) {
                collisionTree.insert( (GameObjectPhysics) obj );
            }
        }

        ListIterator<GameObject> iter = objects.listIterator();
        while(iter.hasNext()) {
           GameObject obj = iter.next();
           // If should destroy, destroy
           // and skip this one
           if (obj.shouldDestroy()) {
               iter.remove();
               continue;
           }
           if (update) {
               // Add to lists mapping by class and tag
               Class objClass = obj.getClass();
               int tag = obj.tag.ordinal();

               if (!newObjectsByClass.containsKey(objClass)) {
                   newObjectsByClass.put( objClass, new LinkedList<GameObject>() );
               }
               newObjectsByClass.get(objClass).add(obj); 

               if (newObjectsByTag.get(tag) == null) {
                   newObjectsByTag.set( tag, new LinkedList<GameObject>() );
               }
               newObjectsByTag.get(tag).add(obj);

               // ALso update
               obj.update();
           }
           if (render) {
               if (obj.visible) {
                   obj.render();
               }
           }
        }

        // Iterate AGAIN to do collisions
        /*ListIterator<GameObjectPhysics> phyIter = allCollisionObjects.listIterator();
        while(phyIter.hasNext()) {
            GameObjectPhysics obj = phyIter.next();
            LinkedList<GameObjectPhysics> retreived = collisionTree.retreive
        }*/
        
        
        if (update) {
            // update objectsByClass Map
            objectsByClass = newObjectsByClass;
            objectsByTag = newObjectsByTag;
        }
    }

    // Get list of objects by class
    public LinkedList<GameObject> getObjectsByClass(Class findClass) {
        if (objectsByClass.containsKey(findClass)) {
            return objectsByClass.get(findClass); 
        } else {
            return null; 
        }
    }

    // Get list of objects by tag
    public LinkedList<GameObject> getObjectsByTag(OBJECT_TAG tag) {
        int index = tag.ordinal();
        if (objectsByTag.size() <= index) {
            return null;
        }
        return objectsByTag.get(index);
    }

    // Collision function wrapper
    public LinkedList<GameObjectPhysics> getCollisions(GameObjectPhysics obj, float offsetX, float offsetY) {
        return collisionTree.getCollisions( obj, offsetX, offsetY );
    }
}