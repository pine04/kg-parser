package org.example.annotations;

import org.neo4j.driver.types.Node;

import java.util.*;

public class ControllerDescModel extends AnnotationModel {
    private static final List<String> defaultImports = List.of(new String[] {
        "jda.modules.mccl.syntax.controller.ControllerDesc",
        "jda.modules.mccl.syntax.controller.ControllerDesc.*",
        "jda.mosa.controller.*"
    });

    private String controller;
    private String openPolicy;
    private boolean isDataFieldStateListener;

    public static ControllerDescModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        ControllerDescModel controllerDescModel = new ControllerDescModel();
        controllerDescModel.controller = nodeProperties.getOrDefault("controller", "ControllerBasic.class").toString();
        controllerDescModel.openPolicy = nodeProperties.getOrDefault("openPolicy", "OpenPolicy.I").toString();
        controllerDescModel.isDataFieldStateListener = Boolean.parseBoolean(nodeProperties.getOrDefault("isDataFieldStateListener", false).toString());
        controllerDescModel.imports = new HashSet<>(defaultImports);

        return controllerDescModel;
    }

    @Override
    public String getTemplateName() {
        return "templates/ControllerDesc.ftlh";
    }

    public String getController() {
        return controller;
    }

    public String getOpenPolicy() {
        return openPolicy;
    }

    public boolean getIsDataFieldStateListener() {
        return isDataFieldStateListener;
    }
}