<cfparam name="attributes.caught" default=#{}#>
<cfoutput>
  <cfmodule template="error.cfm" caught=#attributes.caught#>

  <!--- http referrer --->
  <div class="row"> 
    <div class="indicator">HTTP referrer: </div>
    <cfif len(cgi.http_referrer) gt 0>
      <div class="col"> #cgi.http_referrer#</div>
    <cfelse>
      <div class="col"> (Empty value)</div>
    </cfif>
  </div>
  <br>

  <!--- form --->
  <div class="row"> 
    <div class="indicator">Form: </div>
      <cfif structIsEmpty(form)>
        <div class="col"> (Empty value)</div>
      <cfelse>
        <cfloop collection="#form#" index="k" item="v">
          <div class="col table-head"> #k# </div>
          <div class="col table-body"> #v# </div>
        </cfloop>
      </cfif>
  </div>
  <br>

  <!--- url --->
  <div class="row"> 
    <div> 
      <span class="indicator">Query string: </span>
      (#cgi.query_string#)
    </div>
      <cfif structIsEmpty(url)>
        <div class="col"> Empty structure</div>
      <cfelse>
        <cfloop collection="#url#" index="k" item="v">
          <div class="col table-head"> #k# </div>
          <div class="col table-body"> #v# </div>
        </cfloop>
      </cfif>
  </div>
  <br>

  <div class="row"> 
    <div class="indicator">Detail: </div>
    <cfif len(attributes.caught.detail) eq 0>
      <div class="col"> (Empty value)</div>
    <cfelse>
      <div class="col">#attributes.caught.detail# </div>
    </cfif>
  </div>
  <br>

  <div class="row"> 
    <div class="indicator">Extended info: </div>
    <cfif len(attributes.caught.extendedinfo) eq 0>
      <div class="col"> (Empty value)</div>
    <cfelse>
      <div class="col">#attributes.caught.extendedinfo# </div>
    </cfif>
  </div>
  <br>

  <!--- additional --->
  <div class="row"> 
    <div class="indicator">Additional: </div>
      <cfif structIsEmpty(attributes.caught.additional)>
        <div class="col"> (Empty value)</div>
      <cfelse>
        <cfloop collection="#attributes.caught.additional#" index="k" item="v">
          <div class="col table-head"> #k# </div>
          <div class="col table-body"> #v# </div>
        </cfloop>
      </cfif>
  </div>
  <br>

  <div class="row"> 
    <div class="indicator"> TagContext: </div>
    <div>
      <cfloop index="item" array="#attributes.caught.tagContext#"> 
          <div class="indicator2">#item.template# -- #item.type# -- (id: #item.id#) -- (line:#item.line#, col:#item.column#)</div>
          <div class="indicator">#item.raw_trace# </div>
          <div>#item.codePrintHTML#</div> <hr>
      </cfloop>
    </div>
  </div>
  <br>

  <div class="row"> 
    <div class="indicator"> StackTrace: </div>
    <div class="content"> #attributes.caught.stacktrace# </div>
  </div>
  <br>
