witOutput: """
interface {{ .name }} {
    {{ for _, m in .methods }}
    {{ m.name }}: func(input: struct {
        {{ for f in m.input.fields }}
        {{ f.name }}: {{ f.type }},
        {{ end }}
    }) -> struct {
        {{ for f in m.output.fields }}
        {{ f.name }}: {{ f.type }},
        {{ end }}
    };
    {{ end }}
}
"""

