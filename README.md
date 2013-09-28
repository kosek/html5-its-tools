HTML5 ITS Tools
===============

This repository host several tools which enable processing of HTML5
documents containing [ITS 2.0](http://www.w3.org/TR/its20/) markup.


Converting HTML5 into XHTML+ITS
-------------------------------

Any HTML5 page with local ITS markup entered as its-* attributes can
be converted into XHTML + ITS markup (attributes in ITS namespace) by
the following command:

    java -cp lib/htmlparser-1.4.jar nu.validator.htmlparser.tools.XSLT4HTML5 --template=xsl/html2xhtml.xsl --input-html=example.html --output-xml=example.xhtml


Converting XHTML+ITS into HTML5
-------------------------------

Any XHTML page with local ITS markup entered as its:* attributes can
be converted into HTML5 + ITS markup (its-* prefixed attributes) by
the following command:

    java -jar lib/saxon9he.jar -versionmsg:off -s:example.xhtml -o:example.html -xsl:xsl/xhtml2html.xsl


Validating HTML5+ITS
--------------------

Any HTML5 page with local ITS markup entered as its-* attributes can
be validated by the following command:

    java -Xss512k -cp schema;lib/jing.jar;lib/html5-datatypes.jar;lib/iri.jar;lib/js.jar;lib/htmlparser.jar;lib/icu4j-4_4_2.jar com.thaiopensource.relaxng.util.Driver -c schema\html5-its-lang.rnc example.html

