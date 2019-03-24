<cfcomponent displayname="false">

  <cffunction name="init" access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <cffunction name=navbase access="public" returntype="string" output="false">
    <cfsavecontent variable="temp">
      <cfoutput>
        <ul>
          <li><a href="#application.vars.rootUrl#/?">Home</a></li>
          <li><a href="#application.vars.rootUrl#/?path=appHandler.domain&fn=dsp_fileSave">File</a></li>
          <li><a href="#application.vars.rootUrl#/?path=appHandler.profiler&fn=dsp_companySave">Company</a></li>
          <li><a href="#application.vars.rootUrl#/?path=appHandler.profiler&fn=dsp_personSave">Person</a></li>
          <li><a href="#application.vars.rootUrl#/?path=appHandler.help&fn=home">Help</a></li>
        </ul>
      </cfoutput>
    </cfsavecontent>
    <cfreturn temp>
  </cffunction>

  <cffunction name=layout1 access="public" returntype="string" output="false">
    <cfargument name="nav" type="string" required="false" default="">
    <cfargument name="body" type="string" required="false" default="">

    <cfsavecontent variable="temp">
      <cfoutput>
        <div>
          <div class="sidebar"> 
            #arguments.nav# 
          </div>
          <div class="content"> 
            #arguments.body# 
          </div>
        </div>
      </cfoutput>
    </cfsavecontent>

    <cfreturn temp>
  </cffunction>

  <cffunction name="html" access="public" returntype="string" output="false">
    <cfargument name="body" type="string" required="false" default="">  
    <cfargument name="head" type="string" required="false" default="">  

    <cfsavecontent variable="temp">
      <cfoutput>
      <html>
        <head>
          #arguments.head#
          <link rel="stylesheet" type="text/css" href="assets/style.css"> 
        </head>
        <body> 
          #arguments.body# 
        </body>
      </html>
      </cfoutput>
    </cfsavecontent>

    <cfreturn temp>
  </cffunction>

</cfcomponent>
