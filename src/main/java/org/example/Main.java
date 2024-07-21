package org.example;

import org.example.classes.ClassModel;
import org.neo4j.driver.Record;
import org.neo4j.driver.types.Node;

import java.io.IOException;
import java.util.List;

import static org.example.Constants.originalJdaDirectory;
import static org.example.Constants.projectDirectory;

public class Main {
    public static void main(String[] args) {
        Freemarker.init();
        KnowledgeGraph.init();

        try {
            List<Record> classNodes = KnowledgeGraph.query("MATCH (classNode:CLASS) RETURN classNode");

            for (Record record : classNodes) {
                Node classNode = record.get("classNode").asNode();
                ClassModel model = ClassModel.nodeToModel(classNode);
                model.generate(originalJdaDirectory, projectDirectory);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            KnowledgeGraph.close();
        }
    }
}
