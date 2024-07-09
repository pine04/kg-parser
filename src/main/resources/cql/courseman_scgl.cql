// General nodes -----------------------------------------------------------------------------------------------------

create (Annotation:JAVA_ELEMENT {name: "Annotation"}) 
create (Class:JAVA_ELEMENT {name: "Class"})
create (Attribute:JAVA_ELEMENT {name: "Attribute"}) 
create (Method:JAVA_ELEMENT {name: "Method"})

create (Class)-[:HAS]->(Attribute)
create (Class)-[:HAS]->(Method)


create (ModelDesc:ANNOTATION {
    name: 'ModelDesc'
})
create (ModelDesc)-[:IS_A]->(Annotation)

create (ViewDesc:ANNOTATION {
    name: 'ViewDesc'
})
create (ViewDesc)-[:IS_A]->(Annotation)

create (ControllerDesc:ANNOTATION {
    name: 'ControllerDesc'
})
create (ControllerDesc)-[:IS_A]->(Annotation)

create (AttributeDesc:ANNOTATION {
    name: 'AttributeDesc'
})
create (AttributeDesc)-[:IS_A]->(Annotation)

create (DOpt:ANNOTATION {
    name: "DOpt"
})
create (DOpt)-[:IS_A]->(Annotation)
create (DOpt)-[:ATTACH_TO]->(Method)

create (DAttr:ANNOTATION {
    name: "DAttr"
})
create (DAttr)-[:IS_A]->(Annotation)
create (DAttr)-[:ATTACH_TO]->(Attribute)

create (DClass:ANNOTATION {
    name: "DClass"
})
create (DClass)-[:IS_A]->(Annotation)
create (DClass)-[:HAS]->(DAttr)
create (DClass)-[:HAS]->(DOpt)

create (ModuleDescriptor:ANNOTATION {
    name: "ModuleDescriptor"
})
create (ModuleDescriptor)-[:IS_A]->(Annotation)
create (ModuleDescriptor)-[:HAS]->(DClass)

create (SystemDesc:ANNOTATION {
    name: "SystemDesc"
})
create (SystemDesc)-[:IS_A]->(Annotation)
create (SystemDesc)-[:HAS]->(ModuleDescriptor)

create (RFSGenDesc:ANNOTATION {
    name: "RFSGenDesc"
})
create (RFSGenDesc)-[:IS_A]->(Annotation)


// High level nodes -----------------------------------------------------------------------------------------------------


create(SCCCourseMan:CLASS {name: "SCCCourseMan"})

create (SCCCourseManGenDesc:USE_OF_ANNOTATION {
    name: "RFSGenDesc",
    stackSpec: "StackSpec.FE",
    genMode: "GenerationMode.SOURCE_CODE", 
    beLangPlatform: "LangPlatform.SPRING",
    feProjPath: "/home/ducmle/tmp/restfstool-fe",
    feProjName: "fe-courseman",
    feProjResource: "src/main/resources/react",
    feOutputPath: "examples/courseman/fe-reactjs-gen",
    feServerPort: 3000,
    feAppClass: "FEApp.class",
    feThreaded: true,
    bePackage: "org.jda.example.coursemanrestful.modules",
    beOutputPath: "src/main/java", 
    beTargetPackage: "org.jda.example.coursemanrestful.backend",
    beAppClass: "BESpringApp.class",
    beServerPort: 8080
})

create (SCCCourseManSystemDesc:USE_OF_ANNOTATION {
    name: "SystemDesc",
    appName: "Courseman",
    splashScreenLogo: "coursemanapplogo.jpg",
    language: "Language.English",
    orgDesc: "OrgDesc",
    dsDesc: "DSDesc",
    sysModules: "",
    setUpDesc: "",
    securityDesc: ""
})

create (SCCCourseManGenDesc)-[:INSTANCE_OF]->(RFSGenDesc)
create (SCCCourseManSystemDesc)-[:INSTANCE_OF]->(SystemDesc)

create (SCCCourseManGenDesc)-[:ATTACH_TO]->(SCCCourseMan)
create (SCCCourseManSystemDesc)-[:ATTACH_TO]->(SCCCourseMan)


// Module level nodes -----------------------------------------------------------------------------------------------------


// StudentClass -----------------------------------------------------------------------------------------------------
create (studentClassTitleDescriptor:ANNOTATION {
    label: "Student Class"
})
create (studentClassTitleDescriptor)-[:INSTANCE_OF]->(AttributeDesc)
create (studentClassTitle:MODULE_ATTRIBUTE {
    name: "title"
})
create (studentClassTitleDescriptor)-[:ATTACH_TO]->(studentClassTitle)

create (studentClassIdDescriptor:ANNOTATION {
    label: "ID"
})
create (studentClassIdDescriptor)-[:INSTANCE_OF]->(AttributeDesc)
create (studentClassId:MODULE_ATTRIBUTE {
    name: "id"
})
create (studentClassIdDescriptor)-[:ATTACH_TO]->(studentClassId)

create (studentClassNameDescriptor:ANNOTATION {
    label: "Name"
})
create (studentClassNameDescriptor)-[:INSTANCE_OF]->(AttributeDesc)
create (studentClassName:MODULE_ATTRIBUTE {
    name: "name"
})
create (studentClassNameDescriptor)-[:ATTACH_TO]->(studentClassName)

create (studentClassStudentsDescriptorControllerDesc:ANNOTATION {
    openPolicy: "L_C"
})
create (studentClassStudentsDescriptorControllerDesc)-[:INSTANCE_OF]->(ControllerDesc)
create (studentClassStudentsDescriptor:ANNOTATION {
    label: "Students",
    type: "DefaultPanel"
})
create (studentClassStudentsDescriptor)-[:INSTANCE_OF]->(AttributeDesc)
create (studentClassStudentsDescriptor)-[:HAS]->(studentClassStudentsDescriptorControllerDesc)
create (studentClassStudents:MODULE_ATTRIBUTE {
    name: "students"
})
create (studentClassStudentsDescriptor)-[:ATTACH_TO]->(studentClassStudents)

create (StudentClassModuleDescriptor:USE_OF_ANNOTATION {
    name: "ModuleStudentClass",
    viewDesc: "ViewDesc",
    controllerDesc: "ControllerDesc",
    type: "ModuleType.DomainMain",
    setUpDesc: "SetUpDesc"
})
create (StudentClassModuleDescriptor)-[:INSTANCE_OF]->(ModuleDescriptor)
create (SCCCourseManSystemDesc)-[:HAS]->(StudentClassModuleDescriptor)

create(StudentClassModel:USE_OF_ANNOTATION {
    name: "StudentClassModel"
})
create (StudentClassModel)-[:INSTANCE_OF]->(DClass)
create (StudentClassModuleDescriptor)-[:HAS]->(StudentClassModel)

create(ModuleStudentClass:CLASS {
    name: "ModuleStudentClass"
})
create (StudentClassModuleDescriptor)-[:ATTACH_TO]->(ModuleStudentClass)
create (SCCCourseMan)-[:HAS]->(ModuleStudentClass)
create (ModuleStudentClass)-[:HAS]->(studentClassTitle)
create (ModuleStudentClass)-[:HAS]->(studentClassName)
create (ModuleStudentClass)-[:HAS]->(studentClassId)
create (ModuleStudentClass)-[:HAS]->(studentClassStudents)

create(StudentClass:CLASS {
    name: "StudentClass"
})
create (StudentClassModel)-[:ATTACH_TO]->(StudentClass)
create (ModuleStudentClass)-[:HAS]->(StudentClass)

create (ModuleStudentClass)-[:IS_A]->(Class)
create (StudentClass)-[:IS_A]->(Class)



// Address -----------------------------------------------------------------------------------------------------
create (AddressModuleDescriptor:USE_OF_ANNOTATION {
    name: "ModuleAddress",
    viewDesc: "ViewDesc",
    controllerDesc: "ControllerDesc",
    type: "ModuleType.DomainMain",
    setUpDesc: "SetUpDesc"
})
create (AddressModuleDescriptor)-[:INSTANCE_OF]->(ModuleDescriptor)
create (SCCCourseManSystemDesc)-[:HAS]->(AddressModuleDescriptor)

create(AddressModel:USE_OF_ANNOTATION {
    name: "AddressModel"
})
create (AddressModel)-[:INSTANCE_OF]->(DClass)
create (AddressModuleDescriptor)-[:HAS]->(AddressModel)

create(ModuleAddress:CLASS {
    name: "ModuleAddress"
})
create (AddressModuleDescriptor)-[:ATTACH_TO]->(ModuleAddress)
create (SCCCourseMan)-[:HAS]->(ModuleAddress)

create(Address:CLASS {
    name: "Address"
})
create (AddressModel)-[:ATTACH_TO]->(Address)
create (ModuleAddress)-[:HAS]->(Address)

create (ModuleAddress)-[:IS_A]->(Class)
create (Address)-[:IS_A]->(Class)



// Student -----------------------------------------------------------------------------------------------------
create (StudentModuleDescriptor:USE_OF_ANNOTATION {
    name: "ModuleStudent",
    viewDesc: "ViewDesc",
    controllerDesc: "ControllerDesc",
    type: "ModuleType.DomainMain",
    setUpDesc: "SetUpDesc"
})
create (StudentModuleDescriptor)-[:INSTANCE_OF]->(ModuleDescriptor)
create (SCCCourseManSystemDesc)-[:HAS]->(StudentModuleDescriptor)

create(StudentModel:USE_OF_ANNOTATION {
    name: "StudentModel"
})
create (StudentModel)-[:INSTANCE_OF]->(DClass)
create (StudentModuleDescriptor)-[:HAS]->(StudentModel)

create(ModuleStudent:CLASS {
    name: "ModuleStudent"
})
create (StudentModuleDescriptor)-[:ATTACH_TO]->(ModuleStudent)
create (SCCCourseMan)-[:HAS]->(ModuleStudent)

create(Student:CLASS {
    name: "Student"
})
create (StudentModel)-[:ATTACH_TO]->(Student)
create (ModuleStudent)-[:HAS]->(Student)

create (ModuleStudent)-[:IS_A]->(Class)
create (Student)-[:IS_A]->(Class)



// Enrolment -----------------------------------------------------------------------------------------------------
create (EnrolmentModuleDescriptor:USE_OF_ANNOTATION {
    name: "ModuleEnrolment",
    viewDesc: "ViewDesc",
    controllerDesc: "ControllerDesc",
    type: "ModuleType.DomainMain",
    setUpDesc: "SetUpDesc"
})
create (EnrolmentModuleDescriptor)-[:INSTANCE_OF]->(ModuleDescriptor)
create (SCCCourseManSystemDesc)-[:HAS]->(EnrolmentModuleDescriptor)

create(EnrolmentModel:USE_OF_ANNOTATION {
    name: "EnrolmentModel"
})
create (EnrolmentModel)-[:INSTANCE_OF]->(DClass)
create (EnrolmentModuleDescriptor)-[:HAS]->(EnrolmentModel)

create(ModuleEnrolment:CLASS {
    name: "ModuleEnrolment"
})
create (EnrolmentModuleDescriptor)-[:ATTACH_TO]->(ModuleEnrolment)
create (SCCCourseMan)-[:HAS]->(ModuleEnrolment)

create(Enrolment:CLASS {
    name: "Enrolment"
})
create (EnrolmentModel)-[:ATTACH_TO]->(Enrolment)
create (ModuleEnrolment)-[:HAS]->(Enrolment)

create (ModuleEnrolment)-[:IS_A]->(Class)
create (Enrolment)-[:IS_A]->(Class)



// CourseModule -----------------------------------------------------------------------------------------------------
create (CourseModuleModuleDescriptor:USE_OF_ANNOTATION {
    name: "ModuleCourseModule",
    viewDesc: "ViewDesc",
    controllerDesc: "ControllerDesc",
    type: "ModuleType.DomainMain",
    setUpDesc: "SetUpDesc"
})
create (CourseModuleModuleDescriptor)-[:INSTANCE_OF]->(ModuleDescriptor)
create (SCCCourseManSystemDesc)-[:HAS]->(CourseModuleModuleDescriptor)

create(CourseModuleModel:USE_OF_ANNOTATION {
    name: "CourseModuleModel"
})
create (CourseModuleModel)-[:INSTANCE_OF]->(DClass)
create (CourseModuleModuleDescriptor)-[:HAS]->(CourseModuleModel)

create(ModuleCourseModule:CLASS {
    name: "ModuleCourseModule"
})
create (CourseModuleModuleDescriptor)-[:ATTACH_TO]->(ModuleCourseModule)
create (SCCCourseMan)-[:HAS]->(ModuleCourseModule)

create(CourseModule:CLASS {
    name: "CourseModule"
})
create (CourseModuleModel)-[:ATTACH_TO]->(CourseModule)
create (ModuleCourseModule)-[:HAS]->(CourseModule)

create (ModuleCourseModule)-[:IS_A]->(Class)
create (CourseModule)-[:IS_A]->(Class)



// Main -----------------------------------------------------------------------------------------------------
create (MainModuleDescriptor:USE_OF_ANNOTATION {
    name: "ModuleMain",
    viewDesc: "ViewDesc",
    controllerDesc: "ControllerDesc",
    type: "ModuleType.DomainMain",
    setUpDesc: "SetUpDesc"
})
create (MainModuleDescriptor)-[:INSTANCE_OF]->(ModuleDescriptor)
create (SCCCourseManSystemDesc)-[:HAS]->(MainModuleDescriptor)

create(MainModel:USE_OF_ANNOTATION {
    name: "MainModel"
})
create (MainModel)-[:INSTANCE_OF]->(DClass)
create (MainModuleDescriptor)-[:HAS]->(MainModel)

create(ModuleMain:CLASS {
    name: "ModuleMain"
})
create (MainModuleDescriptor)-[:ATTACH_TO]->(ModuleMain)
create (SCCCourseMan)-[:HAS]->(ModuleMain)

create(Main:CLASS {
    name: "Main"
})
create (MainModel)-[:ATTACH_TO]->(Main)
create (ModuleMain)-[:HAS]->(Main)

create (ModuleMain)-[:IS_A]->(Class)
create (Main)-[:IS_A]->(Class)
