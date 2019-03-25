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
            body = temp
            ,nav = application.cache.wrap.navBase()
            ,title = "<h2>Temp Home</h2>"
            ,aux1 = "<h4>username</h4>"
            ,aux2 = application.cache.wrap.panelSearch()
          )
        )>
    <cfreturn content>
  </cffunction>

</cfcomponent>
