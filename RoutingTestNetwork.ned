//
// This network consists of 4 nodes, one path will have a higher total delay
// Message should travel along the shortest path (shortest delay)
// The component/simple module/node used here is RoutingNode
//

network RoutingTestNetwork
{
    @display("bgb=488,357");
    submodules:
        node1: RoutingNode {
            address = 1;
            @display("p=101,222");
        }
        node2: RoutingNode {
            address = 2;
            @display("p=185,78");
        }
        node3: RoutingNode {
            address = 3;
            @display("p=261,198");
        }
        node4: RoutingNode {
            address = 4;
            @display("p=350,78");
        }
    connections:
        node1.gate++ <--> {  delay = 100ms; } <--> node2.gate++;
        node1.gate++ <--> {  delay = 100ms; } <--> node3.gate++;

        node2.gate++ <--> {  delay = 100ms; } <--> node4.gate++;
        node3.gate++ <--> {  delay = 200ms; } <--> node4.gate++;
}


