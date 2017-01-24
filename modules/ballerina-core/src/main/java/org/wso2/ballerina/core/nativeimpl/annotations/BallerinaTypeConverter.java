/*
 * Copyright (c) 2017, WSO2 Inc. (http://wso2.com) All Rights Reserved.
 * <p>
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.wso2.ballerina.core.nativeimpl.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Represents Native Ballerina TypeConverter.
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface BallerinaTypeConverter {

    /**
     * Package name of the {@code {@link org.wso2.ballerina.core.nativeimpl.AbstractNativeTypeConverter }}.
     * Default is "".
     *
     * @return package name of the typeConverter.
     */
    String packageName() default "";

    /**
     * TypeConverter name of the {@code {@link org.wso2.ballerina.core.nativeimpl.AbstractNativeTypeConverter }}.
     *
     * @return typeConverter name.
     */
    String typeConverterName();

    /**
     * Argument of the typeConverter.
     *
     * @return returns arguments of the typeConverter.
     */
    Argument[] args() default {};

    /**
     * Return types of the typeConverter.
     *
     * @return return types.
     */
    ReturnType[] returnType() default {};

    /**
     * Indicate Native typeConverter is public or not.
     *
     * @return indicate native typeConverter is public or not.
     */
    boolean isPublic() default false;

    /**
     * Constants related this typeConverter.
     *
     * @return
     */
    BallerinaConstant[] consts() default {};
}

