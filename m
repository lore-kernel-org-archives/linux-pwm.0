Return-Path: <tmaimon77@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180530164604.GB8270@roeck-us.net>
References: <1527588141-18639-1-git-send-email-tmaimon77@gmail.com>
 <1527588141-18639-3-git-send-email-tmaimon77@gmail.com> <20180529165617.GD2162@roeck-us.net>
 <CAP6Zq1h8_n8R=dqmBxC_bK_YstLt1kkE6UCp2OVsNpKp=RK8og@mail.gmail.com> <20180530164604.GB8270@roeck-us.net>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 31 May 2018 15:32:17 +0300
Message-ID: <CAP6Zq1j1uYmnZF73NWKVq6=K40iTEe1akSS67i0XOZvHgHzNDQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] hwmon: npcm-pwm: add NPCM7xx PWM driver
Content-Type: multipart/alternative; boundary="00000000000079fa60056d7fa846"
List-ID: <linux-pwm.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, jdelvare@suse.com, Avi Fishman <avifishman70@gmail.com>, Nancy Yuen <yuenn@google.com>, Brendan Higgins <brendanhiggins@google.com>, Patrick Venture <venture@google.com>, Joel Stanley <joel@jms.id.au>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, eyal.cohen@nuvoton.com

--00000000000079fa60056d7fa846
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Thanks for the prompt and detailed reply,

On 30 May 2018 at 19:46, Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, May 30, 2018 at 06:44:58PM +0300, Tomer Maimon wrote:
> > Hi  Guenter,
> >
> > Thanks for your prompt reply!
> >
> >
> > On 29 May 2018 at 19:56, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > > On Tue, May 29, 2018 at 01:02:21PM +0300, Tomer Maimon wrote:
> > > > Add Nuvoton BMC NPCM7xx Pulse Width Modulation (PWM) driver.
> > > >
> > > > The Nuvoton BMC NPCM7xx has two identical PWM controller modules,
> > > > each module has four PWM controller outputs.
> > > >
> > >
> > > I don't see it guaranteed that all future NPCM7xx devices will be PWM
> > > controllers, much less that they will be compatible to the chip really
> > >
> >
> > Actually all NPCM7xx family have PWM and FAN modules support,
> >
> >
> > > supported here. NPCM750, I presume ? I would suggest name the driver
> > > accordingly.
> > >
> >
> > The compatible name can not be a family name like nuvoton,npcm7xx-pwm,
> only
> > a specific chip name. (in our case the NPCM750 is the full modules SOC)
> > still you think i should change the driver name? (note: all of our
> NPCM7xx
> > unique modules drivers are named npcm7xx-*.c or *-npcm7xx.c)
> >
>
> drivers/watchdog/npcm_wdt.c contradicts that statement.
>
> Please discuss with the pwm maintainer. In hwmon, wildcards in driver file
> names are discouraged and will not be accepted. Our recommendation is to
> pick
> one chip from the family and use it as part of the file name.
>

Thanks for the clarification, we will name the driver according your
recommendation.

>
> >
> > > As a generic pwm driver, not specifically tied to a fan controller,
> > > this driver does not belong into hwmon. It should be added to the pwm
> > > subsystem. Copying the maintainer and mailing list.
> > >
> > > In the NPCM7xx we have PWM and FAN controller modules,  usually in the
> > aspect of our BMC clients the two module
> > are used together to control the fans.
> >
> > But because in the NPCM7xx the PWM and the FAN controller are separate
> > modules we
> > thought to do two separate drivers in the hwmon
> > is it possible? or you think it is better to do one hwmon driver for the
> > PWM and the FAN controller.
> >
> That depends on how closely the two modules are intertwined. If the pwm
> module
> is generic, it belongs into the pwm subsystem. It only belongs into hwmon
> if it can _only_ be used for fan control, eg if the data reported by the
> fan
> module is used by the hardware to control the pwm output based on some
> fan speed <-> pw value mapping which is programmed into the chip, and/or
> if the pwm output can only connect to a fan and nothing else, and if the
> relationship between pwm output and fan input is well defined.
>
>
Again thank you for your clarification, our PWM module was designed to work
with fan devices and for fan control.
i.e. on all server boards the pwm output is only connect to a fan device.


> If both end up in hwmon, I don't see the benefit of having two separate
> drivers. That means two hwmon devices for the same fan or set of fans,
> one being all but useless in respect to output from the 'sensors'
> command. You'll have to convince me why that would make sense; I just
> don't see the point.  In that case, I would also not see the point of
> having two separate devicetree nodes; to me, that would be similar
> to having two interfaces for a single serial line, one for receive
> and one for transmit.


Since our PWM and FAN are made only for handling the fans we will use them
in a single hwmon driver as you recommended

> note that we were going to submit soon also the FAN controller driver
> under
> > hwmon.
> >
> No problem with that as long as there are no wildcards in the file name.
>
> Guenter
>

Thanks,

Tomer

--00000000000079fa60056d7fa846
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Guenter,<div><br></div><div>Thanks for the prompt and d=
etailed reply,</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quot=
e">On 30 May 2018 at 19:46, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"=
mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wed, May 3=
0, 2018 at 06:44:58PM +0300, Tomer Maimon wrote:<br>
&gt; Hi=C2=A0 Guenter,<br>
&gt; <br>
&gt; Thanks for your prompt reply!<br>
&gt; <br>
&gt; <br>
&gt; On 29 May 2018 at 19:56, Guenter Roeck &lt;<a href=3D"mailto:linux@roe=
ck-us.net">linux@roeck-us.net</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Tue, May 29, 2018 at 01:02:21PM +0300, Tomer Maimon wrote:<br>
&gt; &gt; &gt; Add Nuvoton BMC NPCM7xx Pulse Width Modulation (PWM) driver.=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The Nuvoton BMC NPCM7xx has two identical PWM controller mod=
ules,<br>
&gt; &gt; &gt; each module has four PWM controller outputs.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I don&#39;t see it guaranteed that all future NPCM7xx devices wil=
l be PWM<br>
&gt; &gt; controllers, much less that they will be compatible to the chip r=
eally<br>
&gt; &gt;<br>
&gt; <br>
&gt; Actually all NPCM7xx family have PWM and FAN modules support,<br>
&gt; <br>
&gt; <br>
&gt; &gt; supported here. NPCM750, I presume ? I would suggest name the dri=
ver<br>
&gt; &gt; accordingly.<br>
&gt; &gt;<br>
&gt; <br>
&gt; The compatible name can not be a family name like nuvoton,npcm7xx-pwm,=
 only<br>
&gt; a specific chip name. (in our case the NPCM750 is the full modules SOC=
)<br>
&gt; still you think i should change the driver name? (note: all of our NPC=
M7xx<br>
&gt; unique modules drivers are named npcm7xx-*.c or *-npcm7xx.c)<br>
&gt; <br>
<br>
</span>drivers/watchdog/npcm_wdt.c contradicts that statement.<br>
<br>
Please discuss with the pwm maintainer. In hwmon, wildcards in driver file<=
br>
names are discouraged and will not be accepted. Our recommendation is to pi=
ck<br>
one chip from the family and use it as part of the file name.<br></blockquo=
te><div><br></div><div>Thanks for the clarification, we will name the drive=
r according your=C2=A0<span style=3D"color:rgb(34,34,34);font-family:arial,=
sans-serif;font-size:small;font-style:normal;font-variant-ligatures:normal;=
font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:s=
tart;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial;float:none;display:inline">recommendation.</span></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt; <br>
&gt; &gt; As a generic pwm driver, not specifically tied to a fan controlle=
r,<br>
&gt; &gt; this driver does not belong into hwmon. It should be added to the=
 pwm<br>
&gt; &gt; subsystem. Copying the maintainer and mailing list.<br>
&gt; &gt;<br>
&gt; &gt; In the NPCM7xx we have PWM and FAN controller modules,=C2=A0 usua=
lly in the<br>
&gt; aspect of our BMC clients the two module<br>
&gt; are used together to control the fans.<br>
&gt; <br>
&gt; But because in the NPCM7xx the PWM and the FAN controller are separate=
<br>
&gt; modules we<br>
&gt; thought to do two separate drivers in the hwmon<br>
&gt; is it possible? or you think it is better to do one hwmon driver for t=
he<br>
&gt; PWM and the FAN controller.<br>
&gt; <br>
</span>That depends on how closely the two modules are intertwined. If the =
pwm module<br>
is generic, it belongs into the pwm subsystem. It only belongs into hwmon<b=
r>
if it can _only_ be used for fan control, eg if the data reported by the fa=
n<br>
module is used by the hardware to control the pwm output based on some<br>
fan speed &lt;-&gt; pw value mapping which is programmed into the chip, and=
/or<br>
if the pwm output can only connect to a fan and nothing else, and if the<br=
>
relationship between pwm output and fan input is well defined.<br>
<br></blockquote><div>=C2=A0</div><div>

<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(=
255,255,255);text-decoration-style:initial;text-decoration-color:initial">A=
gain thank you for your clarification, our PWM module was designed to work =
with fan devices and for fan control.</div><div style=3D"color:rgb(34,34,34=
);font-family:arial,sans-serif;font-size:small;font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;white-space:no=
rmal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-sty=
le:initial;text-decoration-color:initial">i.e. on all server boards the=C2=
=A0<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-siz=
e:small;font-style:normal;font-variant-ligatures:normal;font-variant-caps:n=
ormal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;background-color:=
rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initia=
l;float:none;display:inline">pwm output is only connect to a fan</span>=C2=
=A0device.</div><div style=3D"color:rgb(34,34,34);font-family:arial,sans-se=
rif;font-size:small;font-style:normal;font-variant-ligatures:normal;font-va=
riant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;te=
xt-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">=C2=A0<br></div></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">If both=
 end up in hwmon, I don&#39;t see the benefit of having two separate<br>
drivers. That means two hwmon devices for the same fan or set of fans,<br>
one being all but useless in respect to output from the &#39;sensors&#39;<b=
r>
command. You&#39;ll have to convince me why that would make sense; I just<b=
r>
don&#39;t see the point.=C2=A0 In that case, I would also not see the point=
 of<br>
having two separate devicetree nodes; to me, that would be similar<br>
to having two interfaces for a single serial line, one for receive<br>
and one for transmit.</blockquote><div>=C2=A0</div><div>

<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:sm=
all;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;te=
xt-transform:none;white-space:normal;word-spacing:0px;text-decoration-style=
:initial;text-decoration-color:initial;background-color:rgb(255,255,255)">S=
ince our PWM and FAN are made only for handling the fans we will use them i=
n a single hwmon driver as you recommended</div><div style=3D"color:rgb(34,=
34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;white-spa=
ce:normal;word-spacing:0px;text-decoration-style:initial;text-decoration-co=
lor:initial;background-color:rgb(255,255,255)"><br></div><span style=3D"col=
or:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:no=
rmal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial;float:none;display:=
inline"></span></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">
&gt; note that we were going to submit soon also the FAN controller driver =
under<br>
&gt; hwmon.<br>
&gt; <br>
</span>No problem with that as long as there are no wildcards in the file n=
ame.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Guenter<br>
</font></span></blockquote></div><br></div><div class=3D"gmail_extra">Thank=
s,</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Tom=
er</div></div>

--00000000000079fa60056d7fa846--
