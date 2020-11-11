import java.util.ArrayList;
  
// A DAG node
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
    ArrayList<Node> nodes = new ArrayList<Node>(); 
  
    static void getAllParents (LCA graph, ArrayList<ArrayList<Node>> allParents, Node node, int depth){
         
        if (!node.parents.isEmpty()){                                                
                    
            if (allParents.size() <= depth){    //if size <= depth, following entry is the fist entry at index depth  
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
} 
