Return-path: <kever.yang@gmail.com>
MIME-Version: 1.0
From: Kever Yang <kever.yang@rock-chips.com>
Date: Fri, 25 Dec 2020 15:15:12 +0800
Message-ID: <CAKUh=Rw=9u-hhjRv6cFMLuq0+od=gAGedbv-on1rgGweWu_SeA@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000016b26905b744b0ea"
Subject: Re: [PATCH v3 7/7] pwm: rockchip: Enable clock before calling clk_get_rate()
To: Simon South <simon@simonsouth.net>
Cc: tpiepho@gmail.com, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, Robin Murphy <robin.murphy@arm.com>, lee.jones@linaro.org, Heiko Stuebner <heiko@sntech.de>, bbrezillon@kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, David Wu <david.wu@rock-chips.com>, steven.liu@rock-chips.com
List-ID: <linux-pwm.vger.kernel.org>

--00000000000016b26905b744b0ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ David and Steven,

Hi Steven,
    please help to review this patch set.

Thanks
- Kever

Simon South <simon@simonsouth.net> =E4=BA=8E2020=E5=B9=B412=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:01=E5=86=99=E9=81=93=EF=BC=9A

> The documentation for clk_get_rate() in include/linux/clk.h states the
> function's result is valid only for a clock source that has been
> enabled. However, the Rockchip PWM driver uses this function in two place=
s
> to query the rate of a clock without first ensuring it is enabled.
>
> Fix this by modifying rockchip_pwm_get_state() and rockchip_pwm_apply() s=
o
> they enable a device's PWM clock before querying its rate (in the latter
> case, the querying is actually done in rockchip_pwm_config()) and disable
> the clock again before returning.
>
> Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Simon South <simon@simonsouth.net>
> ---
>  drivers/pwm/pwm-rockchip.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index 02da7370db70..44425eeb4e81 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -72,6 +72,10 @@ static void rockchip_pwm_get_state(struct pwm_chip
> *chip,
>         if (ret)
>                 return;
>
> +       ret =3D clk_enable(pc->clk);
> +       if (ret)
> +               return;
> +
>         clk_rate =3D clk_get_rate(pc->clk);
>
>         tmp =3D readl_relaxed(pc->base + pc->data->regs.period);
> @@ -90,6 +94,7 @@ static void rockchip_pwm_get_state(struct pwm_chip *chi=
p,
>         else
>                 state->polarity =3D PWM_POLARITY_NORMAL;
>
> +       clk_disable(pc->clk);
>         clk_disable(pc->pclk);
>  }
>
> @@ -189,6 +194,10 @@ static int rockchip_pwm_apply(struct pwm_chip *chip,
> struct pwm_device *pwm,
>         if (ret)
>                 return ret;
>
> +       ret =3D clk_enable(pc->clk);
> +       if (ret)
> +               return ret;
> +
>         pwm_get_state(pwm, &curstate);
>         enabled =3D curstate.enabled;
>
> @@ -208,6 +217,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip,
> struct pwm_device *pwm,
>         }
>
>  out:
> +       clk_disable(pc->clk);
>         clk_disable(pc->pclk);
>
>         return ret;
> --
> 2.29.2
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>

--00000000000016b26905b744b0ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>+ David and Steven,=
<br></div><div><br></div><div>Hi Steven,</div><div>=C2=A0 =C2=A0 please hel=
p to review this patch set.</div><div><br></div>Thanks<div>- Kever</div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Sim=
on South &lt;<a href=3D"mailto:simon@simonsouth.net">simon@simonsouth.net</=
a>&gt; =E4=BA=8E2020=E5=B9=B412=E6=9C=8824=E6=97=A5=E5=91=A8=E5=9B=9B =E4=
=B8=8A=E5=8D=8812:01=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">The documentation for clk_get_rate() in in=
clude/linux/clk.h states the<br>
function&#39;s result is valid only for a clock source that has been<br>
enabled. However, the Rockchip PWM driver uses this function in two places<=
br>
to query the rate of a clock without first ensuring it is enabled.<br>
<br>
Fix this by modifying rockchip_pwm_get_state() and rockchip_pwm_apply() so<=
br>
they enable a device&#39;s PWM clock before querying its rate (in the latte=
r<br>
case, the querying is actually done in rockchip_pwm_config()) and disable<b=
r>
the clock again before returning.<br>
<br>
Reported-by: Uwe Kleine-K=C3=B6nig &lt;<a href=3D"mailto:u.kleine-koenig@pe=
ngutronix.de" target=3D"_blank">u.kleine-koenig@pengutronix.de</a>&gt;<br>
Signed-off-by: Simon South &lt;<a href=3D"mailto:simon@simonsouth.net" targ=
et=3D"_blank">simon@simonsouth.net</a>&gt;<br>
---<br>
=C2=A0drivers/pwm/pwm-rockchip.c | 10 ++++++++++<br>
=C2=A01 file changed, 10 insertions(+)<br>
<br>
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c<br>
index 02da7370db70..44425eeb4e81 100644<br>
--- a/drivers/pwm/pwm-rockchip.c<br>
+++ b/drivers/pwm/pwm-rockchip.c<br>
@@ -72,6 +72,10 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D clk_enable(pc-&gt;clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_rate =3D clk_get_rate(pc-&gt;clk);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp =3D readl_relaxed(pc-&gt;base + pc-&gt;data=
-&gt;regs.period);<br>
@@ -90,6 +94,7 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state-&gt;polarity =
=3D PWM_POLARITY_NORMAL;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable(pc-&gt;clk);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(pc-&gt;pclk);<br>
=C2=A0}<br>
<br>
@@ -189,6 +194,10 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D clk_enable(pc-&gt;clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwm_get_state(pwm, &amp;curstate);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enabled =3D curstate.enabled;<br>
<br>
@@ -208,6 +217,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0out:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable(pc-&gt;clk);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(pc-&gt;pclk);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
-- <br>
2.29.2<br>
<br>
<br>
_______________________________________________<br>
Linux-rockchip mailing list<br>
<a href=3D"mailto:Linux-rockchip@lists.infradead.org" target=3D"_blank">Lin=
ux-rockchip@lists.infradead.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-rockchip" rel=
=3D"noreferrer" target=3D"_blank">http://lists.infradead.org/mailman/listin=
fo/linux-rockchip</a><br>
</blockquote></div></div></div>

--00000000000016b26905b744b0ea--
