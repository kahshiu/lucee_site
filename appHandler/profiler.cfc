<cfcomponent displayname="false">
  <cffunction name=init access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <cffunction name=dsp_companySave access="public" returntype="any" output="false">
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

  <cffunction name=dsp_personSave access="public" returntype="any" output="false">
    <cfsavecontent variable="temp"> 
temp ppp
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
