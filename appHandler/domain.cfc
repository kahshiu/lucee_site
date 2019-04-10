<cfcomponent displayname="false">
  <cffunction name=init access="public" returntype="any" output="false">
    <cfreturn this>
  </cffunction>

  <cffunction name=act_fileSave access="public" returntype="any" output="false">
    <cfparam name="form.fileId" default="-1">

  <!--- query: save data --->
    <cfif form.fileId gt -1> 
      <cfquery name="save_file" datasource=#application.vars.db#>
        <cfif form.fileId gt 0>
          update file set  
            file_type      = <cfqueryparam value="#form.fileType#" cfsqltype="cf_sql_smallint"> 
            ,file_name     = <cfqueryparam value="#form.fileName#" cfsqltype="cf_sql_varchar">  
            ,file_deadline = <cfqueryparam value="#form.fileDeadline#" cfsqltype="cf_sql_timestamp">  
            ,file_status   = <cfqueryparam value="#form.filestatus#" cfsqltype="cf_sql_smallint">  
          where file_id = form.file_id
          returning file_id
        <cfelse>
          insert into file(file_type,file_name,file_deadline,file_status) values (
            <cfqueryparam value="#form.fileType#" cfsqltype="cf_sql_smallint"> 
            ,<cfqueryparam value="#form.fileName#" cfsqltype="cf_sql_varchar">  
            ,<cfqueryparam value="#form.fileDeadline#" cfsqltype="cf_sql_timestamp">  
            ,<cfqueryparam value="#form.filestatus#" cfsqltype="cf_sql_smallint">  
          )
          returning file_id
        </cfif>
      </cfquery>
      <cfset form.fileId = save_file.file_id>
    </cfif>

    <cflocation url="#application.vars.rooturl#/?path=appHandler.domain&fn=dsp_fileSave&fileId=#form.fileId#" addtoken=yes statuscode="301">
  </cffunction>

  <cffunction name=dsp_fileSave access="public" returntype="any" output="false">
    <cfsavecontent variable="temp">
      <cfparam name="url.fileId" default="0">

  <!--- query: definition items --->
      <cfquery name="filetype" datasource=#application.vars.db#>
        select 
          di.d_group_id
          ,di.d_item_i
          ,di.d_item_name
          ,di.d_item_description
        from definition_item di
        where di.d_group_id in (2);
      </cfquery>

  <!--- query: definition items --->
      <cfquery name="fileStatus" datasource=#application.vars.db#>
        select 
          di.d_group_id
          ,di.d_item_i
          ,di.d_item_name
          ,di.d_item_description
        from definition_item di
        where di.d_group_id in (5);
      </cfquery>

  <!--- query: file data --->
      <cfquery name="fileData" datasource=#application.vars.db#>
        select 
          file_id   
          ,file_type      
          ,file_name     
          ,file_deadline 
          ,file_status   
        from file 
        where file_id = <cfqueryparam value="#url.fileId#" cfsqltype="cf_sql_bigint">  
      </cfquery>

  <!--- patch data to form --->
      <cfset form.fileId = fileData.file_id>
      <cfset form.fileType = fileData.file_type>
      <cfset form.fileName = fileData.file_name>
      <cfset form.fileDeadline = fileData.file_deadline>
      <cfset form.fileStatus = fileData.file_status>

      <cfif not 
        (isNumeric(url.fileId) 
          and (
            (url.fileId eq 0 and fileData.recordcount eq 0) 
            or (url.fileId gt 0 and fileData.recordcount gt 0)
          )
        )>
        <cfthrow type="custom" errorcode="invalidData" message="File id not found" extendedinfo="file id: #url.fileid#">
      </cfif>

      <cfif not isNumeric(form.fileId)><cfset form.fileId = 0></cfif>
      <cfif not isNumeric(form.fileType)><cfset form.fileType = 1></cfif>
      <cfif not isNumeric(form.fileStatus)><cfset form.fileStatus = 1></cfif>

  <!--- display: file immediate actions --->
      <cfoutput>
        <form method="post" action="#application.vars.rooturl#/?path=appHandler.domain&fn=act_fileSave">
          <cfif url.fileId gt 0>
            <table>
              <tr>
                <td><input type="button" value="Search file"></td>
                <td><input type="button" value="New file"></td>
                <td><input type="submit" value="Save file"></td>
              </tr>
            </table>
          <cfelse>
            <table>
              <tr>
                <td><input type="button" value="Search file"></td>
                <td><input type="submit" value="Save file"></td>
              </tr>
            </table>
          </cfif>

    <!--- display: form --->
          <table>
            <tr>
              <td><label id="fileName">File name</label></td>
              <td>
                <input type="text" id="fileName" name="fileName" value="#form.fileName#">
                <input type="hidden" id="fileId" name="fileId" value="#form.fileId#">
              </td>
            </tr>
            <tr>
              <td><label id="fileType">File type</label></td>
              <td>
                <select id="fileType" name="fileType">
                <cfloop index="i" from="1" to="#filetype.recordCount#"> 
                  <option value="#filetype["d_item_i"][i]#">#filetype["d_item_name"][i]# (#filetype["d_item_description"][i]#)</option>
                </cfloop> 
                </select>
              </td>
            </tr>
            <tr>
              <td><label id="fileDeadline">File common deadline</label></td>
              <td><input type="text" id="fileDeadline" name="fileDeadline" value="#form.fileDeadline#"></td>
            </tr>
            <tr>
              <td><label>File status</label></td>
              <td>
                <cfloop index="i" from="1" to="#fileStatus.recordCount#"> 
                  <label for="filestatus#fileStatus["d_item_name"][i]#"> 
                    <input type="radio" name="fileStatus" id="fileStatus#fileStatus["d_item_name"][i]#" value="#fileStatus["d_item_i"][i]#"> 
                    #fileStatus["d_item_name"][i]# 
                  </label>
                </cfloop> 
<script>
  function setElementsByName(name,fn){
    var eBase = document.getElementsByName(name);
    var eIteratee = eBase;

    // patch for dropdown box
    if(eBase[0].tagName==="SELECT"){
      eIteratee = eIteratee[0].options;
    }

    for(var i=0;i<eIteratee.length;i++) {
      var e = eIteratee[i]; 
      fn(e,i,eIteratee,eBase);
    }
  }

  setElementsByName("fileType",function(e,i,eIteratee,p){if(e.value=="#form.fileType#") p[0].selectedIndex=i});
  setElementsByName("fileStatus",function(e){e.checked=(e.value=="#form.fileStatus#")});
</script>
              </td>
            </tr>
        </table>
      </form>

      <cfif url.fileId gt 0>
        <table>
          <tr>
            <td><input type="button" value="Link Company"></td>
            <td><input type="button" value="Link Person"></td>
            <td><input type="button" value="Link File"></td>
          </tr>
        </table>
      </cfif>
    <!--- file indirect questions
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
