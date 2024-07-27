@Select(
        clazz = ${clazz}.class,
        attributes = {
            ${attributes?map(attribute -> '"' + attribute + '"')?join(",\n\t\t")}
        }
    )