package com.thaiopensource.xml.sax;

import nu.validator.htmlparser.sax.HtmlParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.xml.sax.XMLReader;
import org.xml.sax.SAXException;

import com.thaiopensource.xml.sax.XMLReaderCreator;

/**
 * An <code>XMLReaderCreator</code> that uses JAXP 1.1 to create <code>XMLReader</code>s.
 * An instance of this class is <em>not</em> safe for concurrent access by multiple threads.
 *
 * @see javax.xml.parsers.SAXParserFactory
 * @author <a href="mailto:jjc@jclark.com">James Clark</a>
 */
public class Jaxp11XMLReaderCreator implements XMLReaderCreator {
    
  /**
   * Default constructor.
   */
  public Jaxp11XMLReaderCreator() {
  }

  public XMLReader createXMLReader() throws SAXException {
      return new nu.validator.htmlparser.sax.HtmlParser();    
    }
  }

