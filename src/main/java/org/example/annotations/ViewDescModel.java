package org.example.annotations;

import org.neo4j.driver.types.Node;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

public class ViewDescModel extends AnnotationModel {
    private String formTitle;
    private String domainClassLabel;
    private String imageIcon;
    private String view;
    private String viewType;
    private String parent;

    private static String[] defaultImports = {
        "jda.modules.mccl.conceptmodel.view.RegionName",
        "jda.modules.mccl.conceptmodel.view.RegionType",
        "jda.modules.common.types.Null",
        "jda.mosa.view.View"
    };

    public String getFormTitle() {
        return formTitle;
    }

    public void setFormTitle(String formTitle) {
        this.formTitle = formTitle;
    }

    public String getDomainClassLabel() {
        return domainClassLabel;
    }

    public void setDomainClassLabel(String domainClassLabel) {
        this.domainClassLabel = domainClassLabel;
    }

    public String getImageIcon() {
        return imageIcon;
    }

    public void setImageIcon(String imageIcon) {
        this.imageIcon = imageIcon;
    }

    public String getView() {
        return view;
    }

    public void setView(String view) {
        this.view = view;
    }

    public String getViewType() {
        return viewType;
    }

    public void setViewType(String viewType) {
        this.viewType = viewType;
    }

    public String getParent() {
        return parent;
    }

    public void setParent(String parent) {
        this.parent = parent;
    }

    public static ViewDescModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        ViewDescModel viewDescModel = new ViewDescModel();
        viewDescModel.setFormTitle(nodeProperties.getOrDefault("formTitle", "").toString());
        viewDescModel.setDomainClassLabel(nodeProperties.getOrDefault("domainClassLabel", "").toString());
        viewDescModel.setImageIcon(nodeProperties.getOrDefault("imageIcon", "").toString());
        viewDescModel.setView(nodeProperties.getOrDefault("view", "Null.class").toString());
        viewDescModel.setViewType(nodeProperties.getOrDefault("viewType", "RegionType.Null").toString());
        viewDescModel.setParent(nodeProperties.getOrDefault("parent", "RegionName.Null").toString());
        viewDescModel.setImports(new ArrayList<>(Arrays.asList(defaultImports)));

        return viewDescModel;
    }

    @Override
    public String getTemplateName() {
        return "templates/ViewDesc.ftlh";
    }
}
