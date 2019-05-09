/*
 * PD_node3.cc
 *
 *  Created on: 25 Feb 2019
 *      Author: el16ahd
 */

// This node/module allows for source routing
// Need to include functionality to check the stack "messageRoute"
#include <string.h>
#include <omnetpp.h>
#include <stack>
#include <iostream>

#include "PD_message_m.h"

using namespace omnetpp;
using namespace std;

class PD_node3: public cSimpleModule {
protected:
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
    //virtual void forwardMessage(cMessage *msg);
};

Define_Module(PD_node3);

stack<int> messageRoute;

void PD_node3::initialize() {
    // Choose source node below between the " " in blue.
    if (strcmp("node1", getName()) == 0) {
        PD_message *msg = new PD_message("Msg");
        msg->setRouteArraySize(2);
        msg->setRoute(0,3); // Same as saying setRoute[0] = 3
        msg->setRoute(1,2);
        send(msg, "gate$o", 0);
    }
}

void PD_node3::handleMessage(cMessage *msg) {
    PD_message *tmsg =  check_and_cast<PD_message*>(msg);
    if (tmsg->getRouteArraySize() + 1 != tmsg->getHops()) {
        send(tmsg, "gate$o", tmsg->getRoute(tmsg->getHops()));
        tmsg->setHops(tmsg->getHops()+1);
    } else {
        endSimulation();
    }
}



//////////////////// Archive, don't delete just copy and paste to use above ////////////////////
/*

 //////////////////// Take 1 ////////////////////
 void PD_node3::handleMessage(cMessage *msg)
 {
 if (strcmp("node4", getName()) == 0) // i.e. Choose destination node here between the " "
 {
 EV << "Message " << msg << " arrived.\n";
 delete msg;
 endSimulation();
 }
 else
 {
 forwardMessage(msg);
 }
 }

 void PD_node3::forwardMessage(cMessage *msg)
 {
 // In this example, we just pick a random gate to send it on.
 // We draw a random number between 0 and the size of gate `out[]'.
 int n = gateSize("gate");
 int k = intuniform(0, n-1);

 EV << "Forwarding message " << msg << " on port out[" << k << "]\n";
 send(msg, "gate$o", k);
 }



 //////////////////// Take 2 ////////////////////
 void PD_node3::initialize()
 {
 // Choose Source node below between the " " in blue.
 if (strcmp("node6", getName()) == 0)
 {
 cMessage *msg = new cMessage("tictocMsg");
 send(msg, "gate$o", 0);
 }
 // This doesn't work, perhaps because this "initialize" function is called at every node
 // so the stack is always refilled
 // 2nd node, then 3rd and so on.
 messageRoute.push(2); // Second node
 }

 void PD_node3::handleMessage(cMessage *msg)
 {
 if (strcmp("node1", getName()) == 0) // i.e. Choose destination node here between the " "
 {
 EV << "Message " << msg << " arrived.\n";
 delete msg;
 endSimulation();
 }
 else
 {
 forwardMessage(msg);
 }
 }

 void PD_node3::forwardMessage(cMessage *msg)
 {
 int nextNode = messageRoute.top();
 send(msg, "gate$o", nextNode);
 messageRoute.top();
 }
 */
