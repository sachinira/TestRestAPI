import ballerina/http;
import ballerina/io;

configurable string clientcertfile = ?;
configurable string clientprivatekeyile = ?;
configurable string clientpubliccert = ?;

listener http:Listener securedEP = new (9090);

service / on securedEP {
    resource function get age() returns json|error {
        http:Client blsClient = check new ("https://services.bls.ch/services/rest",
            secureSocket = {
            key: {
                certFile: clientcertfile,
                keyFile: clientprivatekeyile
            },
            cert: clientpubliccert,
            enable: true

        },
        httpVersion = "1.1"
    );
        http:Response reports = check blsClient->/;
        io:println((check reports.getJsonPayload()).toString());
    }
}
