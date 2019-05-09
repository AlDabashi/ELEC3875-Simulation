// 14/02/19
// Simulation of the UK's BT fibre core network using bidirection connections. 
// Same as BT_Fibre_Network4's BTFibreCoreNetwork but with specific delays between the connections
// Al Husien Dabashi, 07/02/2019

// Building the fibre core network which comprises of 20 nodes
// Refer to Figure 3 in "A stabilising control strategy for Cyber-Physical Power Systems"
// Incorporates channel delays between nodes from above mentioned paper
// Channel delays extracted from MATLAB script: Delay_BT_UK_AL

network BT_Fibre_Network6
{
    @display("bgb=958.85004,860.7,#B5DCAD");
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
        Leeds.gate++ <--> { delay = 0.060445s; } <--> Manchester.gate++;
        MiltonKeynes.gate++ <--> { delay = 0.06113s; } <--> Manchester.gate++;
        MiltonKeynes.gate++ <--> { delay = 0.061099s; } <--> Leeds.gate++;
        Docklands.gate++ <--> { delay = 0.061621s; } <--> Manchester.gate++;
        Docklands.gate++ <--> { delay = 0.061447s; } <--> Leeds.gate++;
        Docklands.gate++ <--> { delay = 0.060592s; } <--> MiltonKeynes.gate++;
        SouthBank.gate++ <--> { delay = 0.06155s; } <--> Manchester.gate++;
        SouthBank.gate++ <--> { delay = 0.061412s; } <--> Leeds.gate++;
        SouthBank.gate++ <--> { delay = 0.060512s; } <--> MiltonKeynes.gate++;
        SouthBank.gate++ <--> { delay = 0.060194s; } <--> Docklands.gate++;
        London.gate++ <--> { delay = 0.061566s; } <--> Manchester.gate++;
        London.gate++ <--> { delay = 0.061471s; } <--> Leeds.gate++;
        London.gate++ <--> { delay = 0.060516s; } <--> MiltonKeynes.gate++;
        London.gate++ <--> { delay = 0.06019s; } <--> Docklands.gate++;
        London.gate++ <--> { delay = 0.06017s; } <--> SouthBank.gate++;
        LondonNorthWest.gate++ <--> { delay = 0.061546s; } <--> Manchester.gate++;
        LondonNorthWest.gate++ <--> { delay = 0.061408s; } <--> Leeds.gate++;
        LondonNorthWest.gate++ <--> { delay = 0.060497s; } <--> MiltonKeynes.gate++;
        LondonNorthWest.gate++ <--> { delay = 0.060212s; } <--> Docklands.gate++;
        LondonNorthWest.gate++ <--> { delay = 0.060188s; } <--> SouthBank.gate++;
        LondonNorthWest.gate++ <--> { delay = 0.06018s; } <--> London.gate++;
        Birmingham.gate++ <--> { delay = 0.060774s; } <--> Manchester.gate++;
        Birmingham.gate++ <--> { delay = 0.060916s; } <--> Leeds.gate++;
        Birmingham.gate++ <--> { delay = 0.060608s; } <--> MiltonKeynes.gate++;
        Birmingham.gate++ <--> { delay = 0.061035s; } <--> Docklands.gate++;
        Birmingham.gate++ <--> { delay = 0.060968s; } <--> SouthBank.gate++;
        Birmingham.gate++ <--> { delay = 0.060905s; } <--> London.gate++;
        Birmingham.gate++ <--> { delay = 0.060952s; } <--> LondonNorthWest.gate++;
        Glasgow.gate++ <--> { delay = 0.061522s; } <--> Manchester.gate++;
        Glasgow.gate++ <--> { delay = 0.061566s; } <--> Leeds.gate++;
        ClydeValley.gate++ <--> { delay = 0.061546s; } <--> Manchester.gate++;
        ClydeValley.gate++ <--> { delay = 0.061586s; } <--> Leeds.gate++;
        ClydeValley.gate++ <--> { delay = 0.060453s; } <--> Glasgow.gate++;
        Newcastle.gate++ <--> { delay = 0.061087s; } <--> Manchester.gate++;
        Newcastle.gate++ <--> { delay = 0.060806s; } <--> Leeds.gate++;
        Newcastle.gate++ <--> { delay = 0.061618s; } <--> MiltonKeynes.gate++;
        Preston.gate++ <--> { delay = 0.06037s; } <--> Manchester.gate++;
        Preston.gate++ <--> { delay = 0.060592s; } <--> Leeds.gate++;
        Preston.gate++ <--> { delay = 0.061265s; } <--> MiltonKeynes.gate++;
        Preston.gate++ <--> { delay = 0.060845s; } <--> Birmingham.gate++;
        Sheffield.gate++ <--> { delay = 0.060402s; } <--> Manchester.gate++;
        Sheffield.gate++ <--> { delay = 0.060382s; } <--> Leeds.gate++;
        Sheffield.gate++ <--> { delay = 0.060711s; } <--> Birmingham.gate++;
        Derby.gate++ <--> { delay = 0.060556s; } <--> Manchester.gate++;
        Derby.gate++ <--> { delay = 0.060683s; } <--> MiltonKeynes.gate++;
        Derby.gate++ <--> { delay = 0.060425s; } <--> Birmingham.gate++;
        Peterborough.gate++ <--> { delay = 0.060497s; } <--> MiltonKeynes.gate++;
        Peterborough.gate++ <--> { delay = 0.060687s; } <--> SouthBank.gate++;
        Peterborough.gate++ <--> { delay = 0.060695s; } <--> LondonNorthWest.gate++;
        Guildford.gate++ <--> { delay = 0.060445s; } <--> Docklands.gate++;
        Guildford.gate++ <--> { delay = 0.06037s; } <--> SouthBank.gate++;
        Slough.gate++ <--> { delay = 0.060326s; } <--> Docklands.gate++;
        Slough.gate++ <--> { delay = 0.060318s; } <--> SouthBank.gate++;
        Slough.gate++ <--> { delay = 0.060326s; } <--> London.gate++;
        Slough.gate++ <--> { delay = 0.060311s; } <--> LondonNorthWest.gate++;
        Slough.gate++ <--> { delay = 0.060322s; } <--> Guildford.gate++;
        Bristol.gate++ <--> { delay = 0.06092s; } <--> SouthBank.gate++;
        Bristol.gate++ <--> { delay = 0.06092s; } <--> London.gate++;
        Bristol.gate++ <--> { delay = 0.060734s; } <--> Birmingham.gate++;
        Cardiff.gate++ <--> { delay = 0.06113s; } <--> London.gate++;
        Cardiff.gate++ <--> { delay = 0.061118s; } <--> LondonNorthWest.gate++;
        Cardiff.gate++ <--> { delay = 0.060853s; } <--> Birmingham.gate++;
        Cardiff.gate++ <--> { delay = 0.060441s; } <--> Bristol.gate++;
        Wolverhampton.gate++ <--> { delay = 0.060703s; } <--> Manchester.gate++;
        Wolverhampton.gate++ <--> { delay = 0.060687s; } <--> MiltonKeynes.gate++;
        Wolverhampton.gate++ <--> { delay = 0.060976s; } <--> LondonNorthWest.gate++;
        Wolverhampton.gate++ <--> { delay = 0.060271s; } <--> Birmingham.gate++;  
}