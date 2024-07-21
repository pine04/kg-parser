package org.example.annotations;

import org.example.KnowledgeGraph;
import org.neo4j.driver.Record;
import org.neo4j.driver.types.Node;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static org.example.Constants.basePackage;

public class ModuleDescriptorModel extends AnnotationModel {
    private String name;
    private String modelDesc;
    private String viewDesc;
    private String controllerDesc;
    private String setUpDesc;
    private List<String> subtypes;
    private String type;
    private boolean isPrimary;

    private static String[] defaultImports = {
        "jda.modules.mccl.syntax.ModuleDescriptor",
        "jda.modules.mccl.syntax.model.ModelDesc",
        "jda.modules.mccl.syntax.view.ViewDesc",
        "jda.modules.mccl.syntax.controller.ControllerDesc",
        "jda.modules.mccl.syntax.SetUpDesc",
        "jda.modules.mccl.conceptmodel.module.ModuleType"
    };

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getModelDesc() {
        return modelDesc;
    }

    public void setModelDesc(String modelDesc) {
        this.modelDesc = modelDesc;
    }

    public String getViewDesc() {
        return viewDesc;
    }

    public void setViewDesc(String viewDesc) {
        this.viewDesc = viewDesc;
    }

    public String getControllerDesc() {
        return controllerDesc;
    }

    public void setControllerDesc(String controllerDesc) {
        this.controllerDesc = controllerDesc;
    }

    public String getSetUpDesc() {
        return setUpDesc;
    }

    public void setSetUpDesc(String setUpDesc) {
        this.setUpDesc = setUpDesc;
    }

    public List<String> getSubtypes() {
        return subtypes;
    }

    public void setSubtypes(List<String> subtypes) {
        this.subtypes = subtypes;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean getIsPrimary() {
        return isPrimary;
    }

    public void setIsPrimary(boolean isPrimary) {
        this.isPrimary = isPrimary;
    }

    public static ModuleDescriptorModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        ModuleDescriptorModel model = new ModuleDescriptorModel();

        model.setName(nodeProperties.getOrDefault("name", "").toString());
        model.setType(nodeProperties.getOrDefault("type", "ModuleType.DomainData").toString());
        model.setIsPrimary((boolean)nodeProperties.getOrDefault("isPrimary", false));

        ArrayList<String> imports = new ArrayList<>(Arrays.asList(defaultImports));
        ArrayList<String> subtypes = new ArrayList<>();

        try {
            List<Record> modelRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_MODEL]->(modelDesc:ANNOTATION) RETURN modelDesc", nodeProperties.get("name")));
            if (!modelRecords.isEmpty()) {
                Node modelNode = modelRecords.get(0).get("modelDesc").asNode();
                ModelDescModel descModel = ModelDescModel.nodeToModel(modelNode);
                imports.addAll(descModel.getImports());
                model.setModelDesc(descModel.generate());
            } else {
                model.setModelDesc("@ModelDesc()");
            }

            List<Record> viewRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_VIEW]->(viewDesc:ANNOTATION) RETURN viewDesc", nodeProperties.get("name")));
            if (!viewRecords.isEmpty()) {
                Node viewNode = viewRecords.get(0).get("viewDesc").asNode();
                ViewDescModel descModel = ViewDescModel.nodeToModel(viewNode);
                imports.addAll(descModel.getImports());
                model.setViewDesc(descModel.generate());
            } else {
                model.setViewDesc("@ViewDesc()");
            }

            List<Record> controllerRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_CONTROLLER]->(controllerDesc:ANNOTATION) RETURN controllerDesc", nodeProperties.get("name")));
            if (!controllerRecords.isEmpty()) {
                Node controllerNode = controllerRecords.get(0).get("controllerDesc").asNode();
                ControllerDescModel descModel = ControllerDescModel.nodeToModel(controllerNode);
                imports.addAll(descModel.getImports());
                model.setControllerDesc(descModel.generate());
            } else {
                model.setControllerDesc("@ControllerDesc()");
            }

            List<Record> setUpRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_SETUP]->(setUpDesc:ANNOTATION) RETURN setUpDesc", nodeProperties.get("name")));
            if (!setUpRecords.isEmpty()) {
                Node setUpNode = setUpRecords.get(0).get("setUpDesc").asNode();
                SetUpDescModel descModel = SetUpDescModel.nodeToModel(setUpNode);
                imports.addAll(descModel.getImports());
                model.setSetUpDesc(descModel.generate());
            } else {
                model.setSetUpDesc("@SetUpDesc()");
            }

            List<Record> subtypeRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_SUBTYPE]->(subtype:CLASS) RETURN subtype", nodeProperties.get("name")));
            subtypeRecords.forEach(r -> {
                Node subtypeNode = r.get("subtype").asNode();
                String subtypeName = subtypeNode.get("name").asString();
                String subtypePackage = subtypeNode.get("packageName").asString();

                subtypes.add(subtypeName);
                imports.add(basePackage + "." + subtypePackage + "." + subtypeName);
            });

            model.setImports(imports);
            model.setSubtypes(subtypes);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return model;
    }

    @Override
    public String getTemplateName() {
        return "templates/ModuleDescriptor.ftlh";
    }
}
