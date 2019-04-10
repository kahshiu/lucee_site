<cfcomponent displayname="application routing" hint="">

  <cfset variables.dirs = {
     "appHandler": "public,private"
    ,"appObject": "private"
    ,"appQuery": "private"
    ,"lib": "private"
  }>

  <cffunction name=init access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <!--- begin: routing functions --->
  <cffunction name="resolveObj" access="public" returntype="struct" output="false">
    <cfargument name="path" type="string" required="true">
    <cfargument name="fn" type="string" required="true">
    <cfargument name="pathType" type="string" required="true">

    <cfset var _path = listToArray(arguments.path,".")>
    <cfset var _fn = arguments.fn>

    <cfif not structKeyExists(variables.dirs,_path[1])>
      <cfset _path = ["lib","fwError"]>
      <cfset _fn = "invalidPath">

    <cfelseif not application.cache.utils.isFileExists(_path,"cfc")>
      <cfset _path = ["lib","fwError"]>
      <cfset _fn = "invalidPath">

    <cfelseif not application.cache.utils.isFnExists(_path,_fn)>
      <cfset _path = ["lib","fwError"]>
      <cfset _fn = "invalidFn">

    <cfelseif listFindNocase(variables.dirs[_path[1]],arguments.pathType) eq 0>
      <cfset _path = ["lib","fwError"]>
      <cfset _fn = "deniedPath">
    </cfif>

    <cfreturn {path=arrayToList(_path,"."),fn=_fn}>
  </cffunction>

  <cffunction name="runObj" access="public" returntype="struct" output="false">
    <cfargument name="path" type="string" required="true">
    <cfargument name="fn" type="string" required="true">

    <cfset var _obj = createObject("component",arguments.path).init()>
    <cfset var _args = getHTTPRequestData().method eq "GET"? url: form>

    <cfset var _content = _obj[arguments.fn](argumentCollection=_args)>
    <cfif not structKeyExists(_content,"type")> <cfset _content.type = "text/html"> </cfif>
    <cfif not structKeyExists(_content,"payload")> <cfset _content.payload = ""> </cfif>
    <cfreturn _content>
  </cffunction>

  <cffunction name="route" access="public" returntype="any" output="false">
    <cfset var _path = structKeyExists(url,"path") and len(url.path) gt 0? url.path: "appHandler.home">
    <cfset var _fn = structKeyExists(url,"fn") and len(url.fn) gt 0? url.fn: "home">
    <cfset var _resolved = resolveObj(_path,_fn,"public")>

    <cfreturn runObj(_resolved.path,_resolved.fn)>
  </cffunction>
  <!--- end  : routing functions --->

</cfcomponent>
