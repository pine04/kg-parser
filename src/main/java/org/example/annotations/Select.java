package org.example.annotations;

import org.example.Utils;
import org.neo4j.driver.types.Node;

import java.util.HashSet;
import java.util.List;
import java.util.Map;

public class Select extends AnnotationModel {
    private static final List<String> defaultImports = List.of(new String[] {
        "jda.modules.dcsl.syntax.Select"
    });

    private String clazz;
    private String[] attributes;

    public static Select nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        Select model = new Select();
        model.clazz = nodeProperties.getOrDefault("clazz", "").toString();
        model.attributes = Utils.splitIfNotEmpty(nodeProperties.getOrDefault("attributes", "").toString());
        model.imports = new HashSet<>();
        model.imports.addAll(defaultImports);
        model.imports.addAll(List.of(Utils.splitIfNotEmpty(nodeProperties.getOrDefault("requiredImport", "").toString())));

        return model;
    }

    @Override
    protected String getTemplateName() {
        return "templates/Select.ftlh";
    }

    public String getClazz() {
        return clazz;
    }

    public String[] getAttributes() {
        return attributes;
    }
}
