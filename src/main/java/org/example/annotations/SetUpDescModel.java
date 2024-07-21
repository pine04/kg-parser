package org.example.annotations;

import org.neo4j.driver.types.Node;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

public class SetUpDescModel extends AnnotationModel {
    private String postSetUp;

    private static String[] defaultImports = {
        "jda.modules.common.types.Null",
        "jda.modules.setup.commands.*"
    };

    public String getPostSetUp() {
        return postSetUp;
    }

    public void setPostSetUp(String postSetUp) {
        this.postSetUp = postSetUp;
    }

    public static SetUpDescModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        SetUpDescModel setUpDescModel = new SetUpDescModel();
        setUpDescModel.setPostSetUp(nodeProperties.getOrDefault("postSetUp", "Null.class").toString());
        setUpDescModel.setImports(new ArrayList<>(Arrays.asList(defaultImports)));

        return setUpDescModel;
    }

    @Override
    public String getTemplateName() {
        return "templates/SetUpDesc.ftlh";
    }
}
