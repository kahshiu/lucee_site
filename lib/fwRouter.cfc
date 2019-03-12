<cfcomponent displayname="application routing" hint="">

  <cffunction name=init access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <!--- begin: routing functions --->
  <cffunction name="genObject" access="public" returntype="any" output="false">
    <cfargument name="path" type="array" required="true">
    <cfargument name="fn" type="string" required="true">

    <cfset var _path = arguments.path>
    <cfset var _fn = arguments.fn>

    <cfif not application.cache.utils.isFileExists(arguments.path,"cfc")>
      <cfset _path = ["fwError"]>
      <cfset _fn = "invalidPath">
    </cfif>

    <cfif not application.cache.utils.isFnExists(arguments.path,arguments.fn)>
      <cfset _path = ["fwError"]>
      <cfset _fn = "invalidFn">
    </cfif>

    <cfreturn createObject("component",arrayToList(_path,".")).init()>
  </cffunction>

  <cffunction name="runObj" access="public" returntype="struct" output="false">
    <cfargument name="path" type="string" required="true">
    <cfargument name="fn" type="string" required="true">

    <cfset var _obj = genObject(listToArray(arguments.path,"."),arguments.fn)>
    <cfset var _args = getHTTPRequestData().method eq "GET"? url: form>

    <cfset var _content = _obj[arguments.fn](argumentCollection=_args)>
    <cfif not structKeyExists(_content,"type")> <cfset _content.type = "html"> </cfif>
    <cfif not structKeyExists(_content,"payload")> <cfset _content.payload = ""> </cfif>

    <cfreturn _content>
  </cffunction>

  <cffunction name="route" access="public" returntype="any" output="false">
    <cfset var _path = structKeyExists(url,"path") and len(url.path) gt 0? url.path: "appHandler.home">
    <cfset var _fn = structKeyExists(url,"fn") and len(url.fn) gt 0? url.fn: "home">
    <cfreturn runObj(_path,_fn)>
  </cffunction>
  <!--- end  : routing functions --->

</cfcomponent>
