/*
 * innerNode.cc
 *
 *  Created on: 6 Feb 2019
 *      Author: el16ahd
 */

// This node used in BT_Fibre_Networks1 and BT_Fibre_Networks2

#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;

class innerNode : public cSimpleModule
{
  protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual void forwardMessage(cMessage *msg);
};

Define_Module(innerNode);

void innerNode::initialize()
{
    if (strcmp("Manchester", getName()) == 0) { // Let Manchester send the first message
            cMessage *msg = new cMessage("tictocMsg");
            int n = gateSize("out");    // Message sent on random out gate
            int k = intuniform(0, n-1); // Picking a random number between 0 and size of "out[]" gate
            send(msg, "out", k);
    }
}

void innerNode::handleMessage(cMessage *msg)
{
    if (getIndex() == 3) {
        EV << "Message " << msg << " arrived.\n";
        delete msg;
    }
    else {
        forwardMessage(msg);
    }
}

void innerNode::forwardMessage(cMessage *msg)
{
    int n = gateSize("out");    // Message sent on random out gate
    int k = intuniform(0, n-1); // Picking a random number between 0 and size of "out[]" gate

    EV << "Forwarding message " << msg << " on port out [" << k << " ]\n";
    send(msg, "out", k);
}
