@ModuleDescriptor(
    name = "${name}",
    modelDesc = ${modelDesc},
    viewDesc = ${viewDesc},
    controllerDesc = ${controllerDesc},
    setUpDesc = ${setUpDesc},
    subtypes = {
        ${subtypes?map(type -> type + ".class")?join(",\n\t\t")}
    },
    type = ${type},
    isPrimary = ${isPrimary?c}
)