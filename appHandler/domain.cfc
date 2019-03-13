<cfcomponent displayname="false">
  <cffunction name=init access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <cffunction name=dsp_fileSave access="public" returntype="any" output="false">
    <cfsavecontent variable="temp">
      <cfoutput>
        <div>
          <cfmodule template="/template/navigation.cfm">
          <div class="content">
            testing file page
          </div>
        </div>
      </cfoutput>
    </cfsavecontent>

    <cfset content = {}>
    <cfset content.type = "text/html">
    <cfset content.payload = application.cache.twrapper.baseShell(temp)>
    <cfreturn content>
  </cffunction>

</cfcomponent>
