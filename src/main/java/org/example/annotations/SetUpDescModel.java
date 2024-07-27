package org.example.annotations;

import org.neo4j.driver.types.Node;

import java.util.*;

public class SetUpDescModel extends AnnotationModel {
    private static final List<String> defaultImports = List.of(new String[] {
        "jda.modules.common.types.Null",
        "jda.modules.setup.commands.*"
    });

    private String postSetUp;

    public static SetUpDescModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        SetUpDescModel setUpDescModel = new SetUpDescModel();
        setUpDescModel.postSetUp = nodeProperties.getOrDefault("postSetUp", "Null.class").toString();
        setUpDescModel.imports = new HashSet<>(defaultImports);

        return setUpDescModel;
    }

    @Override
    public String getTemplateName() {
        return "templates/SetUpDesc.ftlh";
    }

    public String getPostSetUp() {
        return postSetUp;
    }
}
