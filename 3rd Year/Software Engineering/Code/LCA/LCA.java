//Test lines added for git testing

// Finds for Lowest Common Ancestor in a Binary Tree 
// A O(n) solution to find LCA of two given values n1 and n2 
import java.util.ArrayList;
import java.util.Iterator;
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
        for(int i = 0;i < 7; i++){ //create graph with 6 nodes
          graph.nodes.add(i,new Node(i+1));
           
        }
        graph.nodes.get(0).children.add(0,graph.nodes.get(1));
        graph.nodes.get(0).children.add(1,graph.nodes.get(2));
        graph.nodes.get(0).children.add(2,graph.nodes.get(4));
        graph.nodes.get(0).children.add(3,graph.nodes.get(5));

        graph.nodes.get(1).parents.add(0,graph.nodes.get(0));
        graph.nodes.get(1).children.add(0,graph.nodes.get(3));
        graph.nodes.get(1).children.add(1,graph.nodes.get(6));

        graph.nodes.get(2).parents.add(0,graph.nodes.get(0));
        graph.nodes.get(2).children.add(0,graph.nodes.get(3));

        graph.nodes.get(3).parents.add(0,graph.nodes.get(1));
        graph.nodes.get(3).parents.add(1,graph.nodes.get(2));
        graph.nodes.get(3).parents.add(2,graph.nodes.get(4));
        graph.nodes.get(3).children.add(0,graph.nodes.get(6));

        graph.nodes.get(4).parents.add(0,graph.nodes.get(0));
        graph.nodes.get(4).children.add(0,graph.nodes.get(4));
        graph.nodes.get(4).children.add(1,graph.nodes.get(6));

        graph.nodes.get(5).parents.add(0,graph.nodes.get(0));

        graph.nodes.get(6).parents.add(0,graph.nodes.get(1));
        graph.nodes.get(6).parents.add(1,graph.nodes.get(3));
        graph.nodes.get(6).parents.add(2,graph.nodes.get(4));
    
        ArrayList<ArrayList<Node>> allParentsA = new ArrayList<ArrayList<Node>>();
        ArrayList<ArrayList<Node>> allParentsB = new ArrayList<ArrayList<Node>>();
        getAllParents(graph, allParentsA, graph.nodes.get(6), 0);
        getAllParents(graph, allParentsB, graph.nodes.get(3), 0);
        ArrayList<ArrayList<Node>> arrLCA = new ArrayList<ArrayList<Node>>();
        getLCA(arrLCA, allParentsA, allParentsB);
        System.out.println("End");
    }  
  
    static void getAllParents (LCA graph, ArrayList<ArrayList<Node>> allParents, Node node, int depth){
         
        if (!node.parents.isEmpty()){                                                
                    
            if (allParents.size() <= depth){    //if size <= depth, following entry is the fist entry at index depth  
                //allParents.add(node.parents);     .add puts a pointer to the array, so editing allParents[i] also affects the first node added
                allParents.add((ArrayList<Node>)node.parents.clone());
            }    
            else{
                if (allParents.get(depth) != null)  //if != null can use .addAll
                    allParents.get(depth).addAll(node.parents); //Add parents to existing array of parents at this depth 

                else    
                    allParents.add(depth, node.parents);    //else use add(ind,elem) 
                }
        }
        else if (allParents.size() < depth)
            allParents.add(null);    // no parents to add

        for (int i = 0; i < node.parents.size(); i++){
             getAllParents(graph, allParents, node.parents.get(i), depth+1);
         }
    }
    
    static void getLCA (ArrayList<ArrayList<Node>> arrayLCA, ArrayList<ArrayList<Node>> allParentsA, ArrayList<ArrayList<Node>> allParentsB){

        int minLCADepth = -1;
        for(int i =0; (minLCADepth == -1 || i < minLCADepth) && allParentsA.size() > i;i++ ){
            for (int j =0; (minLCADepth == -1 || j < minLCADepth) && allParentsB.size() > j;j++){
                allParentsA.get(i).retainAll(allParentsB.get(j));
                if (!allParentsA.get(i).isEmpty()/* && Math.max(i,j) maxLCADepth */)
                    arrayLCA.add(0,allParentsA.get(i));
                    minLCADepth = Math.max(i,j);    //new min LCA to beat or join
            }
            
        }
         
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
