<cfcomponent displayname="" hint="">
  <cffunction access="public" name="init" returntype="any" output=false description="initialise">
    <cfreturn this>
  </cffunction>

  <cffunction access="public" name="home" returntype="struct" output=false description="">
    <cfsavecontent variable="temp"> 
temp ccc
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
