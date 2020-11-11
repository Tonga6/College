import static org.junit.Assert.*;

import org.junit.Test;
import java.util.ArrayList;
public class LCATest {
	@Test
    public void testLCA(){     

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

        graph.getAllParents(graph, allParentsA, graph.nodes.get(6), 0);
        graph.getAllParents(graph, allParentsB, graph.nodes.get(3), 0);

        ArrayList<ArrayList<Node>> arrLCA = new ArrayList<ArrayList<Node>>();
        graph.getLCA(arrLCA, allParentsA, allParentsB);

        ArrayList<ArrayList<Node>> ansA = new ArrayList<ArrayList<Node>>();
        ArrayList<Node> ansAEntry = new ArrayList<Node>();
        ansAEntry.add(graph.nodes.get(1));
        ansAEntry.add(graph.nodes.get(4));
        ansA.add(ansAEntry);
        assertEquals(arrLCA, ansA);
    }


}
