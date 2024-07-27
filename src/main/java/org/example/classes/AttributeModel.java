package org.example.classes;

import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.example.Freemarker;
import org.example.KnowledgeGraph;
import org.example.Utils;
import org.example.annotations.AttributeDescModel;
import org.neo4j.driver.Record;
import org.neo4j.driver.types.Node;

import java.io.IOException;
import java.io.StringWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class AttributeModel {
    private String attributeDesc;
    private String accessModifier;
    private String dataType;
    private String name;
    private Set<String> imports;

    public AttributeModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        accessModifier = nodeProperties.getOrDefault("accessModifier", "private").toString();
        dataType = nodeProperties.getOrDefault("dataType", "").toString();
        name = nodeProperties.getOrDefault("name", "").toString();
        imports = new HashSet<>();
        imports.addAll(List.of(Utils.splitIfNotEmpty(nodeProperties.getOrDefault("requiredImport", "").toString())));

        try {
            List<Record> attributeDescs = KnowledgeGraph.query(String.format("MATCH (:ATTRIBUTE { name: \"%s\" })<-[:ATTACH_TO]-(annotation:ANNOTATION)-[:INSTANCE_OF]->(:ANNOTATION_TYPE { name: \"AttributeDesc\" }) RETURN annotation", name));
            if (attributeDescs.isEmpty()) {
                attributeDesc = "";
            } else {
                Node annotationNode = attributeDescs.get(0).get("annotation").asNode();
                AttributeDescModel model = AttributeDescModel.nodeToModel(annotationNode);
                attributeDesc = model.generate();
                imports.addAll(model.getImports());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public String bind() throws IOException {
        Template template = Freemarker.getTemplate("templates/Attribute.ftlh");

        try (StringWriter writer = new StringWriter()) {
            template.process(this, writer);
            return writer.toString();
        } catch (TemplateException e) {
            throw new RuntimeException(e);
        }
    }

    public String getAttributeDesc() {
        return attributeDesc;
    }

    public String getAccessModifier() {
        return accessModifier;
    }

    public String getDataType() {
        return dataType;
    }

    public String getName() {
        return name;
    }

    public Set<String> getImports() {
        return imports;
    }
}
