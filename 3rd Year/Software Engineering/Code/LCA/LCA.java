//Test lines added for git testing

// Finds for Lowest Common Ancestor in a Binary Tree 
// A O(n) solution to find LCA of two given values n1 and n2 
import java.util.ArrayList; 
import java.util.List; 
  
// A Binary Tree node 
class Node { 
    int data; 
    ArrayList<Node> children = new ArrayList<Node>();
    ArrayList<Node> parents = new ArrayList<Node>();  
  
    Node(int value) { 
        data = value; 
         
    } 
} 
  
public class LCA  
{   
    private ArrayList<Node> nodes = new ArrayList<Node>(); 
    
    public static void main(String[] args) 
    { 
        LCA graph = new LCA();
        for(int i = 0;i < 10; i++){ //create graph with 10 nodes
          graph.nodes.add(i,new Node(i+1));
          //System.out.println(graph.nodes.get(i).data); 
        }
        
        
        
        // tree.root = new Node(1); 
        // tree.root.left = new Node(2); 
        // tree.root.right = new Node(3); 
        // tree.root.left.left = new Node(4); 
        // tree.root.left.right = new Node(5); 
        // tree.root.right.left = new Node(6); 
        // tree.root.right.right = new Node(7); 
   
    }  
  
    // // Finds the path from root node to given root of the tree. 
    // int findLCA(int n1, int n2) { 
    //     pathA.clear(); 
    //     pathB.clear(); 
    //     return findLCAInternal(root, n1, n2); 
    // } 
  
    // private int findLCAInternal(Node root, int n1, int n2) { 
  
    //     if (!findPath(root, n1, pathA) || !findPath(root, n2, pathB)) { 
    //         System.out.println((pathA.size() > 0) ? "n1 is present" : "n1 is missing"); 
    //         System.out.println((pathB.size() > 0) ? "n2 is present" : "n2 is missing"); 
    //         return -1; 
    //     } 
  
    //     int i; 
    //     for (i = 0; i < pathA.size() && i < pathB.size(); i++) { 
    //         if (!pathA.get(i).equals(pathB.get(i))) 
    //             break; 
    //     }   
    //     return pathA.get(i-1); 
    // } 
      
    // // Finds the path from root node to given root of the tree, Stores the 
    // // path in a vector path[], returns true if path exists otherwise false 
    // private boolean findPath(Node root, int n, List<Integer> path) 
    // { 
    //     // base case 
    //     if (root == null) { 
    //         return false; 
    //     } 
          
    //     // Store this node . The node will be removed if 
    //     // not in path from root to n. 
    //     path.add(root.data); 
  
    //     if (root.data == n) { 
    //         return true; 
    //     }   
    //     if (root.left != null && findPath(root.left, n, path)) { 
    //         return true; 
    //     }   
    //     if (root.right != null && findPath(root.right, n, path)) { 
    //         return true; 
    //     } 
  
    //     // If not present in subtree rooted with root, remove root from 
    //     // path[] and return false 
    //     path.remove(path.size()-1);   
    //     return false; 
    // }     
} 