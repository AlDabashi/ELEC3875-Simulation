// 3 Node simulation of the UK's BT fibre core network.
// Al Husien Dabashi, 06/02/2019

// Building nodes 1, 2 and 6 from Figure 3 in "A stabilising control strategy for
// Cyber-Physical Power Systems"

// Nodes:
// 1 - Manchester
// 2 - Leeds
// 6 - City of London

simple innerNode
{
    parameters:
        @display("i=block/routing"); // add the icon with 4 arrows pointing inwards
        
    gates:
        input in[]; // "[]" turns the gates into gate vectors
        output out[];
}

simple innerNode2 // this module has bidirectional connections, "innerNode" does not.
{ 
    parameters:
        @display("i=block/routing"); // add the icon with 4 arrows pointing inwards
        
    gates:
            inout gate[]; // declaring bi-directional connection
}

simple innerNode3 // this module has bidirectional connections, "innerNode" does not.
{ 
    parameters:
        @display("i=block/routing"); // add the icon with 4 arrows pointing inwards
        
    gates:
            inout gate[]; // declaring bi-directional connection
}

network SimpleBTFibreNetwork
{
    @display("bgb=397,399");
    submodules:
        Manchester: innerNode {
            @display("p=84,202");
        }
        Leeds: innerNode {
            @display("p=255,91");
        }
        London: innerNode {
            @display("p=275,292");
        }
        
    connections:
        Manchester.out++ --> {  delay = 100ms; } --> Leeds.in++;
        Manchester.out++ --> {  delay = 100ms; } --> London.in++;
        
        Leeds.out++ --> {  delay = 100ms; } --> Manchester.in++;
        Leeds.out++ --> {  delay = 100ms; } --> London.in++;
        
        London.out++ --> {  delay = 100ms; } --> Manchester.in++;
        London.out++ --> {  delay = 100ms; } --> Leeds.in++;
}
