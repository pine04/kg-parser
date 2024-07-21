CREATE

// Different annotation types supported by the current version of the parser.
(systemDesc:ANNOTATION_TYPE { name: "SystemDesc" }),
(rfsGenDesc:ANNOTATION_TYPE { name: "RFSGenDesc" }),
(moduleDesc:ANNOTATION_TYPE { name: "ModuleDescriptor" }),
(modelDesc:ANNOTATION_TYPE { name: "ModelDesc" }),
(viewDesc:ANNOTATION_TYPE { name: "ViewDesc" }),
(controllerDesc:ANNOTATION_TYPE { name: "ControllerDesc" }),
(setupDesc:ANNOTATION_TYPE { name: "SetUpDesc" }),

// Software files that are not generated.
(sccCourseManDerby:CLASS {name: "SCCCourseManDerby", packageName: "software.config", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\software\config\SCCCourseManDerby.java"}),
(sccCourseManDerbyBackEnd:CLASS {name: "SCCCourseManDerbyBackEnd", packageName: "software.config", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\software\config\SCCCourseManDerbyBackEnd.java"}),
(coursemanRfsGen:CLASS {name: "CourseManRFSGen", packageName: "software", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\software\CourseManRFSGen.java"}),
(coursemanRfsGenRun:CLASS {name: "CourseManRFSGenRun", packageName: "software", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\software\CourseManRFSGenRun.java"}),
(coursemanRfsRun:CLASS {name: "CourseManRFSRun", packageName: "software", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\software\CourseManRFSRun.java"}),
(coursemanRfsRunBE:CLASS {name: "CourseManRFSRunBE", packageName: "software", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\software\CourseManRFSRunBE.java"}),

// Domain classes.
(address:CLASS { name: "Address", packageName: "modules.address.model", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\modules\address\model\Address.java" }),
(courseModule:CLASS { name: "CourseModule", packageName: "modules.coursemodule.model", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\modules\coursemodule\model\CourseModule.java" }),
(compulsoryModule:CLASS { name: "CompulsoryModule", packageName: "modules.coursemodule.model", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\modules\coursemodule\model\CompulsoryModule.java" }),
(electiveModule:CLASS { name: "ElectiveModule", packageName: "modules.coursemodule.model", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\modules\coursemodule\model\ElectiveModule.java" }),
(enrolment:CLASS { name: "Enrolment", packageName: "modules.enrolment.model", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\modules\enrolment\model\Enrolment.java" }),
(student:CLASS { name: "Student", packageName: "modules.student.model", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\modules\student\model\Student.java" }),
(gender:CLASS { name: "Gender", packageName: "modules.student.model", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\modules\student\model\Gender.java" }),
(studentClass:CLASS { name: "StudentClass", packageName: "modules.studentclass.model", sourceFilePath: "\examples\courseman\mosar\src\main\java\org\jda\example\coursemanrestful\modules\studentclass\model\StudentClass.java" }),

// Main SCC class.
(sccCourseManClass:CLASS { name: "SCCCourseMan", packageName: "software.config" }),
(sccCourseManClass)<-[:ATTACH_TO]-(:ANNOTATION {
	name: "CourseManRFSGenDesc",
	stackSpec: "StackSpec.BE",
	genMode: "GenerationMode.SOURCE_CODE",
	beLangPlatform: "LangPlatform.SPRING",
	feProjPath: "/home/ducmle/tmp/restfstool-fe",
	feProjName: "fe-courseman",
	feProjResource: "src/main/resources/react",
	feOutputPath: "examples/courseman/fe-reactjs-gen",
	feServerPort: 5000,
	feAppClass: "FEApp.class",
	feThreaded: true ,
	bePackage: "org.jda.example.coursemanrestful.modules",
	beOutputPath: "src/main/java",
	beTargetPackage: "org.jda.example.coursemanrestful.backend",
	beAppClass: "BESpringApp.class",
	beServerPort: 8080
})-[:INSTANCE_OF]->(rfsGenDesc),
(sccCourseManClass)<-[:ATTACH_TO]-(courseManSystemDesc:ANNOTATION {
    name: "CourseManSystemDesc",
    appName: "Courseman",
    splashScreenLogo: "coursemanapplogo.jpg",
    language: "Language.English",
    orgDesc: "@OrgDesc(name = \"Faculty of IT\", address = \"Hanoi, Vietnam\", logo = \"hanu.gif\", url = \"http: //swinburne.edu.vn\")",
    dsDesc: "@DSDesc(type = \"postgresql\", dsUrl = \"//localhost:5432/domainds\", user = \"postgres\", password = \"Pinetar@04\", dsmType = DSM.class, domType = DOM.class, osmType = PostgreSQLOSM.class, connType = ConnectionType.Client)",
    setUpDesc: "@SysSetUpDesc(setUpConfigType = SetUpConfig.class)",
    securityDesc: "@SecurityDesc(isEnabled = false)"
})-[:INSTANCE_OF]->(systemDesc),
    
// Module student.
(moduleStudent:CLASS { name: "ModuleStudent", packageName: "modules.student" }),
(moduleStudent)<-[:ATTACH_TO]-(moduleStudentDescriptor:ANNOTATION {
	name: "ModuleStudent"
})-[:INSTANCE_OF]->(moduleDesc),
(moduleStudentDescriptor)-[:HAS_MODEL]->(moduleStudentModel:ANNOTATION { name: "ModuleStudentModel" })-[:INSTANCE_OF]->(modelDesc),
(moduleStudentModel)-[:HAS_DOMAIN_CLASS]->(student),
(moduleStudentDescriptor)-[:HAS_VIEW]->(:ANNOTATION {
	name: "ModuleStudentView",
	formTitle: "Form: Student",
	imageIcon: "Student.png",
	domainClassLabel: "Student",
	view: "View.class"
})-[:INSTANCE_OF]->(viewDesc),
(moduleStudentDescriptor)-[:HAS_CONTROLLER]->(:ANNOTATION { name: "ModuleStudentController" })-[:INSTANCE_OF]->(controllerDesc),
        
// Module address.
(moduleAddress:CLASS { name: "ModuleAddress", packageName: "modules.address" }),
(moduleAddress)<-[:ATTACH_TO]-(moduleAddressDescriptor:ANNOTATION {
	name: "ModuleAddress"
})-[:INSTANCE_OF]->(moduleDesc),
(moduleAddressDescriptor)-[:HAS_MODEL]->(moduleAddressModel:ANNOTATION { name: "ModuleAddressModel" })-[:INSTANCE_OF]->(modelDesc),
(moduleAddressModel)-[:HAS_DOMAIN_CLASS]->(address),
(moduleAddressDescriptor)-[:HAS_VIEW]->(:ANNOTATION {
	name: "ModuleAddressView",
	formTitle: "Form: Address",
	imageIcon: "Address.png",
	domainClassLabel: "Address",
	view: "View.class"
})-[:INSTANCE_OF]->(viewDesc),
(moduleAddressDescriptor)-[:HAS_CONTROLLER]->(:ANNOTATION { name: "ModuleAddressController" })-[:INSTANCE_OF]->(controllerDesc),
            
// Module student class.
(moduleStudentClass:CLASS { name: "ModuleStudentClass", packageName: "modules.studentclass" }),
(moduleStudentClass)<-[:ATTACH_TO]-(moduleStudentClassDescriptor:ANNOTATION {
	name: "ModuleStudentClass",
	isPrimary: true
})-[:INSTANCE_OF]->(moduleDesc),
(moduleStudentClassDescriptor)-[:HAS_MODEL]->(moduleStudentClassModel:ANNOTATION { name: "ModuleStudentClassModel" })-[:INSTANCE_OF]->(modelDesc),
(moduleStudentClassModel)-[:HAS_DOMAIN_CLASS]->(studentClass),
(moduleStudentClassDescriptor)-[:HAS_VIEW]->(:ANNOTATION {
	name: "ModuleStudentClassView",
	formTitle: "Manage Student Classes",
	imageIcon: "sclass.png",
	domainClassLabel: "Student Class",
	view: "View.class",
	viewType: "RegionType.Data",
	parent: "RegionName.Tools"
})-[:INSTANCE_OF]->(viewDesc),
(moduleStudentClassDescriptor)-[:HAS_CONTROLLER]->(:ANNOTATION {
	name: "ModuleStudentClassController",
	controller: "Controller.class",
	openPolicy: "OpenPolicy.O_C"
})-[:INSTANCE_OF]->(controllerDesc),
(moduleStudentClassDescriptor)-[:HAS_SETUP]->(:ANNOTATION { 
	name: "ModuleStudentClassSetUp", 
	postSetUp: "CopyResourceFilesCommand.class" 
})-[:INSTANCE_OF]->(setupDesc),
                
// Module enrolment.
(moduleEnrolment:CLASS { name: "ModuleEnrolment", packageName: "modules.enrolment" }),
(moduleEnrolment)<-[:ATTACH_TO]-(moduleEnrolmentDescriptor:ANNOTATION {
	name: "ModuleEnrolment",
	isPrimary: true
})-[:INSTANCE_OF]->(moduleDesc),
(moduleEnrolmentDescriptor)-[:HAS_MODEL]->(moduleEnrolmentModel:ANNOTATION { name: "ModuleEnrolmentModel" })-[:INSTANCE_OF]->(modelDesc),
(moduleEnrolmentModel)-[:HAS_DOMAIN_CLASS]->(enrolment),
(moduleEnrolmentDescriptor)-[:HAS_VIEW]->(:ANNOTATION {
	name: "ModuleEnrolmentView",
	formTitle: "Manage Enrolment",
	imageIcon: "enrolment.jpg",
	domainClassLabel: "Enrolment",
	view: "View.class",
	viewType: "RegionType.Data",
	parent: "RegionName.Tools"
})-[:INSTANCE_OF]->(viewDesc),
(moduleEnrolmentDescriptor)-[:HAS_CONTROLLER]->(:ANNOTATION { 
	name: "ModuleEnrolmentController", 
	controller: "Controller.class", 
	isDataFieldStateListener: true 
})-[:INSTANCE_OF]->(controllerDesc),
(moduleEnrolmentDescriptor)-[:HAS_SETUP]->(:ANNOTATION { 
	name: "ModuleEnrolmentSetUp", 
	postSetUp: "CopyResourceFilesCommand.class" 
})-[:INSTANCE_OF]->(setupDesc),
                    
// Module compulsory module.
(moduleCompulsoryModule:CLASS { name: "ModuleCompulsoryModule", packageName: "modules.coursemodule" }),
(moduleCompulsoryModule)<-[:ATTACH_TO]-(moduleCompulsoryModuleDescriptor:ANNOTATION {
	name: "ModuleCompulsoryModule",
	isPrimary: true
})-[:INSTANCE_OF]->(moduleDesc),
(moduleCompulsoryModuleDescriptor)-[:HAS_MODEL]->(moduleCompulsoryModuleModel:ANNOTATION { name: "ModuleCompulsoryModuleModel" })-[:INSTANCE_OF]->(modelDesc),
(moduleCompulsoryModuleModel)-[:HAS_DOMAIN_CLASS]->(compulsoryModule),
(moduleCompulsoryModuleDescriptor)-[:HAS_VIEW]->(:ANNOTATION {
	name: "ModuleCompulsoryModuleView",
	formTitle: "Manage Compulsory Module",
	imageIcon: "coursemodule.jpg",
	domainClassLabel: "Compulsory Module",
	view: "View.class",
	viewType: "RegionType.Data",
	parent: "RegionName.Tools"
})-[:INSTANCE_OF]->(viewDesc),
(moduleCompulsoryModuleDescriptor)-[:HAS_CONTROLLER]->(:ANNOTATION { 
	name: "ModuleCompulsoryModuleController", 
	controller: "Controller.class" 
})-[:INSTANCE_OF]->(controllerDesc),
(moduleCompulsoryModuleDescriptor)-[:HAS_SETUP]->(:ANNOTATION { 
	name: "ModuleCompulsoryModuleSetUp", 
	postSetUp: "CopyResourceFilesCommand.class" 
})-[:INSTANCE_OF]->(setupDesc),
                        
// Module elective module.
(moduleElectiveModule:CLASS { name: "ModuleElectiveModule", packageName: "modules.coursemodule" }),
(moduleElectiveModule)<-[:ATTACH_TO]-(moduleElectiveModuleDescriptor:ANNOTATION {
	name: "ModuleElectiveModule",
	isPrimary: true
})-[:INSTANCE_OF]->(moduleDesc),
(moduleElectiveModuleDescriptor)-[:HAS_MODEL]->(moduleElectiveModuleModel:ANNOTATION { name: "ModuleElectiveModuleModel" })-[:INSTANCE_OF]->(modelDesc),
(moduleElectiveModuleModel)-[:HAS_DOMAIN_CLASS]->(electiveModule),
(moduleElectiveModuleDescriptor)-[:HAS_VIEW]->(:ANNOTATION {
	name: "ModuleElectiveModuleView",
	formTitle: "Manage Elective Module",
	imageIcon: "coursemodule.jpg",
	domainClassLabel: "Elective Module",
	view: "View.class",
	viewType: "RegionType.Data",
	parent: "RegionName.Tools"
})-[:INSTANCE_OF]->(viewDesc),
(moduleElectiveModuleDescriptor)-[:HAS_CONTROLLER]->(:ANNOTATION { name: "ModuleElectiveModuleController", controller: "Controller.class" })-[:INSTANCE_OF]->(controllerDesc),
(moduleElectiveModuleDescriptor)-[:HAS_SETUP]->(:ANNOTATION { name: "ModuleElectiveModuleSetUp", postSetUp: "CopyResourceFilesCommand.class" })-[:INSTANCE_OF]->(setupDesc),
                            
// Module course module.
(moduleCourseModule:CLASS { name: "ModuleCourseModule", packageName: "modules.coursemodule" }),
(moduleCourseModule)<-[:ATTACH_TO]-(moduleCourseModuleDescriptor:ANNOTATION {
	name: "ModuleCourseModule",
	isPrimary: true
})-[:INSTANCE_OF]->(moduleDesc),
(moduleCourseModuleDescriptor)-[:HAS_MODEL]->(moduleCourseModuleModel:ANNOTATION { name: "ModuleCourseModuleModel" })-[:INSTANCE_OF]->(modelDesc),
(moduleCourseModuleModel)-[:HAS_DOMAIN_CLASS]->(courseModule),
(moduleCourseModuleDescriptor)-[:HAS_VIEW]->(:ANNOTATION {
	name: "ModuleCourseModuleView",
	formTitle: "Manage Course Modules",
	imageIcon: "coursemodule.jpg",
	domainClassLabel: "Course Module",
	view: "View.class",
	viewType: "RegionType.Data",
	parent: "RegionName.Tools"
})-[:INSTANCE_OF]->(viewDesc),
(moduleCourseModuleDescriptor)-[:HAS_CONTROLLER]->(:ANNOTATION { name: "ModuleCourseModuleController", controller: "Controller.class" })-[:INSTANCE_OF]->(controllerDesc),
(moduleCourseModuleDescriptor)-[:HAS_SETUP]->(:ANNOTATION { name: "ModuleCourseModuleSetUp", postSetUp: "CopyResourceFilesCommand.class" })-[:INSTANCE_OF]->(setupDesc),
                                
// Relationship between course module and compulsory and elective modules.
(moduleCompulsoryModule)-[:EXTENDS]->(moduleCourseModule),
(moduleElectiveModule)-[:EXTENDS]->(moduleCourseModule),
(moduleCourseModuleDescriptor)-[:HAS_SUBTYPE]->(moduleCompulsoryModule),
(moduleCourseModuleDescriptor)-[:HAS_SUBTYPE]->(moduleElectiveModule),
                                
// Module main.
(moduleMain:CLASS { name: "ModuleMain", packageName: "modules" }),
(moduleMain)<-[:ATTACH_TO]-(moduleMainDescriptor:ANNOTATION {
	name: "ModuleMain",
	type: "ModuleType.DomainMain"
})-[:INSTANCE_OF]->(moduleDesc),
(moduleMainDescriptor)-[:HAS_VIEW]->(:ANNOTATION {
	name: "ModuleMainView",
	formTitle: "Course Management App: CourseMan",
	imageIcon: "courseman.jpg",
	domainClassLabel: "Course Module",
	view: "View.class",
	viewType: "RegionType.Main",
	parent: "RegionName.Tools"
})-[:INSTANCE_OF]->(viewDesc),
(moduleMainDescriptor)-[:HAS_CONTROLLER]->(:ANNOTATION { name: "ModuleMainController", controller: "Controller.class" })-[:INSTANCE_OF]->(controllerDesc),
(moduleMainDescriptor)-[:HAS_SETUP]->(:ANNOTATION { name: "ModuleMainSetUp", postSetUp: "CopyResourceFilesCommand.class" })-[:INSTANCE_OF]->(setupDesc),

// Link CourseManSystemDesc's modules.
(courseManSystemDesc)-[:HAS_MODULE]->(moduleMain),
(courseManSystemDesc)-[:HAS_MODULE]->(moduleCourseModule),
(courseManSystemDesc)-[:HAS_MODULE]->(moduleEnrolment),
(courseManSystemDesc)-[:HAS_MODULE]->(moduleStudent),
(courseManSystemDesc)-[:HAS_MODULE]->(moduleAddress),
(courseManSystemDesc)-[:HAS_MODULE]->(moduleStudentClass);