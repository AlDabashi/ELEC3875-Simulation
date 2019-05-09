// Simulation of the UK's BT fibre core network using bidirection connections.
// Al Husien Dabashi, 25/03/2019

// Building the fibre core network which comprises of 20 nodes
// Refer to Figure 3 in "A stabilising control strategy for Cyber-Physical Power Systems"

network BTnetwork
{
    @display("bgb=958.85004,860.7,#B5DCAD");
    submodules:
        Manchester: RoutingNode {
            address = 1;
            @display("i=,gold;p=359.38,315.59");
            @display("p=316.8,269.28");
        }
        Leeds: RoutingNode {
            address = 2;
            @display("i=,gold;p=634.2,302");
            @display("p=558.624,295.68");
        }
        MiltonKeynes: RoutingNode {
            address = 3;
            @display("i=,gold;p=693.09,427.33002");
            @display("p=612.48,367.488");
        }
        Docklands: RoutingNode {
            address = 4;
            @display("i=,gold;p=706.68,567.76");
            @display("p=612.48,508.992");
        }
        SouthBank: RoutingNode {
            address = 5;
            @display("i=,gold;p=605.51,673.46");
            @display("p=538.56,621.984");
        }
        London: RoutingNode {
            address = 6;
            @display("i=,gold;p=359.38,673.46");
            @display("p=316.8,621.984");
        }
        LondonNorthWest: RoutingNode {
            address = 7;
            @display("i=,gold;p=270.29,549.64");
            @display("p=224.92801,508.992");
        }
        Birmingham: RoutingNode {
            address = 8;
            @display("i=,gold;p=270.29,418.27");
            @display("p=224.92801,367.488");
        }
        Glasgow: RoutingNode {
            address = 9;
            @display("p=359.38,61.91");
        }
        ClydeValley: RoutingNode {
            address = 10;
            @display("p=596.45,72.48");
        }
        Newcastle: RoutingNode {
            address = 11;
            @display("p=693.09,111.74");
        }
        Preston: RoutingNode {
            address = 12;
            @display("p=510.38,243.11");
        }
        Sheffield: RoutingNode {
            address = 13;
            @display("p=528.5,327.67");
        }
        Derby: RoutingNode {
            address = 14;
            @display("p=382.03,406.19");
        }
        Peterborough: RoutingNode {
            address = 15;
            @display("p=810.87,549.64");
        }
        Guildford: RoutingNode {
            address = 16;
            @display("p=693.09,779.16003");
        }
        Slough: RoutingNode {
            address = 17;
            @display("p=318.61002,779.16003");
        }
        Bristol: RoutingNode {
            address = 18;
            @display("p=217.44,747.45");
        }
        Cardiff: RoutingNode {
            address = 19;
            @display("p=158.55,608.53");
        }
        Wolverhampton: RoutingNode {
            address = 20;
            @display("p=132.88,477.16");
        }

    connections:
        ///////////////////// Inner Core Connections //////////////////////
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

        ///////////////////// Outer Core Connections //////////////////////
        Manchester.gate++ <--> {  delay = 100ms; } <--> Glasgow.gate++;
        Manchester.gate++ <--> {  delay = 100ms; } <--> ClydeValley.gate++;
        Manchester.gate++ <--> {  delay = 100ms; } <--> Newcastle.gate++;
        Manchester.gate++ <--> {  delay = 100ms; } <--> Preston.gate++;
        Manchester.gate++ <--> {  delay = 100ms; } <--> Sheffield.gate++;
        Manchester.gate++ <--> {  delay = 100ms; } <--> Derby.gate++;
        Manchester.gate++ <--> {  delay = 100ms; } <--> Wolverhampton.gate++;

        Leeds.gate++ <--> {  delay = 100ms; } <--> Glasgow.gate++;
        Leeds.gate++ <--> {  delay = 100ms; } <--> ClydeValley.gate++;
        Leeds.gate++ <--> {  delay = 100ms; } <--> Newcastle.gate++;
        Leeds.gate++ <--> {  delay = 100ms; } <--> Sheffield.gate++;
        Leeds.gate++ <--> {  delay = 100ms; } <--> Derby.gate++;

        MiltonKeynes.gate++ <--> {  delay = 100ms; } <--> Newcastle.gate++;
        MiltonKeynes.gate++ <--> {  delay = 100ms; } <--> Preston.gate++;
        MiltonKeynes.gate++ <--> {  delay = 100ms; } <--> Derby.gate++;
        MiltonKeynes.gate++ <--> {  delay = 100ms; } <--> Peterborough.gate++;
        MiltonKeynes.gate++ <--> {  delay = 100ms; } <--> Wolverhampton.gate++;

        Docklands.gate++ <--> {  delay = 100ms; } <--> Guildford.gate++;
        Docklands.gate++ <--> {  delay = 100ms; } <--> Slough.gate++;

        SouthBank.gate++ <--> {  delay = 100ms; } <--> Peterborough.gate++;
        SouthBank.gate++ <--> {  delay = 100ms; } <--> Guildford.gate++;
        SouthBank.gate++ <--> {  delay = 100ms; } <--> Slough.gate++;
        SouthBank.gate++ <--> {  delay = 100ms; } <--> Bristol.gate++;

        London.gate++ <--> {  delay = 100ms; } <--> Slough.gate++;
        London.gate++ <--> {  delay = 100ms; } <--> Bristol.gate++;
        London.gate++ <--> {  delay = 100ms; } <--> Cardiff.gate++;

        LondonNorthWest.gate++ <--> {  delay = 100ms; } <--> Peterborough.gate++;
        LondonNorthWest.gate++ <--> {  delay = 100ms; } <--> Slough.gate++;
        LondonNorthWest.gate++ <--> {  delay = 100ms; } <--> Cardiff.gate++;
        LondonNorthWest.gate++ <--> {  delay = 100ms; } <--> Wolverhampton.gate++;

        Birmingham.gate++ <--> {  delay = 100ms; } <--> Preston.gate++;
        Birmingham.gate++ <--> {  delay = 100ms; } <--> Sheffield.gate++;
        Birmingham.gate++ <--> {  delay = 100ms; } <--> Derby.gate++;
        Birmingham.gate++ <--> {  delay = 100ms; } <--> Bristol.gate++;
        Birmingham.gate++ <--> {  delay = 100ms; } <--> Cardiff.gate++;
        Birmingham.gate++ <--> {  delay = 100ms; } <--> Wolverhampton.gate++;

}



