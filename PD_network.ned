// Describing network here
// Use seperate .ned files for each network for better reference and organisation

network PD_network
{
    @display("bgb=399,258");
    submodules:
        node1: PD_node {
            @display("p=72,51");
        }
        node2: PD_node {
            @display("p=286,178");
        }
        node3: PD_node {
            @display("p=286,51");
        }
    connections:
        node1.gate++ <--> {  delay = 100ms; } <--> node2.gate++;
        node1.gate++ <--> {  delay = 100ms; } <--> node3.gate++;
        node2.gate++ <--> {  delay = 100ms; } <--> node3.gate++;
}
