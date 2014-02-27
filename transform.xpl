<?xml version="1.0" encoding="UTF-8"?>

<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" version="1.0" name="ProfileConvert"> 

   <p:input port="source" primary="true">
      <p:document href="myProfile.xml"></p:document>
   </p:input>    

    <p:output port="result">
        <p:pipe step="xep" port="result"/>       
    </p:output>

    <p:xslt name="pdf">
        <p:input port="source">
       </p:input>
        <p:input port="stylesheet">
            <p:document href="Profile2PDF.xsl"/>
        </p:input>
        <p:input port="parameters"><p:empty/></p:input>
    </p:xslt>

    <p:xsl-formatter name="xep" href="profile.pdf" content-type="application/pdf">
        <p:input port="source">
          <p:pipe port="result" step="pdf" />
       </p:input>
        <p:input port="parameters"><p:empty/></p:input>
    </p:xsl-formatter>

</p:declare-step>
