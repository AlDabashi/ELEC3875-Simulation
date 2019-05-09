/*
 * innerNode2.cc
 *
 *  Created on: 7 Feb 2019
 *      Author: el16ahd
 */

// This node used in BT_Fibre_Networks3, 4, 5 & 6

#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;

class innerNode2 : public cSimpleModule
{
  protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual void forwardMessage(cMessage *msg);
};

Define_Module(innerNode2);

void innerNode2::initialize()
{
    if (strcmp("Leeds", getName()) == 0) { // Let tic1 send the first message
            cMessage *msg = new cMessage("tictocMsg");
            int n = gateSize("gate");   // Message sent on random out gate
            int k = intuniform(0, n-1); // Picking a random number between 0 and size of "out[]" gate
            send(msg, "gate$o", k);     // $o means output since Manchester is transmitting
    }
}

void innerNode2::handleMessage(cMessage *msg)
{
    if (getIndex() == 3) {
        EV << "Message " << msg << " arrived.\n";
        delete msg;
    }
    else {
        forwardMessage(msg);
    }
}

void innerNode2::forwardMessage(cMessage *msg)
{
    int n = gateSize("gate");   // Message sent on random gate
    int k = intuniform(0, n-1); // Picking a random number between 0 and size of "gate[]"

    EV << "Forwarding message " << msg << " on gate[" << k << "]\n";
    send(msg, "gate$o", k); // $i/$o means input/output part of a bidirectional
}

