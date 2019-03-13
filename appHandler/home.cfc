<cfcomponent displayname="" hint="">
  <cffunction access="public" name="init" returntype="any" output=false description="initialise">
    <cfreturn this>
  </cffunction>

  <cffunction access="public" name="home" returntype="struct" output=false description="">
    <cfsavecontent variable="temp">
      <cfoutput>

<div>
  <div class="content">
    <div>
      hello
    </div>
  </div>
</div>

<!--- 
-- company page
-- person page
-- file page
-- create for month deadline
-- grouping group member drop down type
 --->

      </cfoutput>
    </cfsavecontent>

    <cfset content = {}>
    <cfset content.type = "text/html">
    <cfset content.payload = application.cache.twrapper.baseShell(temp)>
    <cfreturn content>
  </cffunction>
  
</cfcomponent>
