package org.example.annotations;

import org.neo4j.driver.types.Node;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

public class ControllerDescModel extends AnnotationModel {
    private String controller;
    private String openPolicy;
    private boolean isDataFieldStateListener;

    private static String[] defaultImports = {
        "jda.mosa.controller.*",
        "jda.modules.mccl.syntax.controller.ControllerDesc.*"
    };

    public String getController() {
        return controller;
    }

    public void setController(String controller) {
        this.controller = controller;
    }

    public String getOpenPolicy() {
        return openPolicy;
    }

    public void setOpenPolicy(String openPolicy) {
        this.openPolicy = openPolicy;
    }

    public boolean getIsDataFieldStateListener() {
        return isDataFieldStateListener;
    }

    public void setIsDataFieldStateListener(boolean isDataFieldStateListener) {
        this.isDataFieldStateListener = isDataFieldStateListener;
    }

    public static ControllerDescModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        ControllerDescModel controllerDescModel = new ControllerDescModel();
        controllerDescModel.setImports(new ArrayList<>(Arrays.asList(defaultImports)));
        controllerDescModel.setController(nodeProperties.getOrDefault("controller", "ControllerBasic.class").toString());
        controllerDescModel.setOpenPolicy(nodeProperties.getOrDefault("openPolicy", "OpenPolicy.I").toString());
        controllerDescModel.setIsDataFieldStateListener((boolean) nodeProperties.getOrDefault("isDataFieldStateListener", false));

        return controllerDescModel;
    }

    @Override
    public String getTemplateName() {
        return "templates/ControllerDesc.ftlh";
    }
}