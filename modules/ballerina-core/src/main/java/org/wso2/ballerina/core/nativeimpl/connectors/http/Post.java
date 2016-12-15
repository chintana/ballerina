/*
 * Copyright (c) 2015, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.wso2.ballerina.core.nativeimpl.connectors.http;

//import org.osgi.service.component.annotations.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.wso2.ballerina.core.interpreter.Context;
//import org.wso2.ballerina.core.model.types.TypeEnum;
import org.wso2.ballerina.core.model.values.BValue;
//import org.wso2.ballerina.core.nativeimpl.annotations.Argument;
//import org.wso2.ballerina.core.nativeimpl.annotations.BallerinaAction;
import org.wso2.ballerina.core.nativeimpl.connectors.AbstractNativeAction;
import org.wso2.ballerina.core.nativeimpl.connectors.NativeConnector;
import org.wso2.ballerina.core.runtime.internal.ServiceContextHolder;
import org.wso2.carbon.messaging.CarbonMessage;
import org.wso2.carbon.messaging.Constants;
import org.wso2.carbon.messaging.MessageProcessorException;

import java.net.MalformedURLException;
import java.net.URL;

///**
// * Execute post method to given URI
// */
/*@BallerinaAction(
        packageName = "ballerina.net.http",
        actionName = "post",
        args = {
                @Argument(name = "connector", type = TypeEnum.CONNECTOR),
                @Argument(name = "path", type = TypeEnum.STRING),
                @Argument(name = "message", type = TypeEnum.MESSAGE)
        },
        returnType = { TypeEnum.MESSAGE })*/
/*@Component(
        name = "func.net.http.sendPost",
        immediate = true,
        service = AbstractNativeAction.class)*/

/**
 * dsf
 */
public class Post extends AbstractNativeAction {

    private static final Logger LOGGER = LoggerFactory.getLogger(Post.class);

    private String path;

    /**
     * Constructing HTTP Post method
     * @param connector NativeConnector HTTP
     * @param path resource path
     */
    public Post(NativeConnector connector, String path) {
        super(connector);
        this.path = path;
    }

    @Override
    public BValue[] execute(Context context) {
        LOGGER.debug("Executing Native Action SendPost ....");
        CarbonMessage message = context.getCarbonMessage();

        String uri = ((HTTPConnector) connector).getServiceUri() + path;

        processRequest(message, uri);

        try {
            ServiceContextHolder.getInstance().getSender().send(message, context.getBalCallback());
        } catch (MessageProcessorException e) {
            LOGGER.error("Cannot Send Message to Endpoint ", e);
        }
        return new BValue[0];
    }

    private void processRequest(CarbonMessage cMsg, String uri) {

        URL url = null;
        try {
            url = new URL(uri);
        } catch (MalformedURLException e) {
            LOGGER.error("URL is malformed ", e);
            return;
        }
        String host = url.getHost();
        int port = (url.getPort() == -1) ? 80 : url.getPort();
        String urlPath = url.getPath();

        cMsg.setProperty(Constants.HOST, host);
        cMsg.setProperty(Constants.PORT, port);
        cMsg.setProperty(Constants.TO, urlPath);

        //Check for PROTOCOL property and add if not exist
        if (cMsg.getProperty(Constants.PROTOCOL) == null) {
            cMsg.setProperty(Constants.PROTOCOL, org.wso2.carbon.transport.http.netty.common.Constants.PROTOCOL_NAME);
        }

        if (port != 80) {
            cMsg.getHeaders().set(Constants.HOST, host + ":" + port);
        } else {
            cMsg.getHeaders().set(Constants.HOST, host);
        }
    }

}
