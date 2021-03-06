/*
 * Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.ballerinalang.stdlib.streams.nativeimpl;

import org.ballerinalang.model.values.BInteger;
import org.ballerinalang.model.values.BMap;
import org.ballerinalang.model.values.BValue;
import org.ballerinalang.test.util.BCompileUtil;
import org.ballerinalang.test.util.BRunUtil;
import org.ballerinalang.test.util.CompileResult;
import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

/**
 * This contains methods to test OrderBy query behaviour in Ballerina Streaming V2.
 *
 * @since 0.985.0
 */
public class BallerinaStreamsV2OrderByTest {

    private CompileResult result;

    @BeforeClass
    public void setup() {
        result = BCompileUtil.compile("test-src/native/streamingv2-native-orderby-test.bal");
    }

    @Test(description = "Test streaming query with OrderBy.")
    public void testOrderByQuery() {
        BValue[] outputEvents = BRunUtil.invoke(result, "startOrderByQuery");
        Assert.assertNotNull(outputEvents);
        Assert.assertEquals(outputEvents.length, 6);
        Assert.assertEquals(((BMap) outputEvents[0]).getMap().get("age"), new BInteger(45));
        Assert.assertEquals(((BMap) outputEvents[1]).getMap().get("age"), new BInteger(45));
        Assert.assertEquals(((BMap) outputEvents[2]).getMap().get("age"), new BInteger(30));
        Assert.assertEquals(((BMap) outputEvents[3]).getMap().get("age"), new BInteger(45));
        Assert.assertEquals(((BMap) outputEvents[4]).getMap().get("age"), new BInteger(45));
        Assert.assertEquals(((BMap) outputEvents[5]).getMap().get("age"), new BInteger(30));
    }
}
