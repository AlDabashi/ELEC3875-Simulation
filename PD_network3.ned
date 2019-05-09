//
// Use seperate .ned files for each network for better reference and organisation
//

network PD_network3
{
    @display("bgb=572,398");
    submodules:
        node1: PD_node3 {
            @display("p=203,303");
        }
        node2: PD_node3 {
            @display("p=308,242");
        }
        node3: PD_node3 {
            @display("p=375,323");
        }
        node4: PD_node3 {
            @display("p=407,172");
        }
        node5: PD_node3 {
            @display("p=236,124");
        }
        node6: PD_node3 {
            @display("p=330,69");
        }
        node7: PD_node3 {
            @display("p=126,186");
        }
        node8: PD_node3 {
            @display("p=177,48");
        }
    connections:
        node1.gate++ <--> {  delay = 100ms; } <--> node2.gate++;

        node2.gate++ <--> {  delay = 100ms; } <--> node3.gate++;
        node2.gate++ <--> {  delay = 100ms; } <--> node4.gate++;
        node2.gate++ <--> {  delay = 100ms; } <--> node5.gate++;

        node5.gate++ <--> {  delay = 100ms; } <--> node6.gate++;
        node5.gate++ <--> {  delay = 100ms; } <--> node7.gate++;
        node5.gate++ <--> {  delay = 100ms; } <--> node8.gate++;
}

