import ballerinax/jms;

// Initialize a JMS connection with the provider
jms:Connection jmsConnection = new ({
        initialContextFactory: "org.apache.activemq.artemis.jndi.ActiveMQInitialContextFactory",
        providerUrl: "tcp://localhost:61616"
    });

// Initialize a JMS session on top of the created connection
jms:Session jmsSession = new (jmsConnection, {
        acknowledgementMode: "AUTO_ACKNOWLEDGE"
    });

jms:TopicPublisher publisher = new(jmsSession, topicPattern = "testDurableTopicSubscriberPublisher6");

public function sendTextMessage () {
    // Create a Text message.
    var msg = jmsSession.createTextMessage("Test Text");
    if (msg is jms:Message) {
         // Send the Ballerina message to the JMS provider.
         checkpanic publisher->send(msg);
    } else {
         panic msg;
    }
}
