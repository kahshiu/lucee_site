<cfparam name="attributes.caught" default=#{}#>
<cfoutput>
<div class="row"> 
  <div class="indicator">Type: </div>
  <div class="col">#attributes.caught.type# </div>
</div>
<br>

<div class="row"> 
  <div class="indicator">Error code: </div>
  <cfif attributes.caught.type eq "custom">
    <div class="col"> Custom</div>
  <cfelse>
    <div class="col">#attributes.caught.errorcode# </div>
  </cfif>
</div>
<br>

<div class="row"> 
  <div class="indicator">Message: </div>
  <cfif len(attributes.caught.message) eq 0>
    <div class="col"> (Empty value)</div>
  <cfelse>
    <div class="col">#attributes.caught.message# </div>
  </cfif>
</div>
<br>
</cfoutput>
