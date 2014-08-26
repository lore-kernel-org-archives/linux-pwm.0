Return-Path: <RYang@hach.com>
From: "Yang, Robert" <RYang@hach.com>
Subject: [PATCH] Patch for pwm backlight driver
Date: Tue, 26 Aug 2014 21:14:07 +0000
Message-ID: <D68D4F79CA301E4CB7967E4AF0038407253006A8@DHRNASVXM01.danaher.org>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_D68D4F79CA301E4CB7967E4AF0038407253006A8DHRNASVXM01dana_"
MIME-Version: 1.0
Return-Path: RYang@hach.com
List-ID: <linux-pwm.vger.kernel.org>
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>

--_004_D68D4F79CA301E4CB7967E4AF0038407253006A8DHRNASVXM01dana_
Content-Type: multipart/alternative;
	boundary="_000_D68D4F79CA301E4CB7967E4AF0038407253006A8DHRNASVXM01dana_"

--_000_D68D4F79CA301E4CB7967E4AF0038407253006A8DHRNASVXM01dana_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Thierry,



Attached is a patch which will fix a bug in the video/pwm backlight driver =
if multiple pwm chips exist. The defect could cause the backlight driver us=
e the wrong pwm chip and fail finally and also lock up the unattended pwm. =
The patch will allow a deferral pwm backlight probing if the attended pwm d=
river is not loaded yet.



This patch is currently against a linux 3.16 kernel.

The technology in this patch is architecture-independent.

Please let me know any feedback you have on this patch or the approach used=
.

Thanks,


Signed-off-by: Robert Yang <ryang@hach.com>

Robert Yang | Sr. Software Engineer
P 970.6631377 ext 2626
Hach Company | www.hach.com<http://www.hach.com/> |ryang@hach.com<mailto:|e=
mail@hach.com>

Water analysis has to be right. You deserve complete solutions you can be f=
ully confident in. Hach is your resource for expert answers, outstanding su=
pport, and reliable, easy-to-use products.

--- linux-linux-3.16/pwm_bl.c.orig              2014-08-26 14:26:02.2105809=
89 -0600
+++ ./linux-linux-3.16/drivers/video/backlight/pwm_bl.c   2014-08-26 14:26:=
45.318582726 -0600
@@ -281,15 +281,9 @@ static int pwm_backlight_probe(struct pl
               pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
              if (IS_ERR(pb->pwm)) {
-                             dev_err(&pdev->dev, "unable to request PWM, t=
rying legacy API\n");
+                            dev_err(&pdev->dev, "unable to request PWM, tr=
ying a deferral binding later\n");
                             ret =3D PTR_ERR(pb->pwm);
-
-                             pb->pwm =3D pwm_request(data->pwm_id, "pwm-ba=
cklight");
-                             if (IS_ERR(pb->pwm)) {
-                                            dev_err(&pdev->dev, "unable to=
 request legacy PWM\n");
-                                            ret =3D PTR_ERR(pb->pwm);
-                                            goto err_alloc;
-                             }
+                            goto err_alloc;
              }
               dev_dbg(&pdev->dev, "got pwm for backlight\n");

Please be advised that this email may contain confidential information. If =
you are not the intended recipient, please notify us by email by replying t=
o the sender and delete this message. The sender disclaims that the content=
 of this email constitutes an offer to enter into, or the acceptance of, an=
y agreement; provided that the foregoing does not invalidate the binding ef=
fect of any digital or other electronic reproduction of a manual signature =
that is included in any attachment.

--_000_D68D4F79CA301E4CB7967E4AF0038407253006A8DHRNASVXM01dana_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<pre>Hi Thierry,<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Attached is a patch which will fix a bug in the video/pwm backlight dr=
iver if multiple pwm chips exist. The defect could cause the backlight driv=
er use the wrong pwm chip and fail finally and also lock up the unattended =
pwm. The patch will allow a deferral pwm backlight probing if the attended =
pwm driver is not loaded yet. &nbsp;<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>This patch is currently against a linux 3.16 kernel.<o:p></o:p></pre>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">The technology in this patch is architecture-independent.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Please let me know any feedback you have on this patch or =
the approach used.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;"><o:p>&nbsp;</o:p></span></p>
<pre>Signed-off-by: Robert Yang &lt;ryang@hach.com&gt;<o:p></o:p></pre>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b><span style=3D"color:#0098DB;text-transform:upper=
case">Robert Yang</span></b><span style=3D"font-size:10.0pt;color:#0098DB">=
&nbsp;</span><span style=3D"font-size:9.0pt;color:#4D4D4D">| Sr. Software E=
ngineer<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;color:#0098DB">P<=
/span></b><span style=3D"font-size:10.0pt;color:#16ABE0">&nbsp;</span><span=
 style=3D"font-size:10.0pt;color:#4D4D4D">970.6631377 ext&nbsp;2626</span><=
span style=3D"color:#333333"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;color:#4D4D4D">Hach =
Company </span>
<span style=3D"font-size:9.0pt;color:#4D4D4D">| </span><a href=3D"http://ww=
w.hach.com/"><span style=3D"font-size:10.0pt;color:#4D4D4D">www.hach.com</s=
pan></a><span style=3D"font-size:10.0pt;color:#4D4D4D">
</span><a href=3D"mailto:|email@hach.com"><span style=3D"font-size:9.0pt;co=
lor:blue">|</span><span style=3D"font-size:10.0pt;color:blue">ryang@hach.co=
m</span></a><span style=3D"font-size:9.0pt;color:#4D4D4D"><o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><b><span style=3D"color:#0098DB;text-transform:upper=
case"><o:p>&nbsp;</o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"color:#0098DB;text-transform:upper=
case">Water analysis has to be right. You deserve complete solutions you ca=
n be fully confident in. Hach is your resource for expert answers, outstand=
ing support, and reliable, easy-to-use
 products.<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"color:#0098DB;text-transform:upper=
case"><o:p>&nbsp;</o:p></span></b></p>
<p class=3D"MsoNormal">--- linux-linux-3.16/pwm_bl.c.orig&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2014-08-26 14:=
26:02.210580989 -0600<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; ./linux-linux-3.16/drivers/video/bac=
klight/pwm_bl.c&nbsp;&nbsp; 2014-08-26 14:26:45.318582726 -0600<o:p></o:p><=
/p>
<p class=3D"MsoNormal">@@ -281,15 &#43;281,9 @@ static int pwm_backlight_pr=
obe(struct pl<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pb-&gt;pwm =3D devm_pwm_get(&amp;pdev-&gt;=
dev, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(pb-&gt;pwm)) {<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;pdev-&gt;dev, &quot=
;unable to request PWM, trying legacy API\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;pdev-&gt;dev, &quot;u=
nable to request PWM, trying a deferral binding later\n&quot;);<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D PTR_ERR(pb-&gt;pwm);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pb-&gt;pwm =3D pwm_request(data-=
&gt;pwm_id, &quot;pwm-backlight&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(pb-&gt;pwm)) {<o:p></=
o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;pdev=
-&gt;dev, &quot;unable to request legacy PWM\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D PTR_ERR(p=
b-&gt;pwm);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_alloc;<o=
:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_alloc;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(&amp;pdev-&gt;dev, &quot;got pwm f=
or backlight\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
Please be advised that this email may contain confidential information. If =
you are not the intended recipient, please notify us by email by replying t=
o the sender and delete this message. The sender disclaims that the content=
 of this email constitutes an offer
 to enter into, or the acceptance of, any agreement; provided that the fore=
going does not invalidate the binding effect of any digital or other electr=
onic reproduction of a manual signature that is included in any attachment.
</body>
</html>

--_000_D68D4F79CA301E4CB7967E4AF0038407253006A8DHRNASVXM01dana_--

--_004_D68D4F79CA301E4CB7967E4AF0038407253006A8DHRNASVXM01dana_
Content-Type: application/octet-stream; name="patch"
Content-Description: patch
Content-Disposition: attachment; filename="patch"; size=749;
	creation-date="Tue, 26 Aug 2014 20:52:24 GMT";
	modification-date="Tue, 26 Aug 2014 20:38:15 GMT"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LWxpbnV4LTMuMTYvcHdtX2JsLmMub3JpZwkyMDE0LTA4LTI2IDE0OjI2OjAyLjIx
MDU4MDk4OSAtMDYwMAorKysgLi9saW51eC1saW51eC0zLjE2L2RyaXZlcnMvdmlkZW8vYmFja2xp
Z2h0L3B3bV9ibC5jCTIwMTQtMDgtMjYgMTQ6MjY6NDUuMzE4NTgyNzI2IC0wNjAwCkBAIC0yODEs
MTUgKzI4MSw5IEBAIHN0YXRpYyBpbnQgcHdtX2JhY2tsaWdodF9wcm9iZShzdHJ1Y3QgcGwKIAog
CXBiLT5wd20gPSBkZXZtX3B3bV9nZXQoJnBkZXYtPmRldiwgTlVMTCk7CiAJaWYgKElTX0VSUihw
Yi0+cHdtKSkgewotCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJ1bmFibGUgdG8gcmVxdWVzdCBQV00s
IHRyeWluZyBsZWdhY3kgQVBJXG4iKTsKKwkJZGV2X2VycigmcGRldi0+ZGV2LCAidW5hYmxlIHRv
IHJlcXVlc3QgUFdNLCB0cnlpbmcgYSBkZWZlcnJhbCBiaW5kaW5nIGxhdGVyXG4iKTsKIAkJcmV0
ID0gUFRSX0VSUihwYi0+cHdtKTsKLQotCQlwYi0+cHdtID0gcHdtX3JlcXVlc3QoZGF0YS0+cHdt
X2lkLCAicHdtLWJhY2tsaWdodCIpOwotCQlpZiAoSVNfRVJSKHBiLT5wd20pKSB7Ci0JCQlkZXZf
ZXJyKCZwZGV2LT5kZXYsICJ1bmFibGUgdG8gcmVxdWVzdCBsZWdhY3kgUFdNXG4iKTsKLQkJCXJl
dCA9IFBUUl9FUlIocGItPnB3bSk7Ci0JCQlnb3RvIGVycl9hbGxvYzsKLQkJfQorCQlnb3RvIGVy
cl9hbGxvYzsKIAl9CiAKIAlkZXZfZGJnKCZwZGV2LT5kZXYsICJnb3QgcHdtIGZvciBiYWNrbGln
aHRcbiIpOwo=

--_004_D68D4F79CA301E4CB7967E4AF0038407253006A8DHRNASVXM01dana_--
