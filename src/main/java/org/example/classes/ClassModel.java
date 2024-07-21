package org.example.classes;

import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.example.Freemarker;
import org.example.KnowledgeGraph;
import org.example.annotations.AnnotationModel;
import org.neo4j.driver.Record;
import org.neo4j.driver.types.Node;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.example.Constants.basePackage;

public class ClassModel {
    private String className;
    private String packageName;
    private String sourceFilePath;
    private ArrayList<String> imports;
    private ArrayList<String> extendsList;
    private ArrayList<String> annotations;

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getSourceFilePath() {
        return sourceFilePath;
    }

    public void setSourceFilePath(String sourceFilePath) {
        this.sourceFilePath = sourceFilePath;
    }

    public ArrayList<String> getImports() {
        return imports;
    }

    public void setImports(ArrayList<String> imports) {
        this.imports = imports;
    }

    public ArrayList<String> getExtendsList() {
        return extendsList;
    }

    public void setExtendsList(ArrayList<String> extendsList) {
        this.extendsList = extendsList;
    }

    public ArrayList<String> getAnnotations() {
        return annotations;
    }

    public void setAnnotations(ArrayList<String> annotations) {
        this.annotations = annotations;
    }

    public static ClassModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        ClassModel classModel = new ClassModel();
        classModel.setClassName(nodeProperties.getOrDefault("name", "").toString());
        classModel.setPackageName(basePackage + "." + nodeProperties.getOrDefault("packageName", "").toString());
        classModel.setSourceFilePath(nodeProperties.getOrDefault("sourceFilePath", "").toString());

        ArrayList<String> imports = new ArrayList<>();
        ArrayList<String> extendsList = new ArrayList<>();
        ArrayList<String> annotations = new ArrayList<>();

        try {
            List<Record> extendNodes = KnowledgeGraph.query(String.format("MATCH (:CLASS {name: \"%s\"})-[:EXTENDS]->(n:CLASS) RETURN n", classModel.getClassName()));
            extendNodes.forEach(r -> {
                Node extendNode = r.get("n").asNode();
                String name = extendNode.get("name").asString();
                String packageName = extendNode.get("packageName").asString();

                extendsList.add(name);
                imports.add(basePackage + "." + packageName + "." + name);
            });

            List<Record> annotationNodes = KnowledgeGraph.query(String.format("MATCH (:CLASS {name: \"%s\"})<-[:ATTACH_TO]-(a:ANNOTATION)-[:INSTANCE_OF]->(aType:ANNOTATION_TYPE) return a, aType.name", classModel.getClassName()));
            for (Record r : annotationNodes) {
                Node annotationNode = r.get("a").asNode();
                String annotationType = r.get("aType.name").asString();
                AnnotationModel model = AnnotationModel.nodeToModel(annotationNode, annotationType);

                if (model != null) {
                    imports.addAll(model.getImports());
                    annotations.add(model.generate());
                }
            }
        } catch (NullPointerException | IOException e) {
            e.printStackTrace();
        }

        classModel.setImports(imports);
        classModel.setExtendsList(extendsList);
        classModel.setAnnotations(annotations);

        return classModel;
    }

    public void generate(String originalJdaDirectory, String projectDirectory) throws IOException {
        File outDir = new File(projectDirectory + File.separator + packageName.replace(".", File.separator));
        outDir.mkdirs();

        File outFile = new File(projectDirectory + File.separator + packageName.replace(".", File.separator) + File.separator + className + ".java");

        if (sourceFilePath.isEmpty()) {
            Template template = Freemarker.getTemplate("templates/Class.ftlh");

            try (var fileWriter = new FileWriter(outFile)) {
                template.process(this, fileWriter);
            } catch (TemplateException e) {
                e.printStackTrace();
            }
        } else {
            try {
                File sourceFile = new File(originalJdaDirectory + File.separator + sourceFilePath);
                Files.copy(sourceFile.toPath(), outFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
