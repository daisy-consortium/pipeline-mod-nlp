<?xml version="1.0" encoding="UTF-8"?>
<p:library version="1.0"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
    xmlns:cx="http://xmlcalabash.com/ns/extensions"
    xmlns:dtb="http://www.daisy.org/z3986/2005/dtbook/">

  <p:declare-step type="px:dtbook-break-detect">

    <p:import href="http://www.daisy.org/pipeline/modules/break-detection/break-and-reshape.xpl" />

    <p:documentation>Break an input DTBook document into words and sentences by inserting word and sentence elements.</p:documentation>

    <p:input port="source" primary="true"/>
    <p:output port="result" primary="true"/>
    <p:output port="sentence-ids">
      <p:pipe port="sentence-ids" step="generic"/>
    </p:output>

    <p:option name="split-skippable" select="'true'" required="false" />

    <px:break-and-reshape name="generic">
      <p:with-option name="inline-tags" select="'acronym,em,strong,a,abbr,dfn,linenum,pagenum,samp,span,sup,sub,w,noteref,br'"/>
      <p:with-option name="ensure-word-before" select="'acronym,span,linenum,pagenum,samp,noteref,abbr,acronym,br'"/>
      <p:with-option name="ensure-word-after" select="'acronym,span,linenum,pagenum,samp,noteref,abbr,acronym,br'"/>
      <p:with-option name="can-contain-sentences" select="'address,author,notice,prodnote,sidebar,line,em,strong,dfn,kdb,code,samp,cite,abbr,acronym,sub,sup,span,bdo,q,p,doctitle,docauthor,levelhd,hd,h1,h2,h3,h4,h5,h6,dt,dd,li,lic,caption,th,td,bridgehead,byline,covertitle,epigraph,dateline,a'"/>
      <p:with-option name="special-sentences" select="'pagenum,prodnote,annoref,noteref,linenum'"/>
      <p:with-option name="output-ns" select="'http://www.daisy.org/z3986/2005/dtbook/'"/>
      <p:with-option name="output-word-tag" select="'w'"/>
      <p:with-option name="output-sentence-tag" select="'sent'"/>
      <p:with-option name="split-skippable" select="$split-skippable"/>
      <p:with-option name="skippable-tags" select="'pagenum,noteref,prodnote'"/>
      <p:with-option name="output-subsentence-tag" select="'span'"/>
    </px:break-and-reshape>

    <!-- Add IDs to nodes holding an attribute whose value should be
         synthesized (e.g. the @alt attribute of the images). Those
         nodes are not added to the context-free sentence-ids list
         because we would not be able to map IDs to content without
         knowing the context (types of node and types of
         document). -->
    <p:xslt>
      <p:input port="stylesheet">
    	<p:document href="add-ids.xsl"/>
      </p:input>
      <p:input port="parameters">
    	<p:empty/>
      </p:input>
    </p:xslt>

  </p:declare-step>

  <p:declare-step type="px:dtbook-unwrap-words">

    <p:documentation>Remove the word markups from the input document.</p:documentation>

    <p:input port="source" primary="true"/>
    <p:output port="result" primary="true"/>
    <p:unwrap match="dtb:w" />
  </p:declare-step>

</p:library>
