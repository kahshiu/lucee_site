<cfcomponent displayname="" hint="">
  <cffunction access="public" name="init" returntype="any" output=false description="initialise">
    <cfreturn this>
  </cffunction>

  <cffunction access="public" name="home" returntype="struct" output=false description="">
    <cfsavecontent variable="temp"> 
    <div>
home
    </div>
    </cfsavecontent>

    <cfset content = {}>
    <cfset content.type = "text/html">
    <cfset content.payload = application.cache.wrap.layout1(temp)>
    <cfreturn content>
  </cffunction>
  
</cfcomponent>
