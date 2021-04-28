Return-path: <roman.beranek@prusa3d.cz>
MIME-Version: 1.0
References: <20210428001946.1059426-1-roman.beranek@prusa3d.com> <20210428061357.725m72aikc52n4gg@pengutronix.de>
In-Reply-To: <20210428061357.725m72aikc52n4gg@pengutronix.de>
From: =?UTF-8?Q?Roman_Ber=C3=A1nek?= <roman.beranek@prusa3d.cz>
Date: Wed, 28 Apr 2021 14:07:56 +0200
Message-ID: <CAL8eAtopkMVmt8XDbzLRsJ_JgGNwZ-FgdNPOWkh-yboTqceUyw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="0000000000004cf6c005c1073b9b"
Subject: Re: [PATCH] pwm: sun4i: Round delay time up to a nearest jiffy
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@siol.net>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com, Roman Beranek <roman.beranek@prusa3d.com>
List-ID: <linux-pwm.vger.kernel.org>

--0000000000004cf6c005c1073b9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Uwe,

Correct, the output may stay in an active state. I only discovered this
bug as I investigated a report of unreliable screen timeout. The period
we use the PWM with is 50 us.

The PWMx_RDY bit stays 0 well after the last period ends, so if the bit
has any function at all, this one is certainly not it.

Cheers,
Roman

On Wed, Apr 28, 2021 at 8:14 AM Uwe Kleine-K=C3=B6nig <
u.kleine-koenig@pengutronix.de> wrote:

> Hello Roman,
>
> On Wed, Apr 28, 2021 at 02:19:46AM +0200, Roman Beranek wrote:
> > More often than not, a PWM period may span nowhere near as far
> > as 1 jiffy, yet it still must be waited upon before the channel
> > is disabled.
>
> I wonder what happens if you don't wait long enough. Is this a
> theoretical issue, or do you see an (occasional?) breakage that is fixed
> by this patch?
>
> I guess the problem is that if you disable too early the output freezes
> and that might be in a state where the output is still active? Would
> polling the PWMx_RDY bit in the control register help here?
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

--0000000000004cf6c005c1073b9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace"><div style=3D"color:rgba(0,0,0,0.87);font-family:Roboto,Roboto=
Draft,Helvetica,Arial,sans-serif;font-size:14px">Hello Uwe,</div><div style=
=3D"color:rgba(0,0,0,0.87);font-family:Roboto,RobotoDraft,Helvetica,Arial,s=
ans-serif;font-size:14px"><br></div><div style=3D"color:rgba(0,0,0,0.87);fo=
nt-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:14px">Cor=
rect, the output may stay in an active state. I only discovered this<span s=
tyle=3D"white-space:pre">	</span></div><div style=3D"color:rgba(0,0,0,0.87)=
;font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:14px">=
bug as I investigated a report of unreliable screen timeout. The period</di=
v><div style=3D"color:rgba(0,0,0,0.87);font-family:Roboto,RobotoDraft,Helve=
tica,Arial,sans-serif;font-size:14px">we use the PWM with is 50 us.</div><d=
iv style=3D"color:rgba(0,0,0,0.87);font-family:Roboto,RobotoDraft,Helvetica=
,Arial,sans-serif;font-size:14px"><br></div><div style=3D"color:rgba(0,0,0,=
0.87);font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:1=
4px">The PWMx_RDY bit stays 0 well after the last period ends, so if the bi=
t</div><div style=3D"color:rgba(0,0,0,0.87);font-family:Roboto,RobotoDraft,=
Helvetica,Arial,sans-serif;font-size:14px">has any function at all, this on=
e is certainly not it.</div><div style=3D"color:rgba(0,0,0,0.87);font-famil=
y:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:14px"><br></div><=
div style=3D"color:rgba(0,0,0,0.87);font-family:Roboto,RobotoDraft,Helvetic=
a,Arial,sans-serif;font-size:14px">Cheers,</div><div style=3D"color:rgba(0,=
0,0,0.87);font-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-si=
ze:14px">Roman</div></div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Wed, Apr 28, 2021 at 8:14 AM Uwe Kleine-K=C3=
=B6nig &lt;<a href=3D"mailto:u.kleine-koenig@pengutronix.de">u.kleine-koeni=
g@pengutronix.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Hello Roman,<br>
<br>
On Wed, Apr 28, 2021 at 02:19:46AM +0200, Roman Beranek wrote:<br>
&gt; More often than not, a PWM period may span nowhere near as far<br>
&gt; as 1 jiffy, yet it still must be waited upon before the channel<br>
&gt; is disabled.<br>
<br>
I wonder what happens if you don&#39;t wait long enough. Is this a<br>
theoretical issue, or do you see an (occasional?) breakage that is fixed<br=
>
by this patch?<br>
<br>
I guess the problem is that if you disable too early the output freezes<br>
and that might be in a state where the output is still active? Would<br>
polling the PWMx_RDY bit in the control register help here?<br>
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

--0000000000004cf6c005c1073b9b--
