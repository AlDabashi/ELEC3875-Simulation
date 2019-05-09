/*
 * innerNode3.cc
 *
 *  Created on: 7 Feb 2019
 *      Author: el16ahd
 */

// This node used in BT_Fibre_Networks3 and BT_Fibre_Networks4

#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;

class innerNode3 : public cSimpleModule
{
  protected:
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
    virtual void forwardMessage(cMessage *msg);
};

Define_Module(innerNode3);

void innerNode3::initialize()
{
    if (strcmp("Leeds", getName()) == 0) { // Let tic1 send the first message
            cMessage *msg = new cMessage("tictocMsg");
            int n = gateSize("gate");   // Message sent on random out gate
            int k = intuniform(0, n-1); // Picking a random number between 0 and size of "out[]" gate
            send(msg, "gate$o", k);     // $o means output since Manchester is transmitting
    }
}

void innerNode3::handleMessage(cMessage *msg)
{
    if (getIndex() == 3) {
        EV << "Message " << msg << " arrived.\n";
        delete msg;
    }
    else {
        forwardMessage(msg);
    }
}

void innerNode3::forwardMessage(cMessage *msg)
{
    int n = gateSize("gate");   // Message sent on random gate
    int k = intuniform(0, n-1); // Picking a random number between 0 and size of "gate[]"

    EV << "Forwarding message " << msg << " on gate[" << k << "]\n";
    send(msg, "gate$o", k); // $i/$o means input/output part of a bidirectional
}




















