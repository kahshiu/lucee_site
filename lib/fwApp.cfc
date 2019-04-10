<cfcomponent displayname="application extension" extends="fwRouter">

  <cffunction access="public" name="setFwRequest" returntype="struct" output="false">
    <cfreturn {
      error = {}
    }>
  </cffunction>

  <cffunction access="public" name="setFwVar" returntype="struct" output="false">
    <cfreturn {
       db = ""
      ,rootUrl = ""
      ,projectName = ""
    }>
  </cffunction>

  <cffunction access="public" name="setFwMapping" returntype="string" output=false 
    description="set framework mapping">
    <cfset this.mappings["/template"] = expandPath("{web-root-directory}/appTemplate")>
    <cfset this.mappings["/handler"] = expandPath("{web-root-directory}/appHandler")>
    <cfset this.mappings["/object"] = expandPath("{web-root-directory}/appObject")>
    <cfset this.mappings["/query"] = expandPath("{web-root-directory}/appQuery")>
  </cffunction>

  <cffunction access="public" name="cacheFwObject" returntype="struct" output="false">
    <cfset var _cache = {}>
    <cfset _cache.utils = createObject("component","utils").init()>
    <cfreturn _cache>
  </cffunction>

<!--- 
  <cffunction name="onApplicationStart" access="public" returntype="" output="false"> 
    <cfargument name="" type="" required="">
  </cffunction>

  <cffunction name="onApplicationEnd"   access="public" returntype="" output="false"> 
    <cfargument name="" type="" required="">
  </cffunction>

  <cffunction name="onSessionStart"     access="public" returntype="" output="false"> 
    <cfargument name="" type="" required="">
  </cffunction>

  <cffunction name="onSessionEnd"       access="public" returntype="" output="false"> 
    <cfargument name="" type="" required="">
  </cffunction>

  <cffunction name="onRequest"     access="public" returntype="" output="false"> 
    <cfargument name="" type="" required="">
  </cffunction>

  <cffunction name="onRequestStart"     access="public" returntype="" output="false"> 
    <cfargument name="" type="" required="">
  </cffunction>

  <cffunction name="onRequestEnd"       access="public" returntype="" output="false"> 
    <cfargument name="" type="" required="">
  </cffunction>

  <cffunction name="onError"            access="public" returntype="" output="false"> 
    <cfargument name="" type="" required="">
  </cffunction>
 --->

</cfcomponent>
