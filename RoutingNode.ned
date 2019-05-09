// Simple module declaration
// RoutingNode is a simple module that will use same method as in OMNeT++'s example "routing"

simple RoutingNode
{
    parameters:
        int address;
    gates:
        inout gate[];
}
