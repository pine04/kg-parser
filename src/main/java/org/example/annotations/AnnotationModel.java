package org.example.annotations;

import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.example.Freemarker;
import org.neo4j.driver.types.Node;

import java.io.IOException;
import java.io.StringWriter;
import java.util.List;

public abstract class AnnotationModel {
    protected List<String> imports;

    public String generate() throws IOException {
        Template template = Freemarker.getTemplate(getTemplateName());

        try (StringWriter writer = new StringWriter()) {
            template.process(this, writer);
            return writer.toString();
        } catch (TemplateException e) {
            throw new RuntimeException(e);
        }
    }

    public static AnnotationModel nodeToModel(Node node, String annotationType) {
        return switch (annotationType) {
            case "RFSGenDesc" -> RFSGenDescModel.nodeToModel(node);
            case "SystemDesc" -> SystemDescModel.nodeToModel(node);
            case "ModuleDescriptor" -> ModuleDescriptorModel.nodeToModel(node);
            case "ModelDesc" -> ModelDescModel.nodeToModel(node);
            case "ViewDesc" -> ViewDescModel.nodeToModel(node);
            case "ControllerDesc" -> ControllerDescModel.nodeToModel(node);
            case "SetUpDesc" -> SetUpDescModel.nodeToModel(node);
            default -> null;
        };
    }

    public List<String> getImports() {
        return imports;
    }

    protected void setImports(List<String> imports) {
        this.imports = imports;
    }

    protected abstract String getTemplateName();
}
