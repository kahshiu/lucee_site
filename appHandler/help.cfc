<cfcomponent displayname="false">

  <cffunction name=init access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <cffunction name=home access="public" returntype="struct" output="false">
    <cfsavecontent variable="temp"> 
temp help
    </cfsavecontent>
    <cfset content = {}>
    <cfset content.type = "text/html">
    <cfset content.payload = 
      application.cache.twrapper.baseShell(
        application.cache.twrapper.navShell(temp)
      )>
    <cfreturn content>
  </cffunction>

</cfcomponent>
