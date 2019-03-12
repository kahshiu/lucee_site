<cfcomponent displayname="" hint="">

  <cffunction access="public" name="init" returntype="any" output=false description="initialise">
    <cfreturn this>
  </cffunction>

  <cffunction access="public" name="stringToBin" returntype="any" output=false description="">
    <cfargument name="s" type="string" required="true">
    <cfreturn toBinary(toBase64(arguments.s))>
  </cffunction>

  <cffunction access="public" name="anyToBin" returntype="any" output=false description="converge all input to byte array type">
    <cfargument name="c" type="any" required="true">
    <cfset var _className = arguments.c.getClass().toString()>

    <cfif _className eq "class java.lang.String">
      <cfset var _r = stringToBin(arguments.c)>

    <cfelseif _className eq "class [B">
      <cfset var _r = arguments.c>

    <cfelse>
      <cfthrow type="custom" message="Unrecognised request payload.">
    </cfif>

    <cfreturn _r> 
  </cffunction>

<!--- system functions --->
  <cffunction name="isFileExists" access="public" returntype="boolean" output="false"
    description="check validity of filepath - extension specific">

    <cfargument name="path" type="array" required="true">
    <cfargument name="extension" type="string" required="true">

    <cfset var _path = "{web-root-directory}/{object-localpath}.{object-extension}">
    <cfset _path = replaceNocase(_path,"{object-localpath}",arrayToList(arguments.path,"/"))>
    <cfset _path = replaceNocase(_path,"{object-extension}",arguments.extension)>

    <cfreturn fileExists(expandPath(_path))>
  </cffunction>

  <cffunction name="isFnExists" access="public" returntype="boolean" output="false"
    description="check if function exists within an object template">
    <cfargument name="path" type="array" required="true">
    <cfargument name="fn" type="any" required="true">

    <cfset _path = arrayToList(arguments.path,".")>
    <cfset _fn = arguments.fn>
    <cfset _meta = getComponentMetadata(_path)>
    <cfset _result = arrayFind(_meta.functions,function(f){ return f.name==_fn; })>
    <cfreturn _result gt 0>
  </cffunction>

</cfcomponent>
