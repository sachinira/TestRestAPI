import ballerina/http;

configurable string age = ?;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # + return - Json with configured age
    resource function get age() returns json {
        // Send a response back to the caller with the configuration value.
        return {
            value: age
        };
    }
}
