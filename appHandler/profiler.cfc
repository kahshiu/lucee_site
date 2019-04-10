<cfcomponent displayname="false">
  <cffunction name=init access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <cffunction name=act_entitySave access="public" returntype="any" output="false">
  </cffunction>

  <cffunction name=dsp_entitySave access="public" returntype="any" output="false">
    <cfparam name="url.entityId" default="0">

    <cfsavecontent variable="temp"> 

  <!--- definition item --->
      <cfquery name="q" datasource=#application.vars.db#>
        select 
          di.d_group_id,di.d_item_i,di.d_item_name,di.d_item_description
        from definition_item di
        where di.d_group_id in (1);
      </cfquery>

  <!--- definition states --->
      <cfquery name="state" datasource=#application.vars.db#>
        select 
          di.d_group_id,di.d_item_i,di.d_item_name,di.d_item_description
        from definition_item di
        where di.d_group_id in (4);
      </cfquery>

  <!--- entity --->
      <cfquery name="ent" datasource=#application.vars.db#>
        select e.entity_id
          ,e.entity_name,e.entity_type
          ,e.add1,e.add2,e.state,e.postcode
          ,e.contact1_number,e.contact1_name
          ,e.contact2_number,e.contact2_name
        from entity e 
        where e.entity_id = <cfqueryparam value="#url.entityId#" cfsqltype="cf_sql_integer">
      </cfquery>

      <cfset url.entityId = ent.entity_id>

      <cfif not isNumeric(url.entityId)> <cfset url.entityId = 0> </cfif>

      <cfoutput>
      <form method="post" action="#application.vars.rooturl#/?path=appHandler.profiler&fn=act_entitySave">
        <cfif url.entityId gt 0>
          <table>
            <tr>
              <td><input type="button" value="Search Entity"></td>
              <td><input type="button" value="New Entity"></td>
              <td><input type="submit" value="Save Entity"></td>
            </tr>
          </table>
        <cfelse>
          <table>
            <tr>
              <td><input type="button" value="Search Entity"></td>
              <td><input type="submit" value="Save Entity"></td>
            </tr>
          </table>
        </cfif>
        <table>
          <tr>
            <td><label id="entName">Name</label></td>
            <td><input type="text" id="entName" name="entName" value=""></td>
          </tr>
          <tr>
            <td><label id="entType">Type</label></td>
            <td>
              <select id="entType" name="entType">
              <cfloop index="i" from="1" to="#q.recordCount#"> 
                <option value="#q["d_item_i"][i]#">#q["d_item_name"][i]# (#q["d_item_description"][i]#)</option>
              </cfloop> 
              </select>
            </td>
          </tr>
          <tr>
            <td><label id="add1">Address 1</label></td>
            <td><input type="text" id="add1" name="add1" value=""></td>
          </tr>
          <tr>
            <td><label id="add1">Address 2</label></td>
            <td><input type="text" id="add2" name="add2" value=""></td>
          </tr>
          <tr>
            <td><label id="postcode">Postcode</label></td>
            <td><input type="text" id="postcode" name="postcode" value=""></td>
          </tr>
          <tr>
            <td><label id="state">State</label></td>
            <td>
              <select id="state" name="state">
              <cfloop index="i" from="1" to="#state.recordCount#"> 
                <option value value="#state["d_item_i"][i]#">#state["d_item_name"][i]#</option>
              </cfloop> 
              </select>
            </td>
          </tr>
          <tr>
            <td><label id="contactName1">Contact name</label></td>
            <td><input type="text" id="contactName1" name="contactName1" value=""></td>
          </tr>
          <tr>
            <td><label id="contactNo1">Contact no.</label></td>
            <td><input type="text" id="contactNo1" name="contactNo1" value=""></td>
          </tr>
          <tr>
            <td><label id="contactName2">Contact name2</label></td>
            <td><input type="text" id="contactName2" name="contactName2" value=""></td>
          </tr>
          <tr>
            <td><label id="contactNo2">Contact no2.</label></td>
            <td><input type="text" id="contactNo2" name="contactNo2" value=""></td>
          </tr>
        </table>
      </form>
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

  <cffunction name=dsp_personSave access="public" returntype="any" output="false">
    <cfsavecontent variable="temp"> 
temp ppp
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
