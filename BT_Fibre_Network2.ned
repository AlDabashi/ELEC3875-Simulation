// Inner core simulation of the UK's BT fibre core network using single direction connections.
// Al Husien Dabashi, 06/02/2019

// Take 1, building the inner core network which comprises of 8 nodes
// Refer to Figure 3 in "A stabilising control strategy for Cyber-Physical Power Systems"

network InnerCoreNetwork
{
    @display("bgb=544,524");
    submodules:
        Manchester: innerNode {
            @display("p=169,77");
        }
        Leeds: innerNode {
            @display("p=391,77");
        }
        MiltonKeynes: innerNode {
            @display("p=465,175");
        }
        Docklands: innerNode {
            @display("p=465,316");
        }
        SouthBank: innerNode {
            @display("p=391,429");
        }
        London: innerNode {
            @display("p=169,429");
        }
        LondonNorthWest: innerNode {
            @display("p=78,316");
        }
        Birmingham: innerNode {

            @display("p=78,175");
        }
    connections:
        // Two way connections exist (https://docs.omnetpp.org/tutorials/tictoc/part4/)
        // but get this working before moving on
        Manchester.out++ --> {  delay = 100ms; } --> Leeds.in++;
        Manchester.out++ --> {  delay = 100ms; } --> MiltonKeynes.in++;
        Manchester.out++ --> {  delay = 100ms; } --> Docklands.in++;
        Manchester.out++ --> {  delay = 100ms; } --> SouthBank.in++;
        Manchester.out++ --> {  delay = 100ms; } --> London.in++;
        Manchester.out++ --> {  delay = 100ms; } --> LondonNorthWest.in++;
        Manchester.out++ --> {  delay = 100ms; } --> Birmingham.in++;
        
        Leeds.out++ --> {  delay = 100ms; } --> Manchester.in++;
        Leeds.out++ --> {  delay = 100ms; } --> MiltonKeynes.in++;
        Leeds.out++ --> {  delay = 100ms; } --> Docklands.in++;
        Leeds.out++ --> {  delay = 100ms; } --> SouthBank.in++;
        Leeds.out++ --> {  delay = 100ms; } --> London.in++;
        
        MiltonKeynes.out++ --> {  delay = 100ms; } --> Manchester.in++;
        MiltonKeynes.out++ --> {  delay = 100ms; } --> Leeds.in++;
        MiltonKeynes.out++ --> {  delay = 100ms; } --> Docklands.in++;
        MiltonKeynes.out++ --> {  delay = 100ms; } --> SouthBank.in++;
        MiltonKeynes.out++ --> {  delay = 100ms; } --> London.in++;
        MiltonKeynes.out++ --> {  delay = 100ms; } --> LondonNorthWest.in++;
        MiltonKeynes.out++ --> {  delay = 100ms; } --> Birmingham.in++;
        
        Docklands.out++ --> {  delay = 100ms; } --> Manchester.in++;
        Docklands.out++ --> {  delay = 100ms; } --> Leeds.in++;
        Docklands.out++ --> {  delay = 100ms; } --> MiltonKeynes.in++;
        Docklands.out++ --> {  delay = 100ms; } --> SouthBank.in++;
        Docklands.out++ --> {  delay = 100ms; } --> London.in++;
        Docklands.out++ --> {  delay = 100ms; } --> LondonNorthWest.in++;
        Docklands.out++ --> {  delay = 100ms; } --> Birmingham.in++;
        
        SouthBank.out++ --> {  delay = 100ms; } --> Manchester.in++;
        SouthBank.out++ --> {  delay = 100ms; } --> Leeds.in++;
        SouthBank.out++ --> {  delay = 100ms; } --> MiltonKeynes.in++;
        SouthBank.out++ --> {  delay = 100ms; } --> Docklands.in++;
        SouthBank.out++ --> {  delay = 100ms; } --> London.in++;
        SouthBank.out++ --> {  delay = 100ms; } --> LondonNorthWest.in++;
        SouthBank.out++ --> {  delay = 100ms; } --> Birmingham.in++;
        
        London.out++ --> {  delay = 100ms; } --> Manchester.in++;
        London.out++ --> {  delay = 100ms; } --> Leeds.in++;
        London.out++ --> {  delay = 100ms; } --> MiltonKeynes.in++;
        London.out++ --> {  delay = 100ms; } --> Docklands.in++;
        London.out++ --> {  delay = 100ms; } --> SouthBank.in++;
        London.out++ --> {  delay = 100ms; } --> LondonNorthWest.in++;
        London.out++ --> {  delay = 100ms; } --> Birmingham.in++;
        
        LondonNorthWest.out++ --> {  delay = 100ms; } --> Manchester.in++;
        LondonNorthWest.out++ --> {  delay = 100ms; } --> MiltonKeynes.in++;
        LondonNorthWest.out++ --> {  delay = 100ms; } --> Docklands.in++;
        LondonNorthWest.out++ --> {  delay = 100ms; } --> SouthBank.in++;
        LondonNorthWest.out++ --> {  delay = 100ms; } --> London.in++;
        LondonNorthWest.out++ --> {  delay = 100ms; } --> Birmingham.in++;
        
        Birmingham.out++ --> {  delay = 100ms; } --> Manchester.in++;
        Birmingham.out++ --> {  delay = 100ms; } --> MiltonKeynes.in++;
        Birmingham.out++ --> {  delay = 100ms; } --> Docklands.in++;
        Birmingham.out++ --> {  delay = 100ms; } --> SouthBank.in++;
        Birmingham.out++ --> {  delay = 100ms; } --> London.in++;
        Birmingham.out++ --> {  delay = 100ms; } --> LondonNorthWest.in++;
        
}
