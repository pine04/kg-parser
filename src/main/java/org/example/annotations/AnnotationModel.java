package org.example.annotations;

import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.example.Freemarker;
import org.neo4j.driver.types.Node;

import java.io.IOException;
import java.io.StringWriter;
import java.util.Set;

public abstract class AnnotationModel {
    protected Set<String> imports;

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
            case "AttributeDesc" -> AttributeDescModel.nodeToModel(node);
            case "Select" -> Select.nodeToModel(node);
            case "JSValidation" -> JSValidation.nodeToModel(node);
            case "PropertyDesc" -> PropertyDesc.nodeToModel(node);
            default -> null;
        };
    }

    public Set<String> getImports() {
        return imports;
    }

    protected abstract String getTemplateName();
}
