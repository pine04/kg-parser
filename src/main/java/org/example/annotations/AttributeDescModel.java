package org.example.annotations;

import org.example.KnowledgeGraph;
import org.neo4j.driver.Record;
import org.neo4j.driver.types.Node;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

public class AttributeDescModel extends AnnotationModel {
    private static final List<String> defaultImports = List.of(new String[] {
        "jda.modules.mccl.syntax.view.AttributeDesc",
        "jda.modules.mccl.syntax.MCCLConstants.AlignmentX",
        "jda.modules.mccl.syntax.JSValidation",
        "jda.modules.dcsl.syntax.Select",
        "jda.modules.mccl.syntax.InputTypes",
        "jda.modules.common.types.Null",
        "jda.modules.mccl.syntax.controller.ControllerDesc",
        "jda.mosa.view.assets.datafields.list.JComboField",
        "jda.mosa.view.assets.panels.DefaultPanel"
    });

    private String id;
    private String label;
    private String ref;
    private String type;
    private int width;
    private int height;
    private String alignX;
    private boolean isStateEventSource;
    private String controllerDesc;
    private boolean displayOidWithBoundValue;
    private boolean loadOidWithBoundValue;
    private String inputType;
    private String jsValidation;

    public static AttributeDescModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();
        String nodeId = node.elementId();

        AttributeDescModel model = new AttributeDescModel();
        model.id = nodeProperties.getOrDefault("id", "␀").toString();
        model.label = nodeProperties.getOrDefault("label", "").toString();
        model.type = nodeProperties.getOrDefault("type", "Null").toString();
        model.width = Integer.parseInt(nodeProperties.getOrDefault("width", "-1").toString());
        model.height = Integer.parseInt(nodeProperties.getOrDefault("height", "-1").toString());
        model.alignX = nodeProperties.getOrDefault("alignX", "AlignmentX.Left").toString();
        model.isStateEventSource = Boolean.parseBoolean(nodeProperties.getOrDefault("isStateEventSource", "false").toString());
        model.displayOidWithBoundValue = Boolean.parseBoolean(nodeProperties.getOrDefault("displayOidWithBoundValue", "false").toString());
        model.loadOidWithBoundValue = Boolean.parseBoolean(nodeProperties.getOrDefault("loadOidWithBoundValue", "false").toString());
        model.inputType = nodeProperties.getOrDefault("inputType", "InputTypes.Undefined").toString();
        model.imports = new HashSet<>(defaultImports);

        try {
            List<Record> results = KnowledgeGraph.query(String.format("MATCH (attrDesc:ANNOTATION)-[:HAS_SELECT]->(selectAnnotation:ANNOTATION)-[:INSTANCE_OF]->(:ANNOTATION_TYPE { name: \"Select\" }) WHERE elementId(attrDesc) = \"%s\" RETURN selectAnnotation", nodeId));
            if (!results.isEmpty()) {
                Node selectNode = results.get(0).get("selectAnnotation").asNode();
                Select select = Select.nodeToModel(selectNode);
                model.ref = select.generate();
                model.imports.addAll(select.getImports());
            } else {
                model.ref = "@Select()";
            }

            results = KnowledgeGraph.query(String.format("MATCH (attrDesc:ANNOTATION)-[:HAS_CONTROLLER]->(controllerAnnotation:ANNOTATION)-[:INSTANCE_OF]->(:ANNOTATION_TYPE { name: \"ControllerDesc\" }) WHERE elementId(attrDesc) = \"%s\" RETURN controllerAnnotation", nodeId));
            if (!results.isEmpty()) {
                Node controllerNode = results.get(0).get("controllerAnnotation").asNode();
                ControllerDescModel controller = ControllerDescModel.nodeToModel(controllerNode);
                model.controllerDesc = controller.generate();
                model.imports.addAll(controller.getImports());
            } else {
                model.controllerDesc = "@ControllerDesc()";
            }

            results = KnowledgeGraph.query(String.format("MATCH (attrDesc:ANNOTATION)-[:HAS_JS_VALIDATION]->(jsValidation:ANNOTATION)-[:INSTANCE_OF]->(:ANNOTATION_TYPE { name: \"JSValidation\" }) WHERE elementId(attrDesc) = \"%s\" RETURN jsValidation", nodeId));
            if (!results.isEmpty()) {
                Node jsValidationNode = results.get(0).get("jsValidation").asNode();
                JSValidation jsValidation = JSValidation.nodeToModel(jsValidationNode);
                model.jsValidation = jsValidation.generate();
                model.imports.addAll(jsValidation.getImports());
            } else {
                model.jsValidation = "@JSValidation()";
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return model;
    }

    @Override
    public String getTemplateName() {
        return "templates/AttributeDesc.ftlh";
    }

    public String getId() {
        return id;
    }

    public String getLabel() {
        return label;
    }

    public String getRef() {
        return ref;
    }

    public String getType() {
        return type;
    }

    public int getWidth() {
        return width;
    }

    public int getHeight() {
        return height;
    }

    public String getAlignX() {
        return alignX;
    }

    public boolean getIsStateEventSource() {
        return isStateEventSource;
    }

    public String getControllerDesc() {
        return controllerDesc;
    }

    public boolean getDisplayOidWithBoundValue() {
        return displayOidWithBoundValue;
    }

    public boolean getLoadOidWithBoundValue() {
        return loadOidWithBoundValue;
    }

    public String getInputType() {
        return inputType;
    }

    public String getJsValidation() {
        return jsValidation;
    }
}
