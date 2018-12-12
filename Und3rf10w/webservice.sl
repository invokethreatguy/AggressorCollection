# Sleep Webservice Utilities
#
# To use this: 
#    include('webservice.sl');
#
#    debug(7 | 34) highly recommended
#
# Functions:
#             
# $ post("url", %hash)        
#    connects to "url", posts the data in the hash, returns a handle for reading
#
# % buildDataStructure("<xml>...</xml>");
#    creates a sleep hash tree from the XML document.  each node in the hash is:
#    name => string       : tagname
#    text => string       : raw content of the tag (may be a bunch of spaces)
#    attributes => hash   : attributes for the tag
#    children => array    : an array of nodes (with this same structure)
#
# childrenToHash(%element)
#    constructs a hash out of an element's children... uses the tagnames for the
#    keys and each element for the values.
#
# walkData(%data, %functions)
#    walks through %data, calls the function held by %functions["tagName"] when
#    a tag is encountered.  Argument $1 to the function is the current node.
#    uses a postorder traversal; children left to right, parent
#
# printNice(%data);
#    pretty prints a sleep hash tree
#
# Dependencies:
#
#    This code assumes the following jars are in your Java classpath:
#
#    commons-codec-1.2.jar        - http://archive.apache.org/dist/commons/codec/
#    commons-httpclient-3.1.jar   - http://hc.apache.org/downloads.cgi
#    commons-logging-api.jar      - http://archive.apache.org/dist/commons/logging/binaries/
#    commons-logging.jar          - http://archive.apache.org/dist/commons/logging/binaries/
#    jdom.jar                     - http://www.jdom.org
#
# Contact:
#
#    Raphael Mudge (rsmudge@gmail.com)
#
# Release 15 Jul 08
#

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;

import sleep.bridges.io.IOObject;

import org.jdom.*;
import org.jdom.input.*;

sub post
{
   local('$client $method $key $value $code');
   $client = [new HttpClient];    
   $method = [new PostMethod: $1];

   foreach $key => $value ($2)
   {
      [$method addParameter: $key, $value];
   }

   $code = [$client executeMethod: $method];

   if ($code != [HttpStatus SC_OK])
   {
      throw "Method failed: " . [$method getStatusLine];
   }

   return [SleepUtils getIOHandle: [$method getResponseBodyAsStream], $null];
}

sub buildDataStructure
{
   local('$builder $doc $buffer');

   $buffer  = allocate(strlen($1));
   writeb($buffer, $1);
   closef($buffer);

   $builder = [new SAXBuilder];
   $doc     = [$builder build: [$buffer getInputStream]];

   closef($buffer);

   return [{
      local('$child %result');

      %result["name"] = [$1 getName];
      %result["text"] = [$1 getText];
      %result["attributes"] = [{
         local('$attr %result');

         foreach $attr ([SleepUtils getArrayWrapper: $1])
         {
            %result[[$attr getName]] = [$attr getValue];
         }

         return %result;
      }: [$1 getAttributes]];     

      %result["children"] = @();

      foreach $child ([SleepUtils getArrayWrapper: [$1 getChildren]])
      {
         push(%result["children"], [$this: $child]);
      }

      return %result;
   }: [$doc getRootElement]];
}

sub walkData
{
   local('$child');

   foreach $child ($1["children"])
   {
      walkData($child, $2);
   }

   invoke($2, @($1), $1["name"]);
}

sub childrenToHash
{
   local('$child %results');

   foreach $child ($1["children"])
   {
      %results[$child["name"]] = $child["text"];
   }

   return %results;
}

sub printNice   
{
   local('$k $v $2');

   if (-isarray $1)
   {
      foreach $k => $v ($1)
      {
         println("$2 $+ $k $+ :");
         printNice($v, "$2   ");
      }
   }
   else if (-ishash $1)
   {
      foreach $k => $v ($1)
      {
         println("$2 $+ $k $+ :"); 
         printNice($v, "$2   ");
      }
   }
   else
   {
      println("$2 $+ $1"); 
   }
}
