// routing folder from OMNeT++'s examples



// Represents a pakcet being sent around like a typical message would in a network.
packet Packet
{
    int srcAddr @packetData;
    int destAddr @packetData;
    int hopCount @packetData;
}



