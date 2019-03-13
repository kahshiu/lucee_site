<cfcomponent displayname="false">
  <cffunction name=init access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <cffunction name=deniedPath access="public" returntype="any" output="false">
    <cfsavecontent variable="temp">
denied path 
    </cfsavecontent>

    <cfset content = {}>
    <cfset content.type = "text/html">
    <cfset content.payload = application.cache.twrapper.baseShell(temp)>
    <cfreturn content>
  </cffunction>

  <cffunction name=invalidPath access="public" returntype="any" output="false">
    <cfsavecontent variable="temp">
invalid path 
    </cfsavecontent>

    <cfset content = {}>
    <cfset content.type = "text/html">
    <cfset content.payload = application.cache.twrapper.baseShell(temp)>
    <cfreturn content>
  </cffunction>

  <cffunction name=invalidFn access="public" returntype="any" output="false">
    <cfsavecontent variable="temp">
invalid fn 
    </cfsavecontent>

    <cfset content = {}>
    <cfset content.type = "text/html">
    <cfset content.payload = application.cache.twrapper.baseShell(temp)>
    <cfreturn content>
  </cffunction>

</cfcomponent>
