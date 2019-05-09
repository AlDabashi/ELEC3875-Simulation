/*
 * PD_node2.cc
 *
 *  Created on: 25 Feb 2019
 *      Author: el16ahd
 */

// This node/module allows for source routing
// Need to include functionality to check the "myStack" in

#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;

class PD_node2 : public cSimpleModule
{
  protected:
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
    virtual void forwardMessage(cMessage *msg);
};

Define_Module(PD_node2);

void PD_node2::initialize()
{
    if (strcmp("node1", getName()) == 0)
    {
        cMessage *msg = new cMessage("tictocMsg");
                    int n = gateSize("gate");   // Message sent on random out gate
                    int k = intuniform(0, n-1); // Picking a random number between 0 and size of "out[]" gate
                    send(msg, "gate$o", k);
    }
}

void PD_node2::handleMessage(cMessage *msg)
{
    if (strcmp("node4", getName()) == 0) // i.e. Choose destination node here between the " "
    {
            EV << "Message " << msg << " arrived.\n";
            delete msg;
            endSimulation();
    }
    else {
            forwardMessage(msg);
    }
}

void PD_node2::forwardMessage(cMessage *msg)
{
    // In this example, we just pick a random gate to send it on.
    // We draw a random number between 0 and the size of gate `out[]'.
    int n = gateSize("gate");
    int k = intuniform(0, n-1);

    EV << "Forwarding message " << msg << " on port out[" << k << "]\n";
    send(msg, "gate$o", k);
}

/*      stack<int> messageRoute
 *      messageRoute.push();
 *      messageRoute.push();
 *      messageRoute.push();
 *      messageRoute.push();
 *
 * void PD_node2::forwardMessage
 * {
 *      int nextNode = messageRoute.top();
 *      send(msg, "gate$o", k); how to implement nextNode here?
 *      messageRoute.top();
 * }
 */

