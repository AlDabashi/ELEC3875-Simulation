/*
 * RoutingNode.cc
 *
 *  Created on: 25 Feb 2019
 *      Author: el16ahd
 */

/*
 * This file describes the component RoutingNode which is declared in the file "DefineComponents.ned"
 * This node allows for messages to be passed along the shortest (delay) route
 * Some code copied from project folder: routing/node/Routing.cc
 */


#ifdef _MSC_VER
#pragma warning(disable:4786)
#endif

#include <map>
#include <omnetpp.h>
#include "Message_m.h"

using namespace omnetpp;

class RoutingNode : public cSimpleModule
{
    private:
    int myAddress;
    int src;
    int dest;
    int gateIndex;

    typedef std::map<int, int> RoutingTable;  // destaddr -> gateindex
    RoutingTable rtable;

    Message *tmsg =  check_and_cast<Message*>(tmsg); // Called it tmsg because can't be same as cMessage's msg which is in handleMessage


    protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *tmsg) override;
};

Define_Module(RoutingNode);

void RoutingNode::initialize()
{
    tmsg->setSource(1);
    tmsg->setDestination(4);

    src = tmsg->getSource();
    dest = tmsg->getDestination();
    cTopology *topo = new cTopology("topo"); // topo is the topology we'll be using

    cTopology::Node *destNode;
    cTopology::Node *srcNode;
    cTopology::Node *thisNode;
    thisNode = topo->getNodeFor(this);

    myAddress = this->par("address");
    EV << "Address of this node is " << myAddress << endl;

    /*std::vector<std::string> nedTypes; // nedTypes is a string variable
    nedTypes.push_back(getParentModule()->getNedTypeName()); // To store the module type as a string into "nedTypes" (module type e.g.: node, router, computer, transmitter, receiver...etc.)
    topo->extractByNedTypeName(nedTypes); // We want all similar module types as this one included in the topology of topo, so we extract all similar node types to this current one */
    topo->extractByParameter("address");

    EV << "cTopology found " << topo->getNumNodes() << " nodes\n";

    if (myAddress == dest) { // Every node checks if it is the destination node specified above
        destNode = topo->getNodeFor(this); // Save this destination module as a node called "destNode" in topo
        }

    else if (myAddress == src) { // Every node checks if it is the source node specified above
        srcNode = topo->getNodeFor(this); // Save this source module as a node called "thisNode" in topo
        }

    topo->calculateUnweightedSingleShortestPathsTo(destNode); // I want shortest path to destNode

    cGate *parentModuleGate = thisNode->getPath(0)->getLocalGate(); // Returns gate number of wanted connection
    gateIndex = parentModuleGate->getIndex();
    delete topo;
}

void RoutingNode::handleMessage(cMessage *msg)
{
    if (myAddress == dest) {
            EV << "Message arrived at destination";
            endSimulation();
        }
    else {
        send(tmsg, gateIndex);
    }
}








