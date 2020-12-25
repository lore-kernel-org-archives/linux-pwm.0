Return-path: <kever.yang@gmail.com>
MIME-Version: 1.0
From: Kever Yang <kever.yang@rock-chips.com>
Date: Fri, 25 Dec 2020 15:14:39 +0800
Message-ID: <CAKUh=Rx5LtNJFtTvzNOkP4-5vXmHd3Q5tp2WhygkYi8HHjrLDQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000022f61f05b744ae70"
Subject: Re: [PATCH v3 6/7] pwm: rockchip: Enable PWM clock of probed device
 only if running
In-Reply-To: <cb5a28d5fde04c09e9aace6ce619e445f895e0a8.1608735481.git.simon@simonsouth.net>
To: Simon South <simon@simonsouth.net>
Cc: tpiepho@gmail.com, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, Robin Murphy <robin.murphy@arm.com>, lee.jones@linaro.org, Heiko Stuebner <heiko@sntech.de>, bbrezillon@kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, David Wu <david.wu@rock-chips.com>, steven.liu@rock-chips.com
List-ID: <linux-pwm.vger.kernel.org>

--00000000000022f61f05b744ae70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ David and Steven,

Hi Steven,
    please help to review this patch set.

Thanks
- Kever

Simon South <simon@simonsouth.net> =E4=BA=8E2020=E5=B9=B412=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:01=E5=86=99=E9=81=93=EF=BC=9A

> Currently rockchip_pwm_probe() enables the PWM clock of every device it
> matches, then disables the clock unless the device itself appears to have
> been enabled (by a bootloader, presumably) before the kernel started.
>
> Simplify this by enabling (rather, keeping enabled) the PWM clock of only
> devices that are already running, as enabling the clock for any other
> device during probing is unnecessary.
>
> Signed-off-by: Simon South <simon@simonsouth.net>
> ---
>  drivers/pwm/pwm-rockchip.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index 80f5e69d9b8a..02da7370db70 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -327,12 +327,6 @@ static int rockchip_pwm_probe(struct platform_device
> *pdev)
>                 return ret;
>         }
>
> -       ret =3D clk_prepare_enable(pc->clk);
> -       if (ret) {
> -               dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n",
> ret);
> -               return ret;
> -       }
> -
>         ret =3D clk_prepare_enable(pc->pclk);
>         if (ret) {
>                 dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
> @@ -357,8 +351,19 @@ static int rockchip_pwm_probe(struct platform_device
> *pdev)
>         enable_conf =3D pc->data->enable_conf;
>         ctrl =3D readl_relaxed(pc->base + pc->data->regs.ctrl);
>         enabled =3D ((ctrl & enable_conf) =3D=3D enable_conf);
> -       if (!enabled)
> -               clk_disable(pc->clk);
> +       if (enabled) {
> +               ret =3D clk_prepare_enable(pc->clk);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Can't enable PWM clk: %d\n",
> ret);
> +                       return ret;
> +               }
> +       } else {
> +               ret =3D clk_prepare(pc->clk);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Can't prepare PWM clk: %d\n"=
,
> ret);
> +                       return ret;
> +               }
> +       }
>
>         clk_disable(pc->pclk);
>
> --
> 2.29.2
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
>
>
>

--00000000000022f61f05b744ae70
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
b(204,204,204);padding-left:1ex">Currently rockchip_pwm_probe() enables the=
 PWM clock of every device it<br>
matches, then disables the clock unless the device itself appears to have<b=
r>
been enabled (by a bootloader, presumably) before the kernel started.<br>
<br>
Simplify this by enabling (rather, keeping enabled) the PWM clock of only<b=
r>
devices that are already running, as enabling the clock for any other<br>
device during probing is unnecessary.<br>
<br>
Signed-off-by: Simon South &lt;<a href=3D"mailto:simon@simonsouth.net" targ=
et=3D"_blank">simon@simonsouth.net</a>&gt;<br>
---<br>
=C2=A0drivers/pwm/pwm-rockchip.c | 21 +++++++++++++--------<br>
=C2=A01 file changed, 13 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c<br>
index 80f5e69d9b8a..02da7370db70 100644<br>
--- a/drivers/pwm/pwm-rockchip.c<br>
+++ b/drivers/pwm/pwm-rockchip.c<br>
@@ -327,12 +327,6 @@ static int rockchip_pwm_probe(struct platform_device *=
pdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare_enable(pc-&gt;clk);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&=
gt;dev, &quot;Can&#39;t prepare enable PWM clk: %d\n&quot;, ret);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D clk_prepare_enable(pc-&gt;pclk);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;pdev-&=
gt;dev, &quot;Can&#39;t enable APB clk: %d\n&quot;, ret);<br>
@@ -357,8 +351,19 @@ static int rockchip_pwm_probe(struct platform_device *=
pdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_conf =3D pc-&gt;data-&gt;enable_conf;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctrl =3D readl_relaxed(pc-&gt;base + pc-&gt;dat=
a-&gt;regs.ctrl);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enabled =3D ((ctrl &amp; enable_conf) =3D=3D en=
able_conf);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!enabled)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable(pc-&gt;=
clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (enabled) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare=
_enable(pc-&gt;clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_err(&amp;pdev-&gt;dev, &quot;Can&#39;t enable PWM clk: %d\n&q=
uot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare=
(pc-&gt;clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_err(&amp;pdev-&gt;dev, &quot;Can&#39;t prepare PWM clk: %d\n&=
quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(pc-&gt;pclk);<br>
<br>
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
<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000022f61f05b744ae70--
