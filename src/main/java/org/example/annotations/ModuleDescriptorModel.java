package org.example.annotations;

import org.example.KnowledgeGraph;
import org.neo4j.driver.Record;
import org.neo4j.driver.types.Node;

import java.io.IOException;
import java.util.*;

import static org.example.Constants.basePackage;

public class ModuleDescriptorModel extends AnnotationModel {
    private static final List<String> defaultImports = List.of(new String[] {
        "jda.modules.mccl.syntax.ModuleDescriptor",
        "jda.modules.mccl.syntax.model.ModelDesc",
        "jda.modules.mccl.syntax.view.ViewDesc",
        "jda.modules.mccl.syntax.controller.ControllerDesc",
        "jda.modules.mccl.syntax.SetUpDesc",
        "jda.modules.mccl.conceptmodel.module.ModuleType"
    });

    private String name;
    private String modelDesc;
    private String viewDesc;
    private String controllerDesc;
    private String setUpDesc;
    private List<String> subtypes;
    private String type;
    private boolean isPrimary;

    public static ModuleDescriptorModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        ModuleDescriptorModel model = new ModuleDescriptorModel();
        model.name = nodeProperties.getOrDefault("name", "").toString();
        model.type = nodeProperties.getOrDefault("type", "ModuleType.DomainData").toString();
        model.isPrimary = Boolean.parseBoolean(nodeProperties.getOrDefault("isPrimary", false).toString());
        model.subtypes = new ArrayList<>();
        model.imports = new HashSet<>(defaultImports);

        try {
            List<Record> modelRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_MODEL]->(modelDesc:ANNOTATION) RETURN modelDesc", nodeProperties.get("name")));
            if (!modelRecords.isEmpty()) {
                Node modelNode = modelRecords.get(0).get("modelDesc").asNode();
                ModelDescModel descModel = ModelDescModel.nodeToModel(modelNode);
                model.imports.addAll(descModel.getImports());
                model.modelDesc = descModel.generate();
            } else {
                model.modelDesc = "@ModelDesc()";
            }

            List<Record> viewRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_VIEW]->(viewDesc:ANNOTATION) RETURN viewDesc", nodeProperties.get("name")));
            if (!viewRecords.isEmpty()) {
                Node viewNode = viewRecords.get(0).get("viewDesc").asNode();
                ViewDescModel descModel = ViewDescModel.nodeToModel(viewNode);
                model.imports.addAll(descModel.getImports());
                model.viewDesc = descModel.generate();
            } else {
                model.viewDesc = "@ViewDesc()";
            }

            List<Record> controllerRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_CONTROLLER]->(controllerDesc:ANNOTATION) RETURN controllerDesc", nodeProperties.get("name")));
            if (!controllerRecords.isEmpty()) {
                Node controllerNode = controllerRecords.get(0).get("controllerDesc").asNode();
                ControllerDescModel descModel = ControllerDescModel.nodeToModel(controllerNode);
                model.imports.addAll(descModel.getImports());
                model.controllerDesc = descModel.generate();
            } else {
                model.controllerDesc = "@ControllerDesc()";
            }

            List<Record> setUpRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_SETUP]->(setUpDesc:ANNOTATION) RETURN setUpDesc", nodeProperties.get("name")));
            if (!setUpRecords.isEmpty()) {
                Node setUpNode = setUpRecords.get(0).get("setUpDesc").asNode();
                SetUpDescModel descModel = SetUpDescModel.nodeToModel(setUpNode);
                model.imports.addAll(descModel.getImports());
                model.setUpDesc = descModel.generate();
            } else {
                model.setUpDesc = "@SetUpDesc()";
            }

            List<Record> subtypeRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_SUBTYPE]->(subtype:CLASS) RETURN subtype", nodeProperties.get("name")));
            subtypeRecords.forEach(r -> {
                Node subtypeNode = r.get("subtype").asNode();
                String subtypeName = subtypeNode.get("name").asString();
                String subtypePackage = subtypeNode.get("packageName").asString();

                model.subtypes.add(subtypeName);
                model.imports.add(basePackage + "." + subtypePackage + "." + subtypeName);
            });
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return model;
    }

    @Override
    public String getTemplateName() {
        return "templates/ModuleDescriptor.ftlh";
    }

    public String getName() {
        return name;
    }

    public String getModelDesc() {
        return modelDesc;
    }

    public String getViewDesc() {
        return viewDesc;
    }

    public String getControllerDesc() {
        return controllerDesc;
    }

    public String getSetUpDesc() {
        return setUpDesc;
    }

    public List<String> getSubtypes() {
        return subtypes;
    }

    public String getType() {
        return type;
    }

    public boolean getIsPrimary() {
        return isPrimary;
    }
}
