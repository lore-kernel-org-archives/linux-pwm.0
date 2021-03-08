Return-path: <fengzheng923@gmail.com>
MIME-Version: 1.0
References: <20210302123737.1867-1-fengzheng923@gmail.com> <20210304160747.pblbugvgsa2oueqi@gilmour>
In-Reply-To: <20210304160747.pblbugvgsa2oueqi@gilmour>
From: =?UTF-8?B?54+t5rab?= <fengzheng923@gmail.com>
Date: Mon, 8 Mar 2021 10:47:03 +0800
Message-ID: <CAE=m61_X7YAZ_X5ZiWY4g04Mfk+AY0-TrvDsXmVk73kq0LPWCA@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000083a80805bcfd7316"
Subject: Re: [PATCH v3 1/2] pwm: sunxi: Add Allwinner SoC PWM controller driver
To: Maxime Ripard <maxime@cerno.tech>
Cc: thierry.reding@gmail.com, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, wens@csie.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-pwm.vger.kernel.org>

--00000000000083a80805bcfd7316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,  Maxime

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B43=E6=9C=885=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:07=E5=86=99=E9=81=93=EF=BC=9A

> Hi,
>
> On Tue, Mar 02, 2021 at 08:37:37PM +0800, Ban Tao wrote:
> > From: Ban Tao <fengzheng923@gmail.com>
> >
> > The Allwinner R818, A133, R329, V536 and V833 has a new PWM controller
> > IP compared to the older Allwinner SoCs.
> >
> > Signed-off-by: Ban Tao <fengzheng923@gmail.com>
>
> Thanks for sending an update.
>
> Like I said in the previous version though, without proper SoC support
> upstream, that driver would effectively be dead code
>

I'm not sure if the latest Linux code supports R818, A133, R329, V536 or
V833,
But the driver supports most of the sun50i family of SoCs and some of the
sun8i SoCs.
Maybe I shouldn't submit this code right now...
>
>
> Maxime
>

--00000000000083a80805bcfd7316
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,=C2=A0=C2=A0Maxime<span style=3D"color=
:rgb(32,33,36);font-size:0.875rem;font-weight:bold;letter-spacing:0.2px;fon=
t-family:Roboto,RobotoDraft,Helvetica,Arial,sans-serif;white-space:nowrap">=
</span><table cellpadding=3D"0" class=3D"gmail-cf gmail-gJ" style=3D"border=
-collapse:collapse;margin-top:0px;width:auto;font-family:Roboto,RobotoDraft=
,Helvetica,Arial,sans-serif;font-size:14px;letter-spacing:0.2px;display:blo=
ck;color:rgb(119,119,119)"></table></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">Maxime Ripard &lt;maxime@cerno.tech&gt; =
=E4=BA=8E2021=E5=B9=B43=E6=9C=885=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=
=8D=8812:07=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Hi,<br>
<br>
On Tue, Mar 02, 2021 at 08:37:37PM +0800, Ban Tao wrote:<br>
&gt; From: Ban Tao &lt;<a href=3D"mailto:fengzheng923@gmail.com" target=3D"=
_blank">fengzheng923@gmail.com</a>&gt;<br>
&gt; <br>
&gt; The Allwinner R818, A133, R329, V536 and V833 has a new PWM controller=
<br>
&gt; IP compared to the older Allwinner SoCs.<br>
&gt; <br>
&gt; Signed-off-by: Ban Tao &lt;<a href=3D"mailto:fengzheng923@gmail.com" t=
arget=3D"_blank">fengzheng923@gmail.com</a>&gt;<br>
<br>
Thanks for sending an update.<br>
<br>
Like I said in the previous version though, without proper SoC support<br>
upstream, that driver would effectively be dead code<br></blockquote><div><=
br></div><div>I&#39;m not sure if the latest Linux code supports R818, A133=
, R329, V536 or V833,=C2=A0</div><div>But the driver supports most of the s=
un50i family of SoCs and some of the sun8i SoCs.</div>Maybe I shouldn&#39;t=
 submit this code right now...<blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
Maxime<br>
</blockquote></div></div>

--00000000000083a80805bcfd7316--
