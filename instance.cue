import "text/template"

// Preprocess input to include field indices
#ServiceWithIndices: {
    name: #Service.name
    methods: [for m in #Service.methods {
        name: m.name
        input: {
            name: m.input.name
            fields: [for i, f in m.input.fields {
                name: f.name
                type: f.type
                index: i + 1
            }]
        }
        output: {
            name: m.output.name
            fields: [for i, f in m.output.fields {
                name: f.name
                type: f.type
                index: i + 1
            }]
        }
    }]
}

// Protobuf Template
#ProtoTemplate: template.Execute("""
    syntax = "proto3";
    package {{ .service.name }};

    {{- range .service.methods }}
    message {{ .input.name }} {
        {{- range .input.fields }}
        {{ .type }} {{ .name }} = {{ .index }};
        {{- end }}
    }

    message {{ .output.name }} {
        {{- range .output.fields }}
        {{ .type }} {{ .name }} = {{ .index }};
        {{- end }}
    }

    {{- end }}

    service {{ .service.name }} {
        {{- range .service.methods }}
        rpc {{ .name }} ({{ .input.name }}) returns ({{ .output.name }});
        {{- end }}
    }
""", {
    service: #ServiceWithIndices
})

// WIT Template
#WITTemplate: template.Execute("""
    interface {{ .service.name }} {
    {{- range .service.methods }}
    {{ .name }}: func(input: struct {
        {{- range .input.fields }}
        {{ .name }}: {{ .type }},
        {{- end }}
    }) -> struct {
        {{- range .output.fields }}
        {{ .name }}: {{ .type }},
        {{- end }}
    };
    {{- end }}
}
""", {
    service: #ServiceWithIndices
})

// Service Definition
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
                    { name: "name", type: "string" },
                    { name: "email", type: "string" }
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

// Combine Outputs
outputs: {
    protobuf: #ProtoTemplate
    wit: #WITTemplate
}

