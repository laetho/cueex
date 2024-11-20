import "github.com/laetho/cueex/proto-gen"
import "github.com/laetho/cueex/wit-gen"

#Service: {
    name: "UserService"
    methods: [
        {
            name: "GetUser"
            input: {
                name: "GetUserRequest"
                fields: [
                    { name: "userId", type: "string" }
                ]
            }
            output: {
                name: "GetUserResponse"
                fields: [
                    { name: "name", type: "string" },
                    { name: "email", type: "string" },
                    { name: "age", type: "int32" }
                ]
            }
        },
        {
            name: "UpdateUser"
            input: {
                name: "UpdateUserRequest"
                fields: [
                    { name: "userId", type: "string" },
                    { name: "email", type: "string" },
                    { name: "age", type: "int32" }
                ]
            }
            output: {
                name: "UpdateUserResponse"
                fields: [
                    { name: "success", type: "bool" }
                ]
            }
        }
    ]
}
