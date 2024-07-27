package org.example.annotations;

import org.example.Utils;
import org.neo4j.driver.types.Node;

import java.util.*;

public class ViewDescModel extends AnnotationModel {
    private static final List<String> defaultImports = List.of(new String[] {
        "jda.modules.mccl.syntax.view.ViewDesc",
        "jda.modules.mccl.conceptmodel.view.RegionName",
        "jda.modules.mccl.conceptmodel.view.RegionType",
        "jda.modules.common.types.Null",
        "jda.mosa.view.View"
    });

    private String formTitle;
    private String domainClassLabel;
    private String imageIcon;
    private String view;
    private String viewType;
    private String parent;
    private double topX;
    private double topY;
    private float widthRatio;
    private float heightRatio;
    private String[] children;
    private String[] excludeComponents;
    private String[] props;

    public static ViewDescModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        ViewDescModel viewDescModel = new ViewDescModel();
        viewDescModel.formTitle = nodeProperties.getOrDefault("formTitle", "").toString();
        viewDescModel.domainClassLabel = nodeProperties.getOrDefault("domainClassLabel", "").toString();
        viewDescModel.imageIcon = nodeProperties.getOrDefault("imageIcon", "").toString();
        viewDescModel.view = nodeProperties.getOrDefault("view", "Null.class").toString();
        viewDescModel.viewType = nodeProperties.getOrDefault("viewType", "RegionType.Null").toString();
        viewDescModel.parent = nodeProperties.getOrDefault("parent", "RegionName.Null").toString();
        viewDescModel.topX = Double.parseDouble(nodeProperties.getOrDefault("topX", "-1").toString());
        viewDescModel.topY = Double.parseDouble(nodeProperties.getOrDefault("topY", "-1").toString());
        viewDescModel.widthRatio = Float.parseFloat(nodeProperties.getOrDefault("widthRatio", "-1f").toString());
        viewDescModel.heightRatio = Float.parseFloat(nodeProperties.getOrDefault("heightRatio", "-1f").toString());
        viewDescModel.children = Utils.splitIfNotEmpty(nodeProperties.getOrDefault("children", "").toString());
        viewDescModel.excludeComponents = Utils.splitIfNotEmpty(nodeProperties.getOrDefault("excludeComponents", "").toString());
        viewDescModel.props = Utils.splitIfNotEmpty(nodeProperties.getOrDefault("props", "").toString());
        viewDescModel.imports = new HashSet<>(defaultImports);

        return viewDescModel;
    }

    @Override
    public String getTemplateName() {
        return "templates/ViewDesc.ftlh";
    }

    public String getFormTitle() {
        return formTitle;
    }

    public String getDomainClassLabel() {
        return domainClassLabel;
    }

    public String getImageIcon() {
        return imageIcon;
    }

    public String getView() {
        return view;
    }

    public String getViewType() {
        return viewType;
    }

    public String getParent() {
        return parent;
    }

    public double getTopX() {
        return topX;
    }

    public double getTopY() {
        return topY;
    }

    public float getWidthRatio() {
        return widthRatio;
    }

    public float getHeightRatio() {
        return heightRatio;
    }

    public String[] getChildren() {
        return children;
    }

    public String[] getExcludeComponents() {
        return excludeComponents;
    }

    public String[] getProps() {
        return props;
    }
}
