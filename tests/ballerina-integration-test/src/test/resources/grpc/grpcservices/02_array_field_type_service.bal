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
import ballerina/grpc;
import ballerina/io;

listener grpc:Server server2 = new ({
    host:"localhost",
    port:9092
});

@grpc:ServiceDescriptor {
    descriptor: <string>descriptorMap2[DESCRIPTOR_KEY_2],
    descMap: descriptorMap2
}
service HelloWorld3 on server2 {

    resource function testIntArrayInput(grpc:Caller caller, TestInt req) {
        io:println(req);
        int[] numbers = req.values;
        int result = 0;
        foreach number in numbers {
            result = result + number;
        }
        error? err = caller->send(result);
        if (err is error) {
            io:println("Error from Connector: " + err.reason());
        } else {
            io:println("Result: " + result);
        }
        _ = caller->complete();
    }

    resource function testStringArrayInput(grpc:Caller caller, TestString req) {
        io:println(req);
        string[] values = req.values;
        string result = "";
        foreach value in values {
            result = result + "," + value;
        }
        error? err = caller->send(result);
        if (err is error) {
            io:println("Error from Connector: " + err.reason());
        } else {
            io:println("Result: " + result);
        }
        _ = caller->complete();
    }

    resource function testFloatArrayInput(grpc:Caller caller, TestFloat req) {
        io:println(req);
        float[] values = req.values;
        float result = 0.0;
        foreach value in values {
            result = result + value;
        }
        error? err = caller->send(result);
        if (err is error) {
            io:println("Error from Connector: " + err.reason());
        } else {
            io:println("Result: " + result);
        }
        _ = caller->complete();
    }

    resource function testBooleanArrayInput(grpc:Caller caller, TestBoolean req) {
        io:println(req);
        boolean[] values = req.values;
        boolean result = false;
        foreach value in values {
            result = result || value;
        }
        error? err = caller->send(result);
        if (err is error) {
            io:println("Error from Connector: " + err.reason());
        } else {
            io:println("Result: " + result);
        }
        _ = caller->complete();
    }

    resource function testStructArrayInput(grpc:Caller caller, TestStruct req) {
        io:println(req);
        A[] values = req.values;
        string result = "";
        foreach value in values {
            result = result + "," + value.name;
        }
        error? err = caller->send(result);
        if (err is error) {
            io:println("Error from Connector: " + err.reason());
        } else {
            io:println("Result: " + result);
        }
        _ = caller->complete();
    }

    resource function testIntArrayOutput(grpc:Caller caller) {
        TestInt intArray = {values:[1, 2, 3, 4, 5]};
        error? err = caller->send(intArray);
        if (err is error) {
            io:println("Error from Connector: " + err.reason());
        } else {
            io:println(intArray);
        }
        _ = caller->complete();
    }

    resource function testStringArrayOutput(grpc:Caller caller) {
        TestString stringArray = {values:["A", "B", "C"]};
        error? err = caller->send(stringArray);
        if (err is error) {
            io:println("Error from Connector: " + err.reason());
        } else {
            io:println(stringArray);
        }
        _ = caller->complete();
    }

    resource function testFloatArrayOutput(grpc:Caller caller) {
        TestFloat floatArray = {values:[1.1, 1.2, 1.3, 1.4, 1.5]};
        error? err = caller->send(floatArray);
        if (err is error) {
            io:println("Error from Connector: " + err.reason());
        } else {
            io:println(floatArray);
        }
        _ = caller->complete();
    }

    resource function testBooleanArrayOutput(grpc:Caller caller) {
        TestBoolean booleanArray = {values:[true, false, true]};
        error? err = caller->send(booleanArray);
        if (err is error) {
            io:println("Error from Connector: " + err.reason());
        } else {
            io:println(booleanArray);
        }
        _ = caller->complete();
    }

    resource function testStructArrayOutput(grpc:Caller caller) {
        A a1 = {name:"Sam"};
        A a2 = {name:"John"};
        TestStruct structArray = {values:[a1, a2]};
        error? err = caller->send(structArray);
        if (err is error) {
            io:println("Error from Connector: " + err.reason());
        } else {
            io:println(structArray);
        }
        _ = caller->complete();
    }
}

type TestInt record {
    int[] values = [];
};

type TestString record {
    string[] values = [];
};

type TestFloat record {
    float[] values = [];
};

type TestBoolean record {
    boolean[] values = [];
};

type TestStruct record {
    A[] values = [];
};

type A record {
    string name = "";
};

const string DESCRIPTOR_KEY_2 = "HelloWorld3.proto";
map<any> descriptorMap2 =
{
    "HelloWorld3.proto":"0A1148656C6C6F576F726C64332E70726F746F120C6772706373657276696365731A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F22210A0754657374496E7412160A0676616C756573180120032803520676616C75657322240A0A54657374537472696E6712160A0676616C756573180120032809520676616C75657322230A0954657374466C6F617412160A0676616C756573180120032802520676616C75657322250A0B54657374426F6F6C65616E12160A0676616C756573180120032808520676616C75657322350A0A5465737453747275637412270A0676616C75657318012003280B320F2E6772706373657276696365732E41520676616C75657322170A014112120A046E616D6518012001280952046E616D653284060A0B48656C6C6F576F726C643312470A1174657374496E744172726179496E70757412152E6772706373657276696365732E54657374496E741A1B2E676F6F676C652E70726F746F6275662E496E74363456616C7565124E0A1474657374537472696E674172726179496E70757412182E6772706373657276696365732E54657374537472696E671A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565124B0A1374657374466C6F61744172726179496E70757412172E6772706373657276696365732E54657374466C6F61741A1B2E676F6F676C652E70726F746F6275662E466C6F617456616C7565124E0A1574657374426F6F6C65616E4172726179496E70757412192E6772706373657276696365732E54657374426F6F6C65616E1A1A2E676F6F676C652E70726F746F6275662E426F6F6C56616C7565124E0A14746573745374727563744172726179496E70757412182E6772706373657276696365732E546573745374727563741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756512430A1274657374496E7441727261794F757470757412162E676F6F676C652E70726F746F6275662E456D7074791A152E6772706373657276696365732E54657374496E7412490A1574657374537472696E6741727261794F757470757412162E676F6F676C652E70726F746F6275662E456D7074791A182E6772706373657276696365732E54657374537472696E6712470A1474657374466C6F617441727261794F757470757412162E676F6F676C652E70726F746F6275662E456D7074791A172E6772706373657276696365732E54657374466C6F6174124B0A1674657374426F6F6C65616E41727261794F757470757412162E676F6F676C652E70726F746F6275662E456D7074791A192E6772706373657276696365732E54657374426F6F6C65616E12490A157465737453747275637441727261794F757470757412162E676F6F676C652E70726F746F6275662E456D7074791A182E6772706373657276696365732E54657374537472756374620670726F746F33",

    "google/protobuf/wrappers.proto":
    "0A0E77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33",

    "google/protobuf/empty.proto":
    "0A0B656D7074792E70726F746F120F676F6F676C652E70726F746F62756622070A05456D70747942540A13636F6D2E676F6F676C652E70726F746F627566420A456D70747950726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"

};
