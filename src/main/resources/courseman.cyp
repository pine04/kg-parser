CREATE

// Different annotation types supported by the current version of the parser.
(systemDesc:ANNOTATION_TYPE { name: "SystemDesc" }),
(rfsGenDesc:ANNOTATION_TYPE { name: "RFSGenDesc" }),
(moduleDesc:ANNOTATION_TYPE { name: "ModuleDescriptor" }),
(modelDesc:ANNOTATION_TYPE { name: "ModelDesc" }),
(viewDesc:ANNOTATION_TYPE { name: "ViewDesc" }),
(controllerDesc:ANNOTATION_TYPE { name: "ControllerDesc" }),
(setupDesc:ANNOTATION_TYPE { name: "SetUpDesc" }),
(attributeDesc:ANNOTATION_TYPE { name: "AttributeDesc" }),
(select:ANNOTATION_TYPE { name: "Select" }),
(jsValidation:ANNOTATION_TYPE { name: "JSValidation" }),
(propertyDesc:ANNOTATION_TYPE { name: "PropertyDesc" }),

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

(moduleStudent)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "title",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Manage Students" })-[:INSTANCE_OF]->(attributeDesc),
(moduleStudent)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "id",
	dataType: "int"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Student ID" })-[:INSTANCE_OF]->(attributeDesc),
(moduleStudent)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "name",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Full Name" })-[:INSTANCE_OF]->(attributeDesc),
(moduleStudent)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "gender",
	dataType: "Gender",
	requiredImport: "org.jda.example.coursemanrestful.modules.student.model.Gender"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Gender" })-[:INSTANCE_OF]->(attributeDesc),
(moduleStudent)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "dob",
	dataType: "Date",
	requiredImport: "java.util.Date"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Date of birth" })-[:INSTANCE_OF]->(attributeDesc),
(moduleStudent)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "email",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Email" })-[:INSTANCE_OF]->(attributeDesc),
(moduleStudent)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "address",
	dataType: "Address",
	requiredImport: "org.jda.example.coursemanrestful.modules.address.model.Address"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Current Address" })-[:INSTANCE_OF]->(attributeDesc),
(moduleStudent)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "studentClass",
	dataType: "StudentClass",
	requiredImport: "org.jda.example.coursemanrestful.modules.studentclass.model.StudentClass"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Student class" })-[:INSTANCE_OF]->(attributeDesc),
(moduleStudent)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "enrolments",
	dataType: "Collection<Enrolment>",
	requiredImport: "java.util.Collection,org.jda.example.coursemanrestful.modules.enrolment.model.Enrolment"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Course Enrolments" })-[:INSTANCE_OF]->(attributeDesc),
        
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

(moduleAddress)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "title",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Form: Address" })-[:INSTANCE_OF]->(attributeDesc),
(moduleAddress)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "id",
	dataType: "int"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "ID" })-[:INSTANCE_OF]->(attributeDesc),
(moduleAddress)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "name",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "City name" })-[:INSTANCE_OF]->(attributeDesc),
(moduleAddress)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "student",
	dataType: "Student",
	requiredImport: "org.jda.example.coursemanrestful.modules.student.model.Student"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Student" })-[:INSTANCE_OF]->(attributeDesc),
            
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

(moduleStudentClass)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "title",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Student Class" })-[:INSTANCE_OF]->(attributeDesc),
(moduleStudentClass)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "id",
	dataType: "int"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Id" })-[:INSTANCE_OF]->(attributeDesc),
(moduleStudentClass)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "name",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Name" })-[:INSTANCE_OF]->(attributeDesc),
(moduleStudentClass)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "students",
	dataType: "List<Student>",
	requiredImport: "java.util.List,org.jda.example.coursemanrestful.modules.student.model.Student"
})<-[:ATTACH_TO]-(studentsAttributeAnnotation:ANNOTATION {
	label: "Gender",
	type: "DefaultPanel"
})-[:INSTANCE_OF]->(attributeDesc),
(studentsAttributeAnnotation)-[:HAS_CONTROLLER]->(:ANNOTATION { openPolicy: "OpenPolicy.L_C" })-[:INSTANCE_OF]->(controllerDesc),
                
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
	isDataFieldStateListener: "true"
})-[:INSTANCE_OF]->(controllerDesc),
(moduleEnrolmentDescriptor)-[:HAS_SETUP]->(:ANNOTATION { 
	name: "ModuleEnrolmentSetUp", 
	postSetUp: "CopyResourceFilesCommand.class" 
})-[:INSTANCE_OF]->(setupDesc),

(moduleEnrolment)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "title",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Manage Enrolments" })-[:INSTANCE_OF]->(attributeDesc),
(moduleEnrolment)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "id",
	dataType: "int"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Id", alignX: "AlignmentX.Center" })-[:INSTANCE_OF]->(attributeDesc),
(moduleEnrolment)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "student",
	dataType: "Student",
	requiredImport: "org.jda.example.coursemanrestful.modules.student.model.Student"
})<-[:ATTACH_TO]-(studentAttributeAnnotation:ANNOTATION {
	label: "Student",
	type: "JComboField",
	loadOidWithBoundValue: "true",
	displayOidWithBoundValue: "true"
})-[:INSTANCE_OF]->(attributeDesc),
(studentAttributeAnnotation)-[:HAS_SELECT]->(:ANNOTATION {
	clazz: "Student",
	attributes: "name",
	requiredImport: "org.jda.example.coursemanrestful.modules.student.model.Student"
})-[:INSTANCE_OF]->(select),
(moduleEnrolment)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "courseModule",
	dataType: "CourseModule",
	requiredImport: "org.jda.example.coursemanrestful.modules.coursemodule.model.CourseModule"
})<-[:ATTACH_TO]-(courseModuleAttributeAnnotation:ANNOTATION {
	label: "Course Module",
	type: "JComboField",
	width: 80,
	height: 25,
	isStateEventSource: "true",
	alignX: "AlignmentX.Center"
})-[:INSTANCE_OF]->(attributeDesc),
(courseModuleAttributeAnnotation)-[:HAS_SELECT]->(:ANNOTATION {
	clazz: "CourseModule",
	attributes: "code",
	requiredImport: "org.jda.example.coursemanrestful.modules.coursemodule.model.CourseModule"
})-[:INSTANCE_OF]->(select),
(moduleEnrolment)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "internalMark",
	dataType: "double"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Internal Mark", alignX: "AlignmentX.Center" })-[:INSTANCE_OF]->(attributeDesc),
(moduleEnrolment)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "examMark",
	dataType: "double"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Exam Mark", alignX: "AlignmentX.Center" })-[:INSTANCE_OF]->(attributeDesc),
(moduleEnrolment)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "finalGrade",
	dataType: "char"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Final Grade", alignX: "AlignmentX.Center" })-[:INSTANCE_OF]->(attributeDesc),
(moduleEnrolment)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "startDate",
	dataType: "Date",
	requiredImport: "java.util.Date"
})<-[:ATTACH_TO]-(:ANNOTATION { id: "date_range", label: "Date range", inputType: "InputTypes.DateRangeStart" })-[:INSTANCE_OF]->(attributeDesc),
(moduleEnrolment)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "endDate",
	dataType: "Date",
	requiredImport: "java.util.Date"
})<-[:ATTACH_TO]-(:ANNOTATION { id: "date_range", label: "Date range", inputType: "InputTypes.DateRangeEnd" })-[:INSTANCE_OF]->(attributeDesc),
                    
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

(moduleCompulsoryModule)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "title",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Form: Compulsory Module" })-[:INSTANCE_OF]->(attributeDesc),
                        
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

(moduleElectiveModule)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "title",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Form: Elective Module" })-[:INSTANCE_OF]->(attributeDesc),
(moduleElectiveModule)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "deptName",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Dept. Name", alignX: "AlignmentX.Center" })-[:INSTANCE_OF]->(attributeDesc),
                            
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

(moduleCourseModule)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "title",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Form: Course Module" })-[:INSTANCE_OF]->(attributeDesc),
(moduleCourseModule)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "id",
	dataType: "int"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Id", alignX: "AlignmentX.Center" })-[:INSTANCE_OF]->(attributeDesc),
(moduleCourseModule)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "code",
	dataType: "String"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Code", alignX: "AlignmentX.Center" })-[:INSTANCE_OF]->(attributeDesc),
(moduleCourseModule)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "name",
	dataType: "String"
})<-[:ATTACH_TO]-(nameAttributeAnnotation:ANNOTATION { label: "Name" })-[:INSTANCE_OF]->(attributeDesc),
(nameAttributeAnnotation)-[:HAS_JS_VALIDATION]->(:ANNOTATION {
	regex: "/^S\\\\d+$/",
	invalidMsg: "Name must start with 'S' and followed by one or more numbers!"
})-[:INSTANCE_OF]->(jsValidation),
(moduleCourseModule)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "description",
	dataType: "String"
})<-[:ATTACH_TO]-(descriptionAttributeAnnotation:ANNOTATION { label: "Description", inputType: "InputTypes.TextArea" })-[:INSTANCE_OF]->(attributeDesc),
(descriptionAttributeAnnotation)-[:HAS_JS_VALIDATION]->(:ANNOTATION {
	optional: "true",
	regex: "/^[A-Za-z\\\\s]$/",
	invalidMsg: "Description must only include characters!"
})-[:INSTANCE_OF]->(jsValidation),
(moduleCourseModule)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "semester",
	dataType: "int"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Semester", alignX: "AlignmentX.Center" })-[:INSTANCE_OF]->(attributeDesc),
(moduleCourseModule)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "cost",
	dataType: "int"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Cost", inputType: "InputTypes.Slider" })-[:INSTANCE_OF]->(attributeDesc),
(moduleCourseModule)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "credits",
	dataType: "int"
})<-[:ATTACH_TO]-(creditsAttributeAnnotation:ANNOTATION { label: "Credits", alignX: "AlignmentX.Center" })-[:INSTANCE_OF]->(attributeDesc),
(creditsAttributeAnnotation)-[:HAS_JS_VALIDATION]->(:ANNOTATION {
	regex: "/^\\\\d+$/",
	invalidMsg: "Credits must be a number or a float number!"
})-[:INSTANCE_OF]->(jsValidation),
(moduleCourseModule)-[:HAS_ATTRIBUTE]->(:ATTRIBUTE {
	name: "rating",
	dataType: "int"
})<-[:ATTACH_TO]-(:ANNOTATION { label: "Rating", inputType: "InputTypes.Rating" })-[:INSTANCE_OF]->(attributeDesc),
                                
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
(moduleMainDescriptor)-[:HAS_VIEW]->(moduleMainViewDesc:ANNOTATION {
	name: "ModuleMainView",
	formTitle: "Course Management App: CourseMan",
	imageIcon: "courseman.jpg",
	view: "View.class",
	viewType: "RegionType.Main",
	parent: "RegionName.Tools",
	topX: "0.5",
	topY: "0.5",
	widthRatio: "0.75f",
	heightRatio: "1f",
	children: "RegionName.Desktop,RegionName.MenuBar,RegionName.ToolBar,RegionName.StatusBar",
	excludeComponents: "RegionName.Add"
})-[:INSTANCE_OF]->(viewDesc),
(moduleMainViewDesc)-[:HAS_PROPERTY]->(:ANNOTATION {
	name: "PropertyName.view_toolBar_buttonIconDisplay",
	valueAsString: "true",
	valueType: "Boolean.class"
})-[:INSTANCE_OF]->(propertyDesc),
(moduleMainViewDesc)-[:HAS_PROPERTY]->(:ANNOTATION {
	name: "PropertyName.view_toolBar_buttonTextDisplay",
	valueAsString: "false",
	valueType: "Boolean.class"
})-[:INSTANCE_OF]->(propertyDesc),
(moduleMainViewDesc)-[:HAS_PROPERTY]->(:ANNOTATION {
	name: "PropertyName.view_searchToolBar_buttonIconDisplay",
	valueAsString: "true",
	valueType: "Boolean.class"
})-[:INSTANCE_OF]->(propertyDesc),
(moduleMainViewDesc)-[:HAS_PROPERTY]->(:ANNOTATION {
	name: "PropertyName.view_searchToolBar_buttonTextDisplay",
	valueAsString: "false",
	valueType: "Boolean.class"
})-[:INSTANCE_OF]->(propertyDesc),
(moduleMainViewDesc)-[:HAS_PROPERTY]->(:ANNOTATION {
	name: "PropertyName.view_lang_international",
	valueAsString: "true",
	valueType: "Boolean.class"
})-[:INSTANCE_OF]->(propertyDesc),
(moduleMainDescriptor)-[:HAS_CONTROLLER]->(:ANNOTATION { name: "ModuleMainController", controller: "Controller.class" })-[:INSTANCE_OF]->(controllerDesc),
(moduleMainDescriptor)-[:HAS_SETUP]->(:ANNOTATION { name: "ModuleMainSetUp", postSetUp: "CopyResourceFilesCommand.class" })-[:INSTANCE_OF]->(setupDesc),

// Link CourseManSystemDesc's modules.
(courseManSystemDesc)-[:HAS_MODULE]->(moduleMain),
(courseManSystemDesc)-[:HAS_MODULE]->(moduleCourseModule),
(courseManSystemDesc)-[:HAS_MODULE]->(moduleEnrolment),
(courseManSystemDesc)-[:HAS_MODULE]->(moduleStudent),
(courseManSystemDesc)-[:HAS_MODULE]->(moduleAddress),
(courseManSystemDesc)-[:HAS_MODULE]->(moduleStudentClass);