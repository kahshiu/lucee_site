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

  <cffunction name=navShell access="public" returntype="string" output="false">
    <cfargument name="body" type="string" required="false" default="">
    <cfargument name="nav" type="string" required="false" default="">

    <cfsavecontent variable="temp">
      <cfoutput>
        <div>
          <cfif arguments.nav eq "">
            <cfmodule template="/template/navigation.cfm">
          <cfelse>
            #arguments.nav#
          </cfif>
          <div class="content"> #arguments.body# </div>
        </div>
      </cfoutput>
    </cfsavecontent>

    <cfreturn temp>
  </cffunction>

</cfcomponent>
