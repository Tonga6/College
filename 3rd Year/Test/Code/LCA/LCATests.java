import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.Test;

public class LCATests {
    
    @Test
    public void testLCA(){
        LCA tree = new LCA();

        tree.root = new Node(1); 
        tree.root.left = new Node(2); 
        tree.root.right = new Node(3); 
        tree.root.left.left = new Node(4); 
        tree.root.left.right = new Node(5); 
        tree.root.right.left = new Node(6); 
        tree.root.right.right = new Node(7); 

        assertEquals(2, tree.findLCA(4,5));
        assertEquals(1, tree.findLCA(4,6)); 
    }

    @Test
    public void testLCABadEntry(){
        LCA tree = new LCA();

        tree.root = new Node(1); 
        tree.root.left = new Node(2); 
        tree.root.right = new Node(3); 
        tree.root.left.left = new Node(4); 
        tree.root.left.right = new Node(5); 
        tree.root.right.left = new Node(6); 
        tree.root.right.right = new Node(7); 

        assertEquals(-1, tree.findLCA(0,7));
    }
    
    
}
