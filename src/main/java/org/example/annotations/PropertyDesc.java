package org.example.annotations;

import org.neo4j.driver.types.Node;

import java.util.HashSet;
import java.util.List;
import java.util.Map;

public class PropertyDesc extends AnnotationModel {
    private static final List<String> defaultImports = List.of(new String[] {
        "jda.modules.common.types.properties.PropertyDesc",
        "jda.modules.common.types.properties.PropertyName"
    });

    private String name;
    private String valueAsString;
    private String valueType;

    public static PropertyDesc nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        PropertyDesc model = new PropertyDesc();
        model.name = nodeProperties.getOrDefault("name", "").toString();
        model.valueAsString = nodeProperties.getOrDefault("valueAsString", "").toString();
        model.valueType = nodeProperties.getOrDefault("valueType", "").toString();
        model.imports = new HashSet<>(defaultImports);

        return model;
    }

    @Override
    protected String getTemplateName() {
        return "templates/PropertyDesc.ftlh";
    }

    public String getName() {
        return name;
    }

    public String getValueAsString() {
        return valueAsString;
    }

    public String getValueType() {
        return valueType;
    }
}
