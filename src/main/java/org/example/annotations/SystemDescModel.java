package org.example.annotations;

import org.example.KnowledgeGraph;
import org.neo4j.driver.Record;
import org.neo4j.driver.types.Node;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static org.example.Constants.basePackage;

public class SystemDescModel extends AnnotationModel {
    private String appName;
    private String splashScreenLogo;
    private String language;
    private String dsDesc;
    private String orgDesc;
    private String securityDesc;
    private String setUpDesc;
    private List<String> modules;
    private List<String> sysModules;

    private static String[] defaultImports = {
        "jda.modules.sccl.syntax.SystemDesc",
        "jda.modules.sccl.syntax.DSDesc",
        "jda.modules.sccl.syntax.OrgDesc",
        "jda.modules.sccl.syntax.SecurityDesc",
        "jda.modules.sccl.syntax.SysSetUpDesc",
        "jda.modules.mccl.conceptmodel.Configuration.Language",
        "jda.modules.dodm.dom.DOM",
        "jda.modules.dodm.dsm.DSM",
        "jda.modules.dodm.osm.postgresql.PostgreSQLOSM",
        "jda.modules.mccl.conceptmodel.dodm.OsmConfig.ConnectionType",
        "jda.modules.setup.model.SetUpConfig"
    };

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }
    public String getSplashScreenLogo() {
        return splashScreenLogo;
    }
    public void setSplashScreenLogo(String splashScreenLogo) {
        this.splashScreenLogo = splashScreenLogo;
    }
    public String getLanguage() {
        return language;
    }
    public void setLanguage(String language) {
        this.language = language;
    }

    public String getDsDesc() {
        return dsDesc;
    }

    public void setDsDesc(String dsDesc) {
        this.dsDesc = dsDesc;
    }

    public String getOrgDesc() {
        return orgDesc;
    }

    public void setOrgDesc(String orgDesc) {
        this.orgDesc = orgDesc;
    }

    public String getSecurityDesc() {
        return securityDesc;
    }

    public void setSecurityDesc(String securityDesc) {
        this.securityDesc = securityDesc;
    }

    public String getSetUpDesc() {
        return setUpDesc;
    }

    public void setSetUpDesc(String setUpDesc) {
        this.setUpDesc = setUpDesc;
    }

    public List<String> getModules() {
        return modules;
    }

    public void setModules(List<String> modules) {
        this.modules = modules;
    }

    public List<String> getSysModules() {
        return sysModules;
    }

    public void setSysModules(List<String> sysModules) {
        this.sysModules = sysModules;
    }

    public static SystemDescModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        SystemDescModel descModel = new SystemDescModel();

        descModel.setAppName(nodeProperties.getOrDefault("appName", "").toString());
        descModel.setLanguage(nodeProperties.getOrDefault("language", "").toString());
        descModel.setSplashScreenLogo(nodeProperties.getOrDefault("splashScreenLogo", "").toString());
        descModel.setDsDesc(nodeProperties.getOrDefault("dsDesc", "").toString());
        descModel.setOrgDesc(nodeProperties.getOrDefault("orgDesc", "").toString());
        descModel.setSecurityDesc(nodeProperties.getOrDefault("securityDesc", "").toString());
        descModel.setSetUpDesc(nodeProperties.getOrDefault("setUpDesc", "").toString());

        ArrayList<String> modules = new ArrayList<>();
        ArrayList<String> sysModules = new ArrayList<>();
        ArrayList<String> imports = new ArrayList<>(Arrays.asList(defaultImports));

        try {
            List<Record> moduleRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_MODULE]->(module:CLASS) RETURN module", nodeProperties.get("name")));
            moduleRecords.forEach(r -> {
                Node moduleNode = r.get("module").asNode();
                String moduleName = moduleNode.get("name").asString();
                String modulePackage = moduleNode.get("packageName").asString();

                modules.add(moduleName);
                imports.add(basePackage + "." + modulePackage + "." + moduleName);
            });

            List<Record> sysModuleRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_SYS_MODULE]->(module:CLASS) RETURN module", nodeProperties.get("name")));
            sysModuleRecords.forEach(r -> {
                Node sysModuleNode = r.get("module").asNode();
                String moduleName = sysModuleNode.get("name").asString();
                String modulePackage = sysModuleNode.get("packageName").asString();

                sysModules.add(moduleName);
                imports.add(basePackage + "." + modulePackage + "." + moduleName);
            });
        } catch (NullPointerException e) {
            e.printStackTrace();
        }

        descModel.setModules(modules);
        descModel.setSysModules(sysModules);
        descModel.setImports(imports);

        return descModel;
    }

    @Override
    public String getTemplateName() {
        return "templates/SystemDesc.ftlh";
    }
}

