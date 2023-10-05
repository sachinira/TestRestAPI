import ballerina/http;
import ballerina/io;

configurable string clientCertFile = ? ;
configurable string clientPrivateKeyFile = ? ;
configurable string clientPublicCert = ? ;

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
