// Simulation of the UK's BT fibre core network using bidirection connections. 
// Same as BT_Fibre_Network4's BTFibreCoreNetwork but with specific delays between the connections
// Al Husien Dabashi, 07/02/2019

// Building the fibre core network which comprises of 20 nodes
// Refer to Figure 3 in "A stabilising control strategy for Cyber-Physical Power Systems"


network BT_Fibre_Network5
{
    @display("bgb=958.85004,860.7,#B5DCAD");
    types:
        channel channel1 extends ned.DelayChannel {
            delay = 60ms;
        }
        channel channel2 extends ned.DelayChannel {
            delay = 120ms;
        }
        channel channel3 extends ned.DelayChannel {
            delay = 180ms;
        }
    submodules:
        Manchester: innerNode2 {
            @display("i=,gold;p=359.38,315.59");
            @display("p=316.8,269.28");
        }
        Leeds: innerNode2 {
            @display("i=,gold;p=634.2,302");
            @display("p=558.624,295.68");
        }
        MiltonKeynes: innerNode2 {
            @display("i=,gold;p=693.09,427.33002");
            @display("p=612.48,367.488");
        }
        Docklands: innerNode2 {
            @display("i=,gold;p=706.68,567.76");
            @display("p=612.48,508.992");
        }
        SouthBank: innerNode2 {
            @display("i=,gold;p=605.51,673.46");
            @display("p=538.56,621.984");
        }
        London: innerNode2 {
            @display("i=,gold;p=359.38,673.46");
            @display("p=316.8,621.984");
        }
        LondonNorthWest: innerNode2 {
            @display("i=,gold;p=270.29,549.64");
            @display("p=224.92801,508.992");
        }
        Birmingham: innerNode2 {
            @display("i=,gold;p=270.29,418.27");
            @display("p=224.92801,367.488");
        }
        Glasgow: innerNode2 {
            @display("p=359.38,61.91");
        }
        ClydeValley: innerNode2 {
            @display("p=596.45,72.48");
        }
        Newcastle: innerNode2 {
            @display("p=693.09,111.74");
        }
        Preston: innerNode2 {
            @display("p=510.38,243.11");
        }
        Sheffield: innerNode2 {
            @display("p=528.5,327.67");
        }
        Derby: innerNode2 {
            @display("p=382.03,406.19");
        }
        Peterborough: innerNode2 {
            @display("p=810.87,549.64");
        }
        Guildford: innerNode2 {
            @display("p=693.09,779.16003");
        }
        Slough: innerNode2 {
            @display("p=318.61002,779.16003");
        }
        Bristol: innerNode2 {
            @display("p=217.44,747.45");
        }
        Cardiff: innerNode2 {
            @display("p=158.55,608.53");
        }
        Wolverhampton: innerNode2 {
            @display("p=132.88,477.16");
        }

    connections:
        ///////////////////// Inner Core Connections //////////////////////
        Manchester.gate++ <--> channel1 <--> Leeds.gate++;
        Manchester.gate++ <--> channel1 <--> MiltonKeynes.gate++;
        Manchester.gate++ <--> channel1 <--> Docklands.gate++;
        Manchester.gate++ <--> channel1 <--> SouthBank.gate++;
        Manchester.gate++ <--> channel1 <--> London.gate++;
        Manchester.gate++ <--> channel1 <--> LondonNorthWest.gate++;
        Manchester.gate++ <--> channel1 <--> Birmingham.gate++;

        Leeds.gate++ <--> channel1 <--> MiltonKeynes.gate++;
        Leeds.gate++ <--> channel1 <--> Docklands.gate++;
        Leeds.gate++ <--> channel1 <--> SouthBank.gate++;
        Leeds.gate++ <--> channel1 <--> London.gate++;

        MiltonKeynes.gate++ <--> channel1 <--> Docklands.gate++;
        MiltonKeynes.gate++ <--> channel1 <--> SouthBank.gate++;
        MiltonKeynes.gate++ <--> channel1 <--> London.gate++;
        MiltonKeynes.gate++ <--> channel1 <--> LondonNorthWest.gate++;
        MiltonKeynes.gate++ <--> channel1 <--> Birmingham.gate++;

        Docklands.gate++ <--> channel1 <--> SouthBank.gate++;
        Docklands.gate++ <--> channel1 <--> London.gate++;
        Docklands.gate++ <--> channel1 <--> LondonNorthWest.gate++;
        Docklands.gate++ <--> channel1 <--> Birmingham.gate++;

        SouthBank.gate++ <--> channel1 <--> London.gate++;
        SouthBank.gate++ <--> channel1 <--> LondonNorthWest.gate++;
        SouthBank.gate++ <--> channel1 <--> Birmingham.gate++;

        London.gate++ <--> channel1 <--> LondonNorthWest.gate++;
        London.gate++ <--> channel1 <--> Birmingham.gate++;

        LondonNorthWest.gate++ <--> channel1 <--> Birmingham.gate++;

        ///////////////////// Outer Core Connections //////////////////////
        Manchester.gate++ <--> channel2 <--> Glasgow.gate++;
        Manchester.gate++ <--> channel2 <--> ClydeValley.gate++;
        Manchester.gate++ <--> channel2 <--> Newcastle.gate++;
        Manchester.gate++ <--> channel2 <--> Preston.gate++;
        Manchester.gate++ <--> channel2 <--> Sheffield.gate++;
        Manchester.gate++ <--> channel2 <--> Derby.gate++;
        Manchester.gate++ <--> channel2 <--> Wolverhampton.gate++;

        Leeds.gate++ <--> channel2 <--> Glasgow.gate++;
        Leeds.gate++ <--> channel2 <--> ClydeValley.gate++;
        Leeds.gate++ <--> channel2 <--> Newcastle.gate++;
        Leeds.gate++ <--> channel2 <--> Sheffield.gate++;
        Leeds.gate++ <--> channel2 <--> Derby.gate++;

        MiltonKeynes.gate++ <--> channel2 <--> Newcastle.gate++;
        MiltonKeynes.gate++ <--> channel2 <--> Preston.gate++;
        MiltonKeynes.gate++ <--> channel2 <--> Derby.gate++;
        MiltonKeynes.gate++ <--> channel2 <--> Peterborough.gate++;
        MiltonKeynes.gate++ <--> channel2 <--> Wolverhampton.gate++;

        Docklands.gate++ <--> channel3 <--> Guildford.gate++;
        Docklands.gate++ <--> channel3 <--> Slough.gate++;

        SouthBank.gate++ <--> channel3 <--> Peterborough.gate++;
        SouthBank.gate++ <--> channel3 <--> Guildford.gate++;
        SouthBank.gate++ <--> channel3 <--> Slough.gate++;
        SouthBank.gate++ <--> channel3 <--> Bristol.gate++;

        London.gate++ <--> channel3 <--> Slough.gate++;
        London.gate++ <--> channel3 <--> Bristol.gate++;
        London.gate++ <--> channel3 <--> Cardiff.gate++;

        LondonNorthWest.gate++ <--> channel3 <--> Peterborough.gate++;
        LondonNorthWest.gate++ <--> channel3 <--> Slough.gate++;
        LondonNorthWest.gate++ <--> channel3 <--> Cardiff.gate++;
        LondonNorthWest.gate++ <--> channel3 <--> Wolverhampton.gate++;

        Birmingham.gate++ <--> channel3 <--> Preston.gate++;
        Birmingham.gate++ <--> channel3 <--> Sheffield.gate++;
        Birmingham.gate++ <--> channel3 <--> Derby.gate++;
        Birmingham.gate++ <--> channel3 <--> Bristol.gate++;
        Birmingham.gate++ <--> channel3 <--> Cardiff.gate++;
        Birmingham.gate++ <--> channel3 <--> Wolverhampton.gate++;

}
