<cfcomponent displayname="" hint="">
  <cffunction access="public" name="init" returntype="any" output=false description="initialise">
    <cfreturn this>
  </cffunction>

  <cffunction access="public" name="home" returntype="struct" output=false description="">
    <cfsavecontent variable="temp"> 
temp home
    </cfsavecontent>
    <cfset content = {}>
    <cfset content.type = "text/html">
    <cfset content.payload = 
        application.cache.wrap.html(
          application.cache.wrap.layout1(
            application.cache.wrap.navBase()
            ,temp
          )
        )>
    <cfreturn content>
  </cffunction>
  
</cfcomponent>
