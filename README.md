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

