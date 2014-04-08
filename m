Return-path: <tim.kryger@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20140408070259.68923987@ipc1.ka-ro>
References: <1395235375-12925-1-git-send-email-LW@KARO-electronics.de>
	<1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
	<1395996540-10999-2-git-send-email-LW@KARO-electronics.de>
	<20140402055350.GX17250@pengutronix.de>
	<20140407113652.GE26985@ulmo>
	<20140408070259.68923987@ipc1.ka-ro>
Date: Tue, 8 Apr 2014 13:37:36 -0700
Message-ID: <CAAYSxhpL_0FJvuvGODMTZDm7DtK3eBTVYdhf1Ot7PW94gSM8iw@mail.gmail.com>
From: Tim Kryger <tim.kryger@linaro.org>
Content-Type: multipart/alternative; boundary=001a11c1e676565d9904f68df4f5
Subject: Re: [PATCHv3 1/3] pwm: make the PWM_POLARITY flag in DTB optional
To: =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW@karo-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-pwm.vger.kernel.org>

--001a11c1e676565d9904f68df4f5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2014 at 10:02 PM, Lothar Wa=DFmann <LW@karo-electronics.de>w=
rote:
>
>
> Thierry Reding wrote:
>
> > No. You cannot emulate polarity inversion in software.
> >
> Why not?
>
> duty_ns =3D period_ns - duty_ns;
>

Since I made the same mistake, I will pass along the pointer Thierry gave
me.

In include/linux/pwm.h the second difference for an inverted signal is
described.

/**
 * enum pwm_polarity - polarity of a PWM signal
 * @PWM_POLARITY_NORMAL: a high signal for the duration of the duty-
 * cycle, followed by a low signal for the remainder of the pulse
 * period
 * @PWM_POLARITY_INVERSED: a low signal for the duration of the duty-
 * cycle, followed by a high signal for the remainder of the pulse
 * period
 */
enum pwm_polarity {
PWM_POLARITY_NORMAL,
PWM_POLARITY_INVERSED,
};

Of course, I suspect not all PWM hardware respects this definition of
inverted output.

Either way, hacking the duty in software certainly would get the high/low
order wrong.

-Tim

--001a11c1e676565d9904f68df4f5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Apr 7, 2014 at 10:02 PM, Lothar Wa=DFmann <span dir=3D"ltr">&lt;<a href=
=3D"mailto:LW@karo-electronics.de" target=3D"_blank">LW@karo-electronics.de=
</a>&gt;</span> wrote:<blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex">

<div><div class=3D"h5"><br>
Thierry Reding wrote:<br><br>
&gt; No. You cannot emulate polarity inversion in software.<br>
&gt;<br>
</div></div>Why not?<br>
<br>
duty_ns =3D period_ns - duty_ns;<br></blockquote><div><br></div><div>Since =
I made the same mistake, I will pass along the pointer Thierry gave me.</di=
v><div><br></div><div>In include/linux/pwm.h the second difference for an i=
nverted signal is described.<br>
</div><div><br></div><div><div>/**</div><div>=A0* enum pwm_polarity - polar=
ity of a PWM signal</div><div>=A0* @PWM_POLARITY_NORMAL: a high signal for =
the duration of the duty-</div><div>=A0* cycle, followed by a low signal fo=
r the remainder of the pulse</div>
<div>=A0* period</div><div>=A0* @PWM_POLARITY_INVERSED: a low signal for th=
e duration of the duty-</div><div>=A0* cycle, followed by a high signal for=
 the remainder of the pulse</div><div>=A0* period</div><div>=A0*/</div><div=
>enum pwm_polarity {</div>
<div><span class=3D"" style=3D"white-space:pre">	</span>PWM_POLARITY_NORMAL=
,</div><div><span class=3D"" style=3D"white-space:pre">	</span>PWM_POLARITY=
_INVERSED,</div><div>};</div></div><div><br></div><div>Of course, I suspect=
 not all PWM hardware respects this definition of inverted output.</div>
<div><br></div><div>Either way, hacking the duty in software certainly woul=
d get the high/low order wrong.</div><div><br></div><div>-Tim</div></div></=
div></div>

--001a11c1e676565d9904f68df4f5--
