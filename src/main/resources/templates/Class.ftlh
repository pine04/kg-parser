package ${packageName};

<#list imports as import>
import ${import};
</#list>

<#list annotations as annotation>
${annotation}
</#list>
public class ${className}<#if extendsList?size gt 0> extends ${extendsList?join(", ")}</#if> {
}