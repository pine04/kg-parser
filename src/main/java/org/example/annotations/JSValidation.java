package org.example.annotations;

import org.neo4j.driver.types.Node;

import java.util.HashSet;
import java.util.List;
import java.util.Map;

public class JSValidation extends AnnotationModel {
    private static final List<String> defaultImports = List.of(new String[] {
        "jda.modules.mccl.syntax.JSValidation"
    });

    private boolean optional;
    private String regex;
    private String invalidMsg;

    public static JSValidation nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        JSValidation jsValidation = new JSValidation();
        jsValidation.optional = Boolean.parseBoolean(nodeProperties.getOrDefault("optional", false).toString());
        jsValidation.regex = nodeProperties.getOrDefault("regex", "").toString();
        jsValidation.invalidMsg = nodeProperties.getOrDefault("invalidMsg", "").toString();
        jsValidation.imports = new HashSet<>(defaultImports);

        return jsValidation;
    }

    @Override
    protected String getTemplateName() {
        return "templates/JSValidation.ftlh";
    }

    public boolean getOptional() {
        return optional;
    }

    public String getRegex() {
        return regex;
    }

    public String getInvalidMsg() {
        return invalidMsg;
    }
}
