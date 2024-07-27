package org.example.annotations;

import org.neo4j.driver.types.Node;

import java.util.*;

public class RFSGenDescModel extends AnnotationModel {
    private static final List<String> defaultImports = List.of(new String[] {
        "jda.modules.mosar.config.RFSGenDesc",
        "jda.modules.mosar.config.StackSpec",
        "jda.modules.mosar.config.GenerationMode",
        "jda.modules.mosar.config.LangPlatform",
        "jda.modules.mosar.software.frontend.FEApp",
        "jda.modules.mosarbackend.springboot.BESpringApp"
    });

    private String stackSpec;
    private String genMode;
    private String beLangPlatform;
    private String feProjPath;
    private String feProjName;
    private String feProjResource;
    private String feOutputPath;
    private long feServerPort;
    private String feAppClass;
    private Boolean feThreaded;
    private String bePackage;
    private String beOutputPath;
    private String beTargetPackage;
    private String beAppClass;
    private long beServerPort;

    public static RFSGenDescModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        RFSGenDescModel descModel = new RFSGenDescModel();
        descModel.stackSpec = nodeProperties.getOrDefault("stackSpec", "").toString();
        descModel.genMode = nodeProperties.getOrDefault("genMode", "").toString();
        descModel.beLangPlatform = nodeProperties.getOrDefault("beLangPlatform", "").toString();
        descModel.feProjPath = nodeProperties.getOrDefault("feProjPath", "").toString();
        descModel.feProjName = nodeProperties.getOrDefault("feProjName", "").toString();
        descModel.feProjResource = nodeProperties.getOrDefault("feProjResource", "").toString();
        descModel.feOutputPath = nodeProperties.getOrDefault("feOutputPath", "").toString();
        descModel.feServerPort = (long) nodeProperties.getOrDefault("feServerPort", 3000);
        descModel.feAppClass = nodeProperties.getOrDefault("feAppClass", "").toString();
        descModel.feThreaded = Boolean.parseBoolean(nodeProperties.getOrDefault("feThreaded", "false").toString());
        descModel.bePackage = nodeProperties.containsKey("bePackage") ? nodeProperties.get("bePackage").toString() : "";
        descModel.beOutputPath = nodeProperties.containsKey("beOutputPath") ? nodeProperties.get("beOutputPath").toString() : "";
        descModel.beTargetPackage = nodeProperties.containsKey("beTargetPackage") ? nodeProperties.get("beTargetPackage").toString() : "";
        descModel.beAppClass = nodeProperties.getOrDefault("beAppClass", "").toString();
        descModel.beServerPort = (long) nodeProperties.getOrDefault("beServerPort", 8080);
        descModel.imports = new HashSet<>(defaultImports);

        return descModel;
    }

    @Override
    public String getTemplateName() {
        return "templates/RFSGenDesc.ftlh";
    }

    public String getStackSpec() {
        return stackSpec;
    }

    public String getGenMode() {
        return genMode;
    }

    public String getBeLangPlatform() {
        return beLangPlatform;
    }

    public String getFeProjPath() {
        return feProjPath;
    }

    public String getFeProjName() {
        return feProjName;
    }

    public String getFeProjResource() {
        return feProjResource;
    }

    public String getFeOutputPath() {
        return feOutputPath;
    }

    public long getFeServerPort() {
        return feServerPort;
    }

    public String getFeAppClass() {
        return feAppClass;
    }

    public Boolean getFeThreaded() {
        return feThreaded;
    }

    public String getBePackage() {
        return bePackage;
    }

    public String getBeOutputPath() {
        return beOutputPath;
    }

    public String getBeTargetPackage() {
        return beTargetPackage;
    }

    public String getBeAppClass() {
        return beAppClass;
    }

    public long getBeServerPort() {
        return beServerPort;
    }
}
