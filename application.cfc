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
    <cfset this.setVars()>

<!--- 
    <cfset request.header = {}>
    <cfloop collection=#request.header# item="h">
      <cfheader name=#h.name# value=#h.value#>
    </cfloop>
--->

    <cfset var _content = route()>
    <cfcontent type=#_content.type# variable=#application.cache.utils.anyToBin(_content.payload)# reset=true>
  </cffunction>


  <!--- custom: app vars --->
  <cffunction access="public" name="setVars" returntype="string" output=false description="">
    <!--- altered based on environment --->
    <cfset application.vars = setFwVar()>
    <cfset application.vars.db = "bingo">
    <cfset application.vars.rooturl = "http://localhost:8888/mysite">

    <cfset setFwMapping()>
    <cfset application.cache = cacheFwObject()>
    <cfset application.cache.twrapper = createObject("component","object.tWrapper").init()>
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

  <cffunction name=onError            access="public" returntype="" output="false"> 
  </cffunction>
 --->

</cfcomponent>
