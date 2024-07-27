@SystemDesc(
    appName = "${appName}",
    splashScreenLogo = "${splashScreenLogo}",
    language = ${language},
    dsDesc = ${dsDesc},
    orgDesc = ${orgDesc},
    securityDesc = ${securityDesc},
    setUpDesc = ${setUpDesc},
    modules = {
        ${modules?map(module -> module + ".class")?join(",\n\t\t")}
    },
    sysModules = {
        ${sysModules?map(module -> module + ".class")?join(",\n\t\t")}
    }
)