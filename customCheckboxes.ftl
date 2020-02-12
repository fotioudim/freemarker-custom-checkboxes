<!--Custom Bootstrap freemarker checkboxes macros -->

<#function contains list item>
    <#list list as nextInList>
    <#if nextInList == item><#return true></#if>
    </#list>
    <#return false>
</#function>

<#macro bind path>
    <#if htmlEscape?exists>
        <#assign status = springMacroRequestContext.getBindStatus(path, htmlEscape)>
    <#else>
        <#assign status = springMacroRequestContext.getBindStatus(path)>
    </#if>
    <#-- assign a temporary value, forcing a string representation for any
    kind of variable. This temp value is only used in this macro lib -->
    <#if status.value?exists && status.value?is_boolean>
        <#assign stringStatusValue=status.value?string>
    <#else>
        <#assign stringStatusValue=status.value?default("")>
    </#if>
</#macro>

<#macro closeTag>
    <#if xhtmlCompliant?exists && xhtmlCompliant>/><#else>></#if>
</#macro>

<#macro customFormCheckboxes path options>
	<@bind path/>
    <#list options?keys as value>
    <div class="custom-control custom-checkbox">
	    <#assign id="${status.expression?replace('[','')?replace(']','')}${value_index}">
	    <#assign isSelected = contains(status.actualValue?default([""]), value)>
	    <input class="custom-control-input" type="checkbox" id="${id}" name="${status.expression}" value="${value}"<#if isSelected> checked="checked"</#if><@closeTag/>
	    <label class="custom-control-label" for="${id}">${options[value]}</label> <br/>
    </div>
    </#list>
    <input type="hidden" name="_${status.expression}" value="on"/>
</#macro>
