import ballerina/http;
import ballerina/os;
import ballerina/io;

configurable string clientCertFile = os:getEnv("clientCertFile") ;
configurable string clientPrivateKeyFile = os:getEnv("clientPrivateKeyFile") ;
configurable string clientPublicCert = os:getEnv("clientPublicCert") ;

listener http:Listener securedEP = new (9090);

service / on securedEP {
    resource function get getInfo() returns json|error {
        http:Client blsClient = check new ("https://services.bls.ch/services/rest",
            secureSocket = {
                key: {
                    certFile: clientCertFile,
                    keyFile: clientPrivateKeyFile
                },
                cert: clientPublicCert,
                enable: true
            });
        http:Response reports = check blsClient->/;
        io:println((check reports.getJsonPayload()).toString());
    }
}
