Return-path: <kever.yang@gmail.com>
MIME-Version: 1.0
From: Kever Yang <kever.yang@rock-chips.com>
Date: Fri, 25 Dec 2020 15:14:04 +0800
Message-ID: <CAKUh=Rye7f9GuK1xJ73A8p_RC3P9fNLiFU1fjpAB+FZLzECiZg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000083e8605b744ac4d"
Subject: Re: [PATCH v3 5/7] pwm: rockchip: rockchip_pwm_probe(): Remove
 unneeded goto target
In-Reply-To: <0637b8ebea49b30e5e675385225d59d028077421.1608735481.git.simon@simonsouth.net>
To: Simon South <simon@simonsouth.net>
Cc: tpiepho@gmail.com, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, Robin Murphy <robin.murphy@arm.com>, lee.jones@linaro.org, Heiko Stuebner <heiko@sntech.de>, bbrezillon@kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, David Wu <david.wu@rock-chips.com>, steven.liu@rock-chips.com
List-ID: <linux-pwm.vger.kernel.org>

--000000000000083e8605b744ac4d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ David and Steven,

Hi Steven,
    please help to review this patch set.

Thanks
- Kever

Simon South <simon@simonsouth.net> =E4=BA=8E2020=E5=B9=B412=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:01=E5=86=99=E9=81=93=EF=BC=9A

> Eliminate the remaining goto target in rockchip_pwm_probe() by moving the
> code that follows it to the point where it is invoked.
>
> The target no longer serves any purpose as the error-handling portions of
> this function no longer share any recovery steps.
>
> Signed-off-by: Simon South <simon@simonsouth.net>
> ---
>  drivers/pwm/pwm-rockchip.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index d904a5d24885..80f5e69d9b8a 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -336,7 +336,8 @@ static int rockchip_pwm_probe(struct platform_device
> *pdev)
>         ret =3D clk_prepare_enable(pc->pclk);
>         if (ret) {
>                 dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
> -               goto err_clk;
> +               clk_disable_unprepare(pc->clk);
> +               return ret;
>         }
>
>         platform_set_drvdata(pdev, pc);
> @@ -372,11 +373,6 @@ static int rockchip_pwm_probe(struct platform_device
> *pdev)
>         }
>
>         return 0;
> -
> -err_clk:
> -       clk_disable_unprepare(pc->clk);
> -
> -       return ret;
>  }
>
>  static int rockchip_pwm_remove(struct platform_device *pdev)
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

--000000000000083e8605b744ac4d
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
b(204,204,204);padding-left:1ex">Eliminate the remaining goto target in roc=
kchip_pwm_probe() by moving the<br>
code that follows it to the point where it is invoked.<br>
<br>
The target no longer serves any purpose as the error-handling portions of<b=
r>
this function no longer share any recovery steps.<br>
<br>
Signed-off-by: Simon South &lt;<a href=3D"mailto:simon@simonsouth.net" targ=
et=3D"_blank">simon@simonsouth.net</a>&gt;<br>
---<br>
=C2=A0drivers/pwm/pwm-rockchip.c | 8 ++------<br>
=C2=A01 file changed, 2 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c<br>
index d904a5d24885..80f5e69d9b8a 100644<br>
--- a/drivers/pwm/pwm-rockchip.c<br>
+++ b/drivers/pwm/pwm-rockchip.c<br>
@@ -336,7 +336,8 @@ static int rockchip_pwm_probe(struct platform_device *p=
dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D clk_prepare_enable(pc-&gt;pclk);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;pdev-&=
gt;dev, &quot;Can&#39;t enable APB clk: %d\n&quot;, ret);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_clk;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepa=
re(pc-&gt;clk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, pc);<br>
@@ -372,11 +373,6 @@ static int rockchip_pwm_probe(struct platform_device *=
pdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-<br>
-err_clk:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(pc-&gt;clk);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
=C2=A0static int rockchip_pwm_remove(struct platform_device *pdev)<br>
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

--000000000000083e8605b744ac4d--
