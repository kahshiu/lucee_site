<cfcomponent displayname="false">
  <cffunction name=init access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <cffunction name=deniedPath access="public" returntype="struct" output="false">
    <cfreturn errorBasic()>
  </cffunction>

  <cffunction name=invalidPath access="public" returntype="struct" output="false">
    <cfreturn errorBasic()>
  </cffunction>

  <cffunction name=invalidData access="public" returntype="struct" output="false">
    <cfreturn errorBasic()>
  </cffunction>

  <cffunction name=invalidFn access="public" returntype="struct" output="false">
    <cfreturn errorBasic()>
  </cffunction>

  <cffunction name=generic access="public" returntype="struct" output="false">
    <cfreturn errorExtended()>
  </cffunction>


<!--- error templates --->
  <cffunction name=errorBasic access="public" returntype="struct" output="false">
    <cfreturn this.errorTemplate("/template/error.cfm" )>
  </cffunction>

  <cffunction name=errorExtended access="public" returntype="struct" output="false">
    <cfreturn this.errorTemplate("/template/errorExtended.cfm" )>
  </cffunction>

  <cffunction name=errorTemplate access="public" returntype="struct" output="false">
    <cfargument name="templatePath" type="string" required="true">
    <cfargument name="backPath" type="string" required="false" default='#application.vars.rootUrl#/?path=appHandler.home&fn=home'>

    <cfsavecontent variable="temp">
      <cfoutput>
        <div class="debugging"> 
          <cfmodule template="/template/error.cfm" caught=#request.fw.error#> 
        </div>
      </cfoutput>
    </cfsavecontent>

    <cfset content = {}>
    <cfset content.type = "text/html">
    <cfset content.payload = application.cache.wrap.layout1(temp,'<ul><li> <a href="#arguments.backPath#">Back to Home</a> </li></ul>')>
    <cfreturn content>
  </cffunction>

</cfcomponent>
