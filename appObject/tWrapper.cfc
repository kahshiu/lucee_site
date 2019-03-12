<cfcomponent displayname="false">

  <cffunction name="init" access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <cffunction name="baseShell" access="public" returntype="string" output="false">
    <cfargument name="body" type="string" required="false" default="">  

    <cfsavecontent variable="temp">
      <cfmodule template="/template/baseShell.cfm" body=#arguments.body#>
    </cfsavecontent>

    <cfreturn temp>
  </cffunction>

</cfcomponent>
