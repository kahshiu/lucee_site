<cfcomponent displayname="false">
  <cffunction name=init access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <cffunction name=act_groupSave access="public" returntype="any" output="false">
    <cfparam name="form.groupId" default="-1">
    <cfif form.groupId gt -1> 
      <cfquery name="q" datasource=#application.vars.db#>

        <cfif form.groupId gt 0>
          update grouping set 
            group_type = <cfqueryparam value="#form.groupType#" cfsqltype="cf_sql_smallint"> 
            ,group_name = <cfqueryparam value="#form.groupName#" cfsqltype="cf_sql_varchar">  
          where group_id = <cfqueryparam value="#form.groupId#" cfsqltype="cf_sql_bigint">  
          returning group_id

        <cfelse>
          insert into grouping (group_type,group_name) values (
            <cfqueryparam value="#form.groupType#" cfsqltype="cf_sql_smallint"> 
            ,<cfqueryparam value="#form.groupName#" cfsqltype="cf_sql_varchar"> 
          )
          returning group_id
        </cfif>
      </cfquery>
      <cfset form.groupId = q.group_id>
    </cfif>

    <cflocation url="#application.vars.rooturl#/?path=appHandler.grouping&fn=dsp_groupSave&groupId=#form.groupId#" addtoken=yes statuscode="301">
  </cffunction>

  <cffunction name=dsp_groupSave access="public" returntype="any" output="false">
    <cfparam name="url.groupId" default="0">
    <cfparam name="url.tab" default="member">

<!--- definition group --->
    <cfquery name="q1" datasource=#application.vars.db#>
      select
        dg.d_group_id,dg.d_group_name,dg.d_group_description
      from definition_group dg
      where dg.d_group_id in (2,3);
    </cfquery>

<!--- definition items --->
    <cfquery name="q2" datasource=#application.vars.db#>
      select 
        di.d_group_id,di.d_item_i,di.d_item_name,di.d_item_description
      from definition_item di
      where di.d_group_id in (2,3);
    </cfquery>

<!--- group name --->
    <cfquery name="q3" datasource=#application.vars.db#>
      select 
        group_type as groupType
        ,group_name as groupName 
        ,group_id as groupId 
      from grouping g 
      where g.group_id = <cfqueryparam value="#url.groupId#" cfsqltype="cf_sql_integer">
    </cfquery>

<!--- group members --->
<!--- 
<cfquery name="q" datasource=#application.vars.db#>
select 
</cfquery>
 --->


  <!--- patch local form scope --->
    <cfset form.groupId = q3.groupId>
    <cfset form.groupType = q3.groupType>
    <cfset form.groupName = q3.groupName>

    <cfif not isNumeric(url.groupId)> <cfset url.groupId = 0> </cfif>
    <cfif not isNumeric(form.groupType)> <cfset form.groupType = 1> </cfif>

    <cfsavecontent variable="temp">

<cfoutput>
<!--- todo: expire page --->
<form method="post" action="#application.vars.rooturl#/?path=appHandler.grouping&fn=act_groupSave">
  <cfif url.groupId gt 0>
    <table>
      <tr>
        <td><input type="button" value="Search Group"></td>
        <td><input type="button" value="New Group"></td>
        <td><input type="button" value="Save Group"></td>
      </tr>
    </table>
  <cfelse>
    <table>
      <tr>
        <td><input type="button" value="Search Group"></td>
        <td><input type="button" value="Save Group"></td>
      </tr>
    </table>
  </cfif>

  <table>
    <tr>
      <td><label for="groupType"> Group Type: </label></td>
      <td> 
        <select id="groupType" name="groupType" value="#form.groupType#">
        <cfloop index="i" from="1" to="#q1.recordCount#"> 
          <option value=#q1["d_group_id"][i]#> #q1["d_group_name"][i]# </option>
        </cfloop> 
        </select> 
      </td>
    </tr>
    <tr>
      <td><label for="groupName"> Group Name: </label></td>
      <td> 
        <input type="text" name="groupName" id="groupName" value="#form.groupName#"> 
        <input type="hidden" name="groupId" id="groupId" value="#form.groupId#"> 
      </td>
    </tr>
  </table>
</form>
<br>
<br>

<cfif form.groupId gt 0>
  <table>
    <tr>
      <td><input type="button" value="Link Company"></td>
      <td><input type="button" value="Link Person"></td>
      <td><input type="button" value="Link File"></td>
    </tr>
  </table>
</cfif>

<!--- 
<cfif url.groupId gt 0>
  <div class="row tabline" id="tab">
    <div class="col tab" target="person">Entity</div>
    <div class="col tab" target="file"></div>
    <div class="col tab" target="file">File</div>
  </div>
  <br>

<table id="person">
  <tr>
    <td>Search</td>
    <td>member</td>
  </tr>
  <tr>
    <td><input type="button" value="Search Members"></td>
    <td>&nbsp;</td>
  </tr>
</table>

<table id="file">
  <tr>
    <td>asdf</td>
    <td>file</td>
  </tr>
  <tr>
    <td><label for="groupName"> Group Name: </label></td>
    <td> 
      <input type="text" name="groupName" id="groupName" value="#form.groupName#"> 
      <input type="hidden" name="groupId" id="groupId" value="#url.groupId#"> 
    </td>
  </tr>
</table>

  <script>
    document.getElementById("tab").onclick = function(e) {
      var id = e.target.getAttribute("target");
      switchTab(id);
    }
    function switchTab (tabId) {
      var tabs = ["member","file"];
      for(var i=0;i<tabs.length;i++) {
        var e = document.getElementById(tabs[i]);
        var display = "none";
        if(tabs[i]===tabId) {
          display = "block";
        }
        e.style.display = display;
      }
    }
    switchTab("#url.tab#")
  </script>

</cfif>
 --->
 
</cfoutput>
    </cfsavecontent>

    <cfset content = {}>
    <cfset content.type = "text/html">
    <cfset content.payload = 
        application.cache.wrap.html(
          application.cache.wrap.layout1(
            body = temp
            ,nav = application.cache.wrap.navBase()
            ,title = "<h2>Temp Home</h2>"
            ,aux1 = "<h4>username</h4>"
            ,aux2 = application.cache.wrap.panelSearch()
          )
        )>
    <cfreturn content>
  </cffunction>

</cfcomponent>
