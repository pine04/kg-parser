@ViewDesc(
        formTitle = "${formTitle}",
        domainClassLabel = "${domainClassLabel}",
        imageIcon = "${imageIcon}",
        view = ${view},
        viewType = ${viewType},
        parent = ${parent},
        topX = ${topX?c},
        topY = ${topY?c},
        widthRatio = ${widthRatio?c}f,
        heightRatio = ${heightRatio?c}f,
        children = {
            ${children?join(",\n\t\t")}
        },
        excludeComponents = {
            ${excludeComponents?join(",\n\t\t")}
        },
        props = {
            ${props?join(",\n\t\t")}
        }
    )