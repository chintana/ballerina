// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

# Represents a WebSocket caller.
#
# + id - The connection id
# + negotiatedSubProtocol - The subprotocols negoriated with the server
# + isSecure - `true` if the connection is secure
# + isOpen - `true` if the connection is open
# + attributes - A map to store connection related attributes
public type WebSocketCaller client object {

    @readonly public string id = "";
    @readonly public string negotiatedSubProtocol = "";
    @readonly public boolean isSecure = false;
    @readonly public boolean isOpen = false;
    @readonly public map<any> attributes = {};

    private WebSocketConnector conn = new;

    # Push text to the connection.
    #
    # + data - Data to be sent, if byte[] it is converted to a UTF-8 string for sending
    # + finalFrame - True if this is a final frame of a (long) message
    # + return  - `error` if an error occurs when sending
    public remote function pushText(string|json|xml|boolean|int|float|byte|byte[] data, boolean finalFrame = true) returns error? {
        return self.conn.pushText(data, finalFrame);
    }

    # Push binary data to the connection.
    #
    # + data - Binary data to be sent
    # + finalFrame - True if this is a final frame of a (long) message
    # + return - `error` if an error occurs when sending
    public remote function pushBinary(byte[] data, boolean finalFrame = true) returns error? {
        return self.conn.pushBinary(data, finalFrame);
    }

    # Ping the connection.
    #
    # + data - Binary data to be sent.
    # + return - `error` if an error occurs when sending
    public remote function ping(byte[] data) returns error? {
        return self.conn.ping(data);
    }

    # Send pong message to the connection.
    #
    # + data - Binary data to be sent
    # + return - `error` if an error occurs when sending
    public remote function pong(byte[] data) returns error? {
        return self.conn.pong(data);
    }

    # Close the connection.
    #
    # + statusCode - Status code for closing the connection
    # + reason - Reason for closing the connection
    # + timeoutInSecs - Time to waits for the close frame from the remote endpoint before closing the connection.
    #                   If the timeout exceeds then the connection is terminated even though a close frame
    #                   is not received from the remote endpoint. If the value < 0 (eg: -1) the connection waits
    #                   until a close frame is received. If WebSocket frame is received from the remote endpoint
    #                   within waiting period the connection is terminated immediately.
    # + return - `error` if an error occurs when sending
    public remote function close(int? statusCode = 1000, string? reason = (), int timeoutInSecs = 60) returns error? {
        return self.conn.close(statusCode = statusCode, reason = reason, timeoutInSecs = timeoutInSecs);
    }
};
