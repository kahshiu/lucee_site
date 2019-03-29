<cfcomponent displayname="false">

  <cffunction name="init" access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <cffunction name=panelsearch access="public" returntype="string" output="false">
    <cfsavecontent variable="temp">
      <cfoutput>
        <form action="">
          <input type="text">
// TODO: tidy up
<select id="" name="">
  <option value="">grouping</option>
  <option value="">profile</option>
  <option value="">file</option>
</select>
          <input type="button" value="Search">
        </form>
      </cfoutput>
    </cfsavecontent>
    <cfreturn temp>
  </cffunction>

  <cffunction name=navbase access="public" returntype="string" output="false">
    <cfsavecontent variable="temp">
      <cfoutput>
        <ul>
          <li><a href="#application.vars.rootUrl#/?">Home</a></li>
          <li><a href="#application.vars.rootUrl#/?path=appHandler.grouping&fn=dsp_groupSave">Groupings</a></li>
          <li><a href="#application.vars.rootUrl#/?path=appHandler.domain&fn=dsp_fileSave">Working files</a></li>
          <li><a href="#application.vars.rootUrl#/?path=appHandler.profiler&fn=dsp_companySave">Profiler: Company</a></li>
          <li><a href="#application.vars.rootUrl#/?path=appHandler.profiler&fn=dsp_personSave">Profiler: Person</a></li>
          <li><a href="#application.vars.rootUrl#/?path=appHandler.help&fn=home">Help</a></li>
        </ul>
      </cfoutput>
    </cfsavecontent>
    <cfreturn temp>
  </cffunction>

  <cffunction name=layout1 access="public" returntype="string" output="false">
    <cfargument name="body" type="string" required="false" default="">
    <cfargument name="nav" type="string" required="false" default="">
    <cfargument name="title" type="string" required="false" default="">
    <cfargument name="aux1" type="string" required="false" default="">
    <cfargument name="aux2" type="string" required="false" default="">

    <cfsavecontent variable="temp">
      <cfoutput>
        <div class="container">
          <div class="row">
            <div class="col aux1">
              #arguments.aux1# 
            </div>
            <div class="col title">
              #arguments.title# 
            </div>
            <div class="col aux2">
              #arguments.aux2# 
            </div>
          </div>

          <div class="row">
            <div class="col sidebar"> 
              #arguments.nav# 
            </div>
            <div class="col main"> 
              #arguments.body# 
            </div>
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
          <link rel="stylesheet" type="text/css" href="assets/deadSimpleGrid.css">
          <link rel="stylesheet" type="text/css" href="assets/deadSimpleScreen.css">
          <link rel="stylesheet" type="text/css" href="assets/ownStyle.css"> 

          <script src="assets/underscore-min.js" charset="utf-8"></script>
          <script src="assets/hyperHTML.min.js" charset="utf-8"></script>
          <script src="assets/redux.min.js" charset="utf-8"></script>
          <script src="assets/redux-saga.min.js" charset="utf-8"></script>
          <script src="assets/ownJs.js" charset="utf-8"></script>
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
