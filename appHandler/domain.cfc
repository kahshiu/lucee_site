<cfcomponent displayname="false">
  <cffunction name=init access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <cffunction name=dsp_fileSave access="public" returntype="any" output="false">
    <cfsavecontent variable="temp">
        testing file page
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
