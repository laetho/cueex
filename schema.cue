#Service: {
    name: string
    methods: [...#Method]
}

#Method: {
    name: string
    input: #Message
    output: #Message
}

#Message: {
    name: string
    fields: [...#Field]
}

#Field: {
    name: string
    type: string
}
