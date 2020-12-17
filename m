Return-path: <tpgalchenko@gmail.com>
MIME-Version: 1.0
References: <20201216174309.1604658-1-thierry.reding@gmail.com> <20201217113123.v3jialznqipzerne@pengutronix.de>
In-Reply-To: <20201217113123.v3jialznqipzerne@pengutronix.de>
From: Taras Galchenko <tpgalchenko@gmail.com>
Date: Thu, 17 Dec 2020 15:10:05 +0300
Message-ID: <CADO=Lw4g=9pPy9Mpg6AevHo9F-TS3RXT_B+Y+wg899uaXDHKDw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ecfc5405b6a7dfda"
Subject: Re: [PATCH] pwm: sun4i: Remove erroneous else branch
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>

--000000000000ecfc5405b6a7dfda
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe,

It was my fault, I contacted Thierry directly when reporting the problem
and did not write to the list.

The problem I saw is that the backlight never gets turned off on A20 SOC no
matter what commands I send to /sys/class/backlight/backlight/bl_power .
I've investigated the origin of the problem, that was not present in the
kernel 5.6.14, and traced out the patch that broke the function.

Best regards
Taras

=D1=87=D1=82, 17 =D0=B4=D0=B5=D0=BA. 2020 =D0=B3. =D0=B2 14:31, Uwe Kleine-=
K=C3=B6nig <
u.kleine-koenig@pengutronix.de>:

> On Wed, Dec 16, 2020 at 06:43:09PM +0100, Thierry Reding wrote:
> > Commit d3817a647059 ("pwm: sun4i: Remove redundant needs_delay") change=
d
> > the logic of an else branch so that the PWM_EN and PWM_CLK_GATING bits
> > are now cleared if the PWM is to be disabled, whereas previously the
> > condition was always false, and hence the branch never got executed.
> >
> > This code is reported causing backlight issues on boards based on the
> > Allwinner A20 SoC. Fix this by removing the else branch, which restores
> > the behaviour prior to the offending commit.
> >
> > Note that the PWM_EN and PWM_CLK_GATING bits still get cleared later in
> > sun4i_pwm_apply() if the PWM is to be disabled.
> >
> > Fixes: d3817a647059 ("pwm: sun4i: Remove redundant needs_delay")
> > Reported-by: Taras Galchenko <tpgalchenko@gmail.com>
>
> This report didn't happen on the linux-pwm list, or did I miss it?
>
> What is the reported problem? I would expect a short time where the
> backlight goes off completely (or on depending on polarity?) when only a
> small continuous change is expected.
>
> > Suggested-by: Taras Galchenko <tpgalchenko@gmail.com>
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
>

--000000000000ecfc5405b6a7dfda
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Uwe,</div><div><br></div><div>It was my fault, I cont=
acted Thierry directly when reporting the problem and did not write to the =
list.</div><div><br></div><div>The problem I saw is that the backlight neve=
r gets turned off on A20 SOC no matter what commands I send to /sys/class/b=
acklight/backlight/bl_power . I&#39;ve investigated the origin of the probl=
em, that was not present in the kernel 5.6.14, and traced out the patch tha=
t broke the function.</div><div><br></div><div>Best regards<br></div><div>T=
aras<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">=D1=87=D1=82, 17 =D0=B4=D0=B5=D0=BA. 2020 =D0=B3. =D0=B2 14=
:31, Uwe Kleine-K=C3=B6nig &lt;<a href=3D"mailto:u.kleine-koenig@pengutroni=
x.de">u.kleine-koenig@pengutronix.de</a>&gt;:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Wed, Dec 16, 2020 at 06:43:09PM +0100, Thi=
erry Reding wrote:<br>
&gt; Commit d3817a647059 (&quot;pwm: sun4i: Remove redundant needs_delay&qu=
ot;) changed<br>
&gt; the logic of an else branch so that the PWM_EN and PWM_CLK_GATING bits=
<br>
&gt; are now cleared if the PWM is to be disabled, whereas previously the<b=
r>
&gt; condition was always false, and hence the branch never got executed.<b=
r>
&gt; <br>
&gt; This code is reported causing backlight issues on boards based on the<=
br>
&gt; Allwinner A20 SoC. Fix this by removing the else branch, which restore=
s<br>
&gt; the behaviour prior to the offending commit.<br>
&gt; <br>
&gt; Note that the PWM_EN and PWM_CLK_GATING bits still get cleared later i=
n<br>
&gt; sun4i_pwm_apply() if the PWM is to be disabled.<br>
&gt; <br>
&gt; Fixes: d3817a647059 (&quot;pwm: sun4i: Remove redundant needs_delay&qu=
ot;)<br>
&gt; Reported-by: Taras Galchenko &lt;<a href=3D"mailto:tpgalchenko@gmail.c=
om" target=3D"_blank">tpgalchenko@gmail.com</a>&gt;<br>
<br>
This report didn&#39;t happen on the linux-pwm list, or did I miss it?<br>
<br>
What is the reported problem? I would expect a short time where the<br>
backlight goes off completely (or on depending on polarity?) when only a<br=
>
small continuous change is expected.<br>
<br>
&gt; Suggested-by: Taras Galchenko &lt;<a href=3D"mailto:tpgalchenko@gmail.=
com" target=3D"_blank">tpgalchenko@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Thierry Reding &lt;<a href=3D"mailto:thierry.reding@gma=
il.com" target=3D"_blank">thierry.reding@gmail.com</a>&gt;<br>
<br>
Reviewed-by: Uwe Kleine-K=C3=B6nig &lt;<a href=3D"mailto:u.kleine-koenig@pe=
ngutronix.de" target=3D"_blank">u.kleine-koenig@pengutronix.de</a>&gt;<br>
<br>
Best regards<br>
Uwe<br>
<br>
-- <br>
Pengutronix e.K.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Uwe Kleine-K=C3=B6nig=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
Industrial Linux Solutions=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| <a href=3D"https://www.pengutronix.de/" rel=3D"noreferrer" t=
arget=3D"_blank">https://www.pengutronix.de/</a> |<br>
</blockquote></div>

--000000000000ecfc5405b6a7dfda--
