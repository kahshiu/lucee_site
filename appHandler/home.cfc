<cfcomponent displayname="" hint="">
  <cffunction access="public" name="init" returntype="any" output=false description="initialise">
    <cfreturn this>
  </cffunction>

  <cffunction access="public" name="home" returntype="struct" output=false description="">
    <cfsavecontent variable="temp">
      <cfoutput>
hello
      </cfoutput>
    </cfsavecontent>

    <cfset content = {}>
    <cfset content.type = "text/html">
    <cfset content.payload = application.cache.twrapper.baseShell(temp)>
    <cfreturn content>
  </cffunction>
  
</cfcomponent>
