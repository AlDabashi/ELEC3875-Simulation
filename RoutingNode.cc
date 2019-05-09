/*
 * RoutingNodeNode.cc
 *
 *  Created on: 25 Mar 2019
 *      Author: el16ahd
 */

//
// Following method of OMNeT++'s example "RoutingNode", specifically  the "RoutingNode.cc" file
// Modified for different implementation purposes.

#ifdef _MSC_VER
#pragma warning(disable:4786)
#endif

#include <map>
#include <omnetpp.h>
#include "Packet_m.h"

using namespace omnetpp;

/**
 * Demonstrates static RoutingNode, utilizing the cTopology class.
 */
class RoutingNode : public cSimpleModule
{
  private:
    int myAddress;

    typedef std::map<int, int> RoutingNodeTable;  // destaddr -> gateindex
    RoutingNodeTable rtable;

  protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
};

Define_Module(RoutingNode);

void RoutingNode::initialize()
{
    myAddress = getParentModule()->par("address");

    // Brute force approach -- every node does topology discovery on its own,
    // and finds shortest routes to every other node in the network, at the beginning
    // of the simulation. This could be improved: (1) central RoutingNode database,
    // (2) on-demand route calculation

    cTopology *topo = new cTopology("topo");

    std::vector<std::string> nedTypes;
    nedTypes.push_back(getParentModule()->getNedTypeName());
    topo->extractByNedTypeName(nedTypes);
    EV << "cTopology found " << topo->getNumNodes() << " nodes\n";

    cTopology::Node *thisNode = topo->getNodeFor(getParentModule());

    // find and store next hops
    for (int i = 0; i < topo->getNumNodes(); i++) {
        if (topo->getNode(i) == thisNode)
            continue;  // skip ourselves
        topo->calculateUnweightedSingleShortestPathsTo(topo->getNode(i));

        if (thisNode->getNumPaths() == 0)
            continue;  // not connected

        cGate *parentModuleGate = thisNode->getPath(0)->getLocalGate();
        int gateIndex = parentModuleGate->getIndex();
        int address = topo->getNode(i)->getModule()->par("address");
        rtable[address] = gateIndex;
        EV << "  towards address " << address << " gateIndex is " << gateIndex << endl;
    }
    delete topo;
}

void RoutingNode::handleMessage(cMessage *msg)
{
    Packet *pk = check_and_cast<Packet *>(msg);
    int destAddr = pk->getDestAddr();

    if (destAddr == myAddress) {
        EV << "local delivery of packet " << pk->getName() << endl;
        send(pk, "localOut");
        return;
    }

    RoutingNodeTable::iterator it = rtable.find(destAddr);
    if (it == rtable.end()) {
        EV << "address " << destAddr << " unreachable, discarding packet " << pk->getName() << endl;
        delete pk;
        return;
    }

    int outGateIndex = (*it).second;
    EV << "forwarding packet " << pk->getName() << " on gate index " << outGateIndex << endl;
    pk->setHopCount(pk->getHopCount()+1);

    send(pk, "out", outGateIndex);
}





