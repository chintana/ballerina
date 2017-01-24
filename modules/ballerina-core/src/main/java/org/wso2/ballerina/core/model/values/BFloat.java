/*
*  Copyright (c) 2016, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
*
*  WSO2 Inc. licenses this file to you under the Apache License,
*  Version 2.0 (the "License"); you may not use this file except
*  in compliance with the License.
*  You may obtain a copy of the License at
*
*    http://www.apache.org/licenses/LICENSE-2.0
*
*  Unless required by applicable law or agreed to in writing,
*  software distributed under the License is distributed on an
*  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
*  KIND, either express or implied.  See the License for the
*  specific language governing permissions and limitations
*  under the License.
*/
package org.wso2.ballerina.core.model.values;

/**
 * The {@code BFloat} represents a float value in Ballerina
 *
 * @since 0.8.0
 */
public final class BFloat extends BValueType {

    private float value;

    public BFloat(float value) {
        this.value = value;
    }

    @Override
    public int intValue() {
        return 0;
    }

    @Override
    public long longValue() {
        return 0;
    }

    @Override
    public float floatValue() {
        return this.value;
    }

    @Override
    public double doubleValue() {
        return (double) this.value;
    }

    @Override
    public boolean booleanValue() {
        return false;
    }

    @Override
    public String stringValue() {
        return Float.toString(value);
    }

    @Override
    public boolean equals(Object obj) {
        return ((BFloat) obj).floatValue() == value;
    }
}
