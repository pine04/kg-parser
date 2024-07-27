package org.example.annotations;

import org.example.KnowledgeGraph;
import org.neo4j.driver.Record;
import org.neo4j.driver.types.Node;

import java.util.*;

import static org.example.Constants.basePackage;

public class SystemDescModel extends AnnotationModel {
    private static final List<String> defaultImports = List.of(new String[] {
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
    });

    private String appName;
    private String splashScreenLogo;
    private String language;
    private String dsDesc;
    private String orgDesc;
    private String securityDesc;
    private String setUpDesc;
    private List<String> modules;
    private List<String> sysModules;

    public static SystemDescModel nodeToModel(Node node) {
        Map<String, Object> nodeProperties = node.asMap();

        SystemDescModel descModel = new SystemDescModel();
        descModel.appName = nodeProperties.getOrDefault("appName", "").toString();
        descModel.language = nodeProperties.getOrDefault("language", "Language.English").toString();
        descModel.splashScreenLogo = nodeProperties.getOrDefault("splashScreenLogo", "").toString();
        descModel.dsDesc = nodeProperties.getOrDefault("dsDesc", "").toString();
        descModel.orgDesc = nodeProperties.getOrDefault("orgDesc", "").toString();
        descModel.securityDesc = nodeProperties.getOrDefault("securityDesc", "").toString();
        descModel.setUpDesc = nodeProperties.getOrDefault("setUpDesc", "").toString();
        descModel.modules = new ArrayList<>();
        descModel.sysModules = new ArrayList<>();
        descModel.imports = new HashSet<>(defaultImports);

        try {
            List<Record> moduleRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_MODULE]->(module:CLASS) RETURN module", nodeProperties.get("name")));
            moduleRecords.forEach(r -> {
                Node moduleNode = r.get("module").asNode();
                String moduleName = moduleNode.get("name").asString();
                String modulePackage = moduleNode.get("packageName").asString();

                descModel.modules.add(moduleName);
                descModel.imports.add(basePackage + "." + modulePackage + "." + moduleName);
            });

            List<Record> sysModuleRecords = KnowledgeGraph.query(String.format("MATCH (:ANNOTATION {name: \"%s\"})-[:HAS_SYS_MODULE]->(module:CLASS) RETURN module", nodeProperties.get("name")));
            sysModuleRecords.forEach(r -> {
                Node sysModuleNode = r.get("module").asNode();
                String moduleName = sysModuleNode.get("name").asString();
                String modulePackage = sysModuleNode.get("packageName").asString();

                descModel.sysModules.add(moduleName);
                descModel.imports.add(basePackage + "." + modulePackage + "." + moduleName);
            });
        } catch (NullPointerException e) {
            e.printStackTrace();
        }

        return descModel;
    }

    @Override
    public String getTemplateName() {
        return "templates/SystemDesc.ftlh";
    }

    public String getAppName() {
        return appName;
    }

    public String getSplashScreenLogo() {
        return splashScreenLogo;
    }

    public String getLanguage() {
        return language;
    }

    public String getDsDesc() {
        return dsDesc;
    }

    public String getOrgDesc() {
        return orgDesc;
    }

    public String getSecurityDesc() {
        return securityDesc;
    }

    public String getSetUpDesc() {
        return setUpDesc;
    }

    public List<String> getModules() {
        return modules;
    }

    public List<String> getSysModules() {
        return sysModules;
    }
}

