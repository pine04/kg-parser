package org.example.annotations;

import org.neo4j.driver.types.Node;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

public class RFSGenDescModel extends AnnotationModel {
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

    private static String[] defaultImports = {
        "jda.modules.mosar.config.RFSGenDesc",
        "jda.modules.mosar.config.StackSpec",
        "jda.modules.mosar.config.GenerationMode",
        "jda.modules.mosar.config.LangPlatform",
        "jda.modules.mosar.software.frontend.FEApp",
        "jda.modules.mosarbackend.springboot.BESpringApp"
    };

    public String getStackSpec() {
        return stackSpec;
    }

    public void setStackSpec(String stackSpec) {
        this.stackSpec = stackSpec;
    }

    public String getGenMode() {
        return genMode;
    }

    public void setGenMode(String genMode) {
        this.genMode = genMode;
    }

    public String getBeLangPlatform() {
        return beLangPlatform;
    }

    public void setBeLangPlatform(String beLangPlatform) {
        this.beLangPlatform = beLangPlatform;
    }

    public String getFeProjPath() {
        return feProjPath;
    }

    public void setFeProjPath(String feProjPath) {
        this.feProjPath = feProjPath;
    }

    public String getFeProjName() {
        return feProjName;
    }

    public void setFeProjName(String feProjName) {
        this.feProjName = feProjName;
    }

    public String getFeProjResource() {
        return feProjResource;
    }

    public void setFeProjResource(String feProjResource) {
        this.feProjResource = feProjResource;
    }

    public String getFeOutputPath() {
        return feOutputPath;
    }

    public void setFeOutputPath(String feOutputPath) {
        this.feOutputPath = feOutputPath;
    }

    public long getFeServerPort() {
        return feServerPort;
    }

    public void setFeServerPort(long feServerPort) {
        this.feServerPort = feServerPort;
    }

    public String getFeAppClass() {
        return feAppClass;
    }

    public void setFeAppClass(String feAppClass) {
        this.feAppClass = feAppClass;
    }

    public Boolean getFeThreaded() {
        return feThreaded;
    }

    public void setFeThreaded(Boolean feThreaded) {
        this.feThreaded = feThreaded;
    }

    public String getBePackage() {
        return bePackage;
    }

    public void setBePackage(String bePackage) {
        this.bePackage = bePackage;
    }

    public String getBeOutputPath() {
        return beOutputPath;
    }

    public void setBeOutputPath(String beOutputPath) {
        this.beOutputPath = beOutputPath;
    }

    public String getBeTargetPackage() {
        return beTargetPackage;
    }

    public void setBeTargetPackage(String beTargetPackage) {
        this.beTargetPackage = beTargetPackage;
    }

    public String getBeAppClass() {
        return beAppClass;
    }

    public void setBeAppClass(String beAppClass) {
        this.beAppClass = beAppClass;
    }

    public long getBeServerPort() {
        return beServerPort;
    }

    public void setBeServerPort(long beServerPort) {
        this.beServerPort = beServerPort;
    }

    public static RFSGenDescModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        RFSGenDescModel descModel = new RFSGenDescModel();
        descModel.setStackSpec(nodeProperties.getOrDefault("stackSpec", "").toString());
        descModel.setGenMode(nodeProperties.getOrDefault("genMode", "").toString());
        descModel.setBeLangPlatform(nodeProperties.getOrDefault("beLangPlatform", "").toString());
        descModel.setFeProjPath(nodeProperties.getOrDefault("feProjPath", "").toString());
        descModel.setFeProjName(nodeProperties.getOrDefault("feProjName", "").toString());
        descModel.setFeProjResource(nodeProperties.getOrDefault("feProjResource", "").toString());
        descModel.setFeOutputPath(nodeProperties.getOrDefault("feOutputPath", "").toString());
        descModel.setFeServerPort((long) nodeProperties.getOrDefault("feServerPort", 3000));
        descModel.setFeAppClass(nodeProperties.getOrDefault("feAppClass", "").toString());
        descModel.setFeThreaded((boolean) nodeProperties.getOrDefault("feThreaded", false));
        descModel.setBePackage(nodeProperties.containsKey("bePackage") ? nodeProperties.get("bePackage").toString() : "");
        descModel.setBeOutputPath(nodeProperties.containsKey("beOutputPath") ? nodeProperties.get("beOutputPath").toString() : "");
        descModel.setBeTargetPackage(nodeProperties.containsKey("beTargetPackage") ? nodeProperties.get("beTargetPackage").toString() : "");
        descModel.setBeAppClass(nodeProperties.getOrDefault("beAppClass", "").toString());
        descModel.setBeServerPort((long) nodeProperties.getOrDefault("beServerPort", 8080));

        descModel.setImports(new ArrayList<>(Arrays.asList(defaultImports)));

        return descModel;
    }

    @Override
    public String getTemplateName() {
        return "templates/RFSGenDesc.ftlh";
    }
}
