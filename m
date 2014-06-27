Return-Path: <johannes.pointner@gmail.com>
MIME-Version: 1.0
Date: Fri, 27 Jun 2014 07:32:20 +0200
Message-ID: <CAJKbBDD1SANFaXqKnxEAOdLH=s+Jo1b2bXKeebCfV--PhZUScQ@mail.gmail.com>
Subject: [PATCH] Added possibility to use pwm_bl.c with percentage instead of levels
From: Johannes Pointner <johannes.pointner@gmail.com>
Content-Type: multipart/alternative; boundary=001a113441562448c904fccaa26b
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

--001a113441562448c904fccaa26b
Content-Type: text/plain; charset=UTF-8

Hello,

I'm new working on the linux device drivers, so if I made something wrong
please point me into the right direction.

I'd like to use the pwm_bl driver for a sitara based terminal and for this
I would need the possibility to set the backlight within a percentage
range. The following patch should add this possibility to the pwm_bl
driver. The idea is to keep backward compatibility by moving the required
option brightness levels to optional. Therefore if there is no node with
brightness levels the percentage levels are used.

Signed-off-by: Johannes Pointner <johannes.pointner@gmail.com>
---
 .../bindings/video/backlight/
pwm-backlight.txt     | 11 +++---
 drivers/video/backlight/pwm_bl.c                   | 46
++++++++++++----------
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git
a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
index 764db86..ea09669 100644
--- a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
@@ -3,16 +3,17 @@ pwm-backlight bindings
 Required properties:
   - compatible: "pwm-backlight"
   - pwms: OF device-tree PWM specification (see PWM binding[0])
+  - default-brightness-level: the default brightness level (in case of
defined levels:
+      index into the array defined by the "brightness-levels" property
otherwise the
+      percentage)
+  - power-supply: regulator for supply voltage
+
+Optional properties:
   - brightness-levels: Array of distinct brightness levels. Typically these
       are in the range from 0 to 255, but any range starting at 0 will do.
       The actual brightness level (PWM duty cycle) will be interpolated
       from these values. 0 means a 0% duty cycle (darkest/off), while the
       last value in the array represents a 100% duty cycle (brightest).
-  - default-brightness-level: the default brightness level (index into the
-      array defined by the "brightness-levels" property)
-  - power-supply: regulator for supply voltage
-
-Optional properties:
   - pwm-names: a list of names for the PWM devices specified in the
                "pwms" property (see PWM binding[0])
   - enable-gpios: contains a single GPIO specifier for the GPIO which
enables
diff --git a/drivers/video/backlight/pwm_bl.c
b/drivers/video/backlight/pwm_bl.c
index 38ca88b..f9f1f43 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -24,6 +24,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>

+#define MAX_PERCENT_BRIGHTNESS        100    /* max brightness if no
levels are used */
+
 struct pwm_bl_data {
     struct pwm_device    *pwm;
     struct device        *dev;
@@ -151,33 +153,35 @@ static int pwm_backlight_parse_dt(struct device *dev,

     /* determine the number of brightness levels */
     prop = of_find_property(node, "brightness-levels", &length);
-    if (!prop)
-        return -EINVAL;
+    if (prop) {
+        data->max_brightness = length / sizeof(u32);

-    data->max_brightness = length / sizeof(u32);
+        /* read brightness levels from DT property */
+        if (data->max_brightness > 0) {
+            size_t size = sizeof(*data->levels) * data->max_brightness;

-    /* read brightness levels from DT property */
-    if (data->max_brightness > 0) {
-        size_t size = sizeof(*data->levels) * data->max_brightness;
+            data->levels = devm_kzalloc(dev, size, GFP_KERNEL);
+            if (!data->levels)
+                return -ENOMEM;

-        data->levels = devm_kzalloc(dev, size, GFP_KERNEL);
-        if (!data->levels)
-            return -ENOMEM;
+            ret = of_property_read_u32_array(node, "brightness-levels",
+                            data->levels,
+                            data->max_brightness);
+            if (ret < 0)
+                return ret;

-        ret = of_property_read_u32_array(node, "brightness-levels",
-                         data->levels,
-                         data->max_brightness);
-        if (ret < 0)
-            return ret;
+            data->max_brightness--;
+        }
+    } else {
+        data->max_brightness = MAX_PERCENT_BRIGHTNESS;
+    }

-        ret = of_property_read_u32(node, "default-brightness-level",
-                       &value);
-        if (ret < 0)
-            return ret;
+    ret = of_property_read_u32(node, "default-brightness-level",
+                          &value);
+    if (ret < 0)
+        return ret;

-        data->dft_brightness = value;
-        data->max_brightness--;
-    }
+    data->dft_brightness = value;

     return 0;
 }

-- 
2.0.0

--001a113441562448c904fccaa26b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hello,<br><br></div>I&#39;m new working on the l=
inux device drivers, so if I made something wrong please point me into the =
right direction.<br><br></div>I&#39;d
 like to use the pwm_bl driver for a sitara based terminal and for this I
 would need the possibility to set the backlight within a percentage=20
range. The following patch should add this possibility to the pwm_bl=20
driver. The idea is to keep backward compatibility by moving the=20
required option brightness levels to optional. Therefore if there is no=20
node with brightness levels the percentage levels are used.<br>
<br>Signed-off-by: Johannes Pointner &lt;<a href=3D"mailto:johannes.pointne=
r@gmail.com" target=3D"_blank">johannes.pointner@gmail.com</a>&gt;<br>---<b=
r>=C2=A0.../bindings/video/backlight/<div dir=3D"ltr">pwm-backlight.txt=C2=
=A0=C2=A0=C2=A0=C2=A0 | 11 +++---<br>
=C2=A0drivers/video/backlight/pwm_bl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
46 ++++++++++++----------<br>
=C2=A02 files changed, 31 insertions(+), 26 deletions(-)<br><br>diff --git =
a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt b/Doc=
umentation/devicetree/bindings/video/backlight/pwm-backlight.txt<br>index 7=
64db86..ea09669 100644<br>

--- a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt<b=
r>+++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt=
<br>@@ -3,16 +3,17 @@ pwm-backlight bindings<br>=C2=A0Required properties:<=
br>

=C2=A0=C2=A0 - compatible: &quot;pwm-backlight&quot;<br>=C2=A0=C2=A0 - pwms=
: OF device-tree PWM specification (see PWM binding[0])<br>+=C2=A0 - defaul=
t-brightness-level: the default brightness level (in case of defined levels=
:<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 index into the array defined by the &q=
uot;brightness-levels&quot; property otherwise the<br>

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 percentage)<br>+=C2=A0 - power-supply: regu=
lator for supply voltage<br>+<br>+Optional properties:<br>=C2=A0=C2=A0 - br=
ightness-levels: Array of distinct brightness levels. Typically these<br>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 are in the range from 0 to 255, but an=
y range starting at 0 will do.<br>

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The actual brightness level (PWM duty =
cycle) will be interpolated<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from th=
ese values. 0 means a 0% duty cycle (darkest/off), while the<br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 last value in the array represents a 100% duty =
cycle (brightest).<br>

-=C2=A0 - default-brightness-level: the default brightness level (index int=
o the<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 array defined by the &quot;brightn=
ess-levels&quot; property)<br>-=C2=A0 - power-supply: regulator for supply =
voltage<br>-<br>-Optional properties:<br>

=C2=A0=C2=A0 - pwm-names: a list of names for the PWM devices specified in =
the<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 &quot;pwms&quot; property (see PWM binding[0])<br>=
=C2=A0=C2=A0 - enable-gpios: contains a single GPIO specifier for the GPIO =
which enables<br>
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm=
_bl.c<br>
index 38ca88b..f9f1f43 100644<br>--- a/drivers/video/backlight/pwm_bl.c<br>=
+++ b/drivers/video/backlight/pwm_bl.c<br>@@ -24,6 +24,8 @@<br>=C2=A0#inclu=
de &lt;linux/regulator/consumer.h&gt;<br>=C2=A0#include &lt;linux/slab.h&gt=
;<br>
=C2=A0<br>
+#define MAX_PERCENT_BRIGHTNESS=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 100=C2=
=A0=C2=A0=C2=A0 /* max brightness if no levels are used */<br>+<br>=C2=A0st=
ruct pwm_bl_data {<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct pwm_device=C2=A0=C2=
=A0=C2=A0 *pwm;<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct device=C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 *dev;<br>@@ -151,33 +153,35 @@ static int pwm_backlight=
_parse_dt(struct device *dev,<br>

=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 /* determine the number of brightness le=
vels */<br>=C2=A0=C2=A0=C2=A0=C2=A0 prop =3D of_find_property(node, &quot;b=
rightness-levels&quot;, &amp;length);<br>-=C2=A0=C2=A0=C2=A0 if (!prop)<br>=
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EINVAL;<br>+=C2=A0=C2=A0=C2=
=A0 if (prop) {<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;max_brig=
htness =3D length / sizeof(u32);<br>

=C2=A0<br>-=C2=A0=C2=A0=C2=A0 data-&gt;max_brightness =3D length / sizeof(u=
32);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* read brightness levels fr=
om DT property */<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (data-&gt;ma=
x_brightness &gt; 0) {<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 size_t size =3D sizeof(*data-&gt;levels) * data-&gt;max_brightnes=
s;<br>

=C2=A0<br>-=C2=A0=C2=A0=C2=A0 /* read brightness levels from DT property */=
<br>-=C2=A0=C2=A0=C2=A0 if (data-&gt;max_brightness &gt; 0) {<br>-=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 size_t size =3D sizeof(*data-&gt;levels) * dat=
a-&gt;max_brightness;<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 data-&gt;levels =3D devm_kzalloc(dev, size, GFP_KERNEL);<br>

+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!data-&gt;lev=
els)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 return -ENOMEM;<br>=C2=A0<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 data-&gt;levels =3D devm_kzalloc(dev, size, GFP_KERNEL);<br>-=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!data-&gt;levels)<br>-=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENOMEM;<br>+=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D of_property_read_u32_arra=
y(node, &quot;brightness-levels&quot;,<br>

+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;level=
s,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt=
;max_brightness);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 if (ret &lt; 0)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;<br>=C2=A0<br>-=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 ret =3D of_property_read_u32_array(node, &quot;brightness-l=
evels&quot;,<br>

-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0data-&gt;levels,<br>-=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0data-&gt;max_brightness);<br>-=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret &lt; 0)<br>-=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;<br>+=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;max_brightness--;<br>+=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>+=C2=A0=C2=A0=C2=A0 } else {<br>

+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;max_brightness =3D MAX_PERC=
ENT_BRIGHTNESS;<br>+=C2=A0=C2=A0=C2=A0 }<br>=C2=A0<br>-=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 ret =3D of_property_read_u32(node, &quot;default-brightn=
ess-level&quot;,<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0 &amp;value);<br>-=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret &lt; 0)<br>

-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;<br>+=
=C2=A0=C2=A0=C2=A0 ret =3D of_property_read_u32(node, &quot;default-brightn=
ess-level&quot;,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 &amp;va=
lue);<br>+=C2=A0=C2=A0=C2=A0 if (ret &lt; 0)<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 return ret;<br>=C2=A0<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 data-&gt;dft_brightness =3D value;<br>

-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data-&gt;max_brightness--;<br>-=C2=
=A0=C2=A0=C2=A0 }<br>+=C2=A0=C2=A0=C2=A0 data-&gt;dft_brightness =3D value;=
<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>=C2=A0}<div class=3D"">=
<div id=3D":1ph" class=3D"" tabindex=3D"0"><img class=3D"" src=3D"https://s=
sl.gstatic.com/ui/v1/icons/mail/images/cleardot.gif"></div>
</div><span class=3D""><font color=3D"#888888"><br>-- <br>2.0.0</font></spa=
n></div></div>

--001a113441562448c904fccaa26b--
