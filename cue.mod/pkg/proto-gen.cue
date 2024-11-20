package proto_gen

#ProtoTemplate: {
    output: """
    syntax = "proto3";
    package {{service.name}};

    {{ for m in service.methods }}
    message {{m.input.name}} {
        {{ for i, f in m.input.fields }}
        {{ f.type }} {{ f.name }} = {{ i + 1 }};
        {{ end }}
    }

    message {{m.output.name}} {
        {{ for i, f in m.output.fields }}
        {{ f.type }} {{ f.name }} = {{ i + 1 }};
        {{ end }}
    }

    service {{service.name}} {
        {{ for m in service.methods }}
        rpc {{m.name}} ({{m.input.name}}) returns ({{m.output.name}});
        {{ end }}
    }
    """
}

