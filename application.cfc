<cfcomponent displayname="false" extends="lib.fwApp">
<!--- 
  <cfset this.applicationTimeout = >
  <cfset this.sessionManagement = >
  <cfset this.sessionTimout = >
  <cfset this.setClientCookies = >
  <cfset this.setDomainCookies = >
  <cfset this.clientManagement = >
  <cfset this.clientStorage    = >

  <cfset this.loginStorage     = >
  <cfset this.scriptProtect    = >
--->

  <cffunction name="onRequest" access="public" returntype="string" output="true"> 
    <cfargument name="script" type="string" required="true">
    <cfset this.setVarsApp()>
    <cfset this.setVarsRequest()>

<!--- todo: header
    <cfset request.header = {}>
    <cfloop collection=#request.header# item="h">
      <cfheader name=#h.name# value=#h.value#>
    </cfloop>
--->

    <cfset var _content = route()>
    <cfcontent type=#_content.type# variable=#application.cache.utils.anyToBin(_content.payload)# reset=true>
  </cffunction>


  <!--- custom: setting vars --->
  <cffunction access="public" name="setVarsApp" returntype="string" output=false description="">
    <cfset setFwMapping()>

    <cfif structKeyExists(application,"vars")> <cfset structDelete(application,"vars")> </cfif>
    <cfif structKeyExists(application,"cache")> <cfset structDelete(application,"cache")> </cfif>

    <!--- altered based on environment --->
    <cfset application.vars = setFwVar()>
    <cfset application.vars.db = "bingo">
    <cfset application.vars.rooturl = "http://localhost:8888/mysite">
    <cfset application.vars.appname = "Conduit">

    <cfset application.cache = {}>
    <cfset application.cache = cacheFwObject()>
    <cfset application.cache.wrap = createObject("component","template.wrap").init()>

  </cffunction>

  <cffunction access="public" name="setVarsRequest" returntype="string" output=false description="">
    <cfset request.fw = setFwRequest()>
  </cffunction>

<!--- 
  <cffunction name=onApplicationStart access="public" returntype="" output="false"> 
  </cffunction>

  <cffunction name=onApplicationEnd   access="public" returntype="" output="false"> 
  </cffunction>

  <cffunction name=onSessionStart     access="public" returntype="" output="false"> 
  </cffunction>

  <cffunction name=onSessionEnd       access="public" returntype="" output="false"> 
  </cffunction>

  <cffunction name=onRequestStart     access="public" returntype="" output="false"> 
  </cffunction>

  <cffunction name=onRequestEnd       access="public" returntype="" output="false"> 
  </cffunction>

 --->
  <cffunction name=onError access="public" returntype="any" output="false"> 
    <cfargument name="caught" type="struct" required="true">
    <cfargument name="event" type="string" required="true">

    <cfset request.fw.error = arguments.caught.cause>

    <cfset var fn = "generic">
    <cfif arguments.caught.type eq "custom">
      <cfset fn = arguments.caught.errorCode>
    </cfif>

    <cfset var _content = this.runObj("lib.fwError",fn)>
    <cfcontent type=#_content.type# variable=#application.cache.utils.anyToBin(_content.payload)# reset=true>
  </cffunction>

</cfcomponent>
