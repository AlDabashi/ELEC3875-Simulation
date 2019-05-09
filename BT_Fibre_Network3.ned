// Inner core simulation of the UK's BT fibre core network using bidirection connections.
// Al Husien Dabashi, 06/02/2019

// Building the inner core network which comprises of 8 nodes
// Refer to Figure 3 in "A stabilising control strategy for Cyber-Physical Power Systems"

network InnerCoreNetwork2
{
    @display("bgb=544,524");
    submodules:
        Manchester: innerNode2 {
            @display("p=169,77");
        }
        Leeds: innerNode2 {
            @display("p=391,77");
        }
        MiltonKeynes: innerNode2 {
            @display("p=465,175");
        }
        Docklands: innerNode2 {
            @display("p=465,316");
        }
        SouthBank: innerNode2 {
            @display("p=391,429");
        }
        London: innerNode2 {
            @display("p=169,429");
        }
        LondonNorthWest: innerNode2 {
            @display("p=78,316");
        }
        Birmingham: innerNode2 {
            @display("p=78,175");
        }
        
    connections:
        Manchester.gate++ <--> {  delay = 100ms; } <--> Leeds.gate++;
        Manchester.gate++ <--> {  delay = 100ms; } <--> MiltonKeynes.gate++;
        Manchester.gate++ <--> {  delay = 100ms; } <--> Docklands.gate++;
        Manchester.gate++ <--> {  delay = 100ms; } <--> SouthBank.gate++;
        Manchester.gate++ <--> {  delay = 100ms; } <--> London.gate++;
        Manchester.gate++ <--> {  delay = 100ms; } <--> LondonNorthWest.gate++;
        Manchester.gate++ <--> {  delay = 100ms; } <--> Birmingham.gate++;
        
        Leeds.gate++ <--> {  delay = 100ms; } <--> MiltonKeynes.gate++;
        Leeds.gate++ <--> {  delay = 100ms; } <--> Docklands.gate++;
        Leeds.gate++ <--> {  delay = 100ms; } <--> SouthBank.gate++;
        Leeds.gate++ <--> {  delay = 100ms; } <--> London.gate++;
        
        MiltonKeynes.gate++ <--> {  delay = 100ms; } <--> Docklands.gate++;
        MiltonKeynes.gate++ <--> {  delay = 100ms; } <--> SouthBank.gate++;
        MiltonKeynes.gate++ <--> {  delay = 100ms; } <--> London.gate++;
        MiltonKeynes.gate++ <--> {  delay = 100ms; } <--> LondonNorthWest.gate++;
        MiltonKeynes.gate++ <--> {  delay = 100ms; } <--> Birmingham.gate++;
        
        Docklands.gate++ <--> {  delay = 100ms; } <--> SouthBank.gate++;
        Docklands.gate++ <--> {  delay = 100ms; } <--> London.gate++;
        Docklands.gate++ <--> {  delay = 100ms; } <--> LondonNorthWest.gate++;
        Docklands.gate++ <--> {  delay = 100ms; } <--> Birmingham.gate++;
        
        SouthBank.gate++ <--> {  delay = 100ms; } <--> London.gate++;
        SouthBank.gate++ <--> {  delay = 100ms; } <--> LondonNorthWest.gate++;
        SouthBank.gate++ <--> {  delay = 100ms; } <--> Birmingham.gate++;
        
        London.gate++ <--> {  delay = 100ms; } <--> LondonNorthWest.gate++;
        London.gate++ <--> {  delay = 100ms; } <--> Birmingham.gate++;
        
        LondonNorthWest.gate++ <--> {  delay = 100ms; } <--> Birmingham.gate++;        
}
