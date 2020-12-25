Return-path: <kever.yang@gmail.com>
MIME-Version: 1.0
From: Kever Yang <kever.yang@rock-chips.com>
Date: Fri, 25 Dec 2020 15:11:56 +0800
Message-ID: <CAKUh=RykcMcbuQ0gAgTL0PyCHO6aqck4NdwgpmHaz6mwyLdxQg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000623b8805b744a45e"
Subject: Re: [PATCH v3 1/7] pwm: rockchip: Enable APB clock during register
 access while probing
In-Reply-To: <49ceda3def13f6186073745e99d7315c974bfa81.1608735481.git.simon@simonsouth.net>
To: Simon South <simon@simonsouth.net>
Cc: tpiepho@gmail.com, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, Robin Murphy <robin.murphy@arm.com>, lee.jones@linaro.org, Heiko Stuebner <heiko@sntech.de>, bbrezillon@kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, David Wu <david.wu@rock-chips.com>, steven.liu@rock-chips.com
List-ID: <linux-pwm.vger.kernel.org>

--000000000000623b8805b744a45e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ David and Steven,

Hi Steven,
    please help to review this patch set.

Thanks
- Kever

Simon South <simon@simonsouth.net> =E4=BA=8E2020=E5=B9=B412=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:01=E5=86=99=E9=81=93=EF=BC=9A

> Commit 457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while
> probing") modified rockchip_pwm_probe() to access a PWM device's register=
s
> directly to check whether or not the device is running, but did not also
> change the function to first enable the device's APB clock to be certain
> the device can respond. This risks hanging the kernel on systems with PWM
> devices that use more than a single clock.
>
> Avoid this by enabling the device's APB clock before accessing its
> registers (and disabling the clock when register access is complete).
>
> Fixes: 457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while
> probing")
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Suggested-by: Trent Piepho <tpiepho@gmail.com>
> Signed-off-by: Simon South <simon@simonsouth.net>
> ---
>  drivers/pwm/pwm-rockchip.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index 77c23a2c6d71..d2058138ce1e 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -332,9 +332,9 @@ static int rockchip_pwm_probe(struct platform_device
> *pdev)
>                 return ret;
>         }
>
> -       ret =3D clk_prepare(pc->pclk);
> +       ret =3D clk_prepare_enable(pc->pclk);
>         if (ret) {
> -               dev_err(&pdev->dev, "Can't prepare APB clk: %d\n", ret);
> +               dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
>                 goto err_clk;
>         }
>
> @@ -364,10 +364,12 @@ static int rockchip_pwm_probe(struct platform_devic=
e
> *pdev)
>         if ((ctrl & enable_conf) !=3D enable_conf)
>                 clk_disable(pc->clk);
>
> +       clk_disable(pc->pclk);
> +
>         return 0;
>
>  err_pclk:
> -       clk_unprepare(pc->pclk);
> +       clk_disable_unprepare(pc->pclk);
>  err_clk:
>         clk_disable_unprepare(pc->clk);
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

--000000000000623b8805b744a45e
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
b(204,204,204);padding-left:1ex">Commit 457f74abbed0 (&quot;pwm: rockchip: =
Keep enabled PWMs running while<br>
probing&quot;) modified rockchip_pwm_probe() to access a PWM device&#39;s r=
egisters<br>
directly to check whether or not the device is running, but did not also<br=
>
change the function to first enable the device&#39;s APB clock to be certai=
n<br>
the device can respond. This risks hanging the kernel on systems with PWM<b=
r>
devices that use more than a single clock.<br>
<br>
Avoid this by enabling the device&#39;s APB clock before accessing its<br>
registers (and disabling the clock when register access is complete).<br>
<br>
Fixes: 457f74abbed0 (&quot;pwm: rockchip: Keep enabled PWMs running while p=
robing&quot;)<br>
Reported-by: Thierry Reding &lt;<a href=3D"mailto:thierry.reding@gmail.com"=
 target=3D"_blank">thierry.reding@gmail.com</a>&gt;<br>
Suggested-by: Trent Piepho &lt;<a href=3D"mailto:tpiepho@gmail.com" target=
=3D"_blank">tpiepho@gmail.com</a>&gt;<br>
Signed-off-by: Simon South &lt;<a href=3D"mailto:simon@simonsouth.net" targ=
et=3D"_blank">simon@simonsouth.net</a>&gt;<br>
---<br>
=C2=A0drivers/pwm/pwm-rockchip.c | 8 +++++---<br>
=C2=A01 file changed, 5 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c<br>
index 77c23a2c6d71..d2058138ce1e 100644<br>
--- a/drivers/pwm/pwm-rockchip.c<br>
+++ b/drivers/pwm/pwm-rockchip.c<br>
@@ -332,9 +332,9 @@ static int rockchip_pwm_probe(struct platform_device *p=
dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare(pc-&gt;pclk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D clk_prepare_enable(pc-&gt;pclk);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&=
gt;dev, &quot;Can&#39;t prepare APB clk: %d\n&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&=
gt;dev, &quot;Can&#39;t enable APB clk: %d\n&quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_clk;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -364,10 +364,12 @@ static int rockchip_pwm_probe(struct platform_device =
*pdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((ctrl &amp; enable_conf) !=3D enable_conf)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(pc-&gt;=
clk);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable(pc-&gt;pclk);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
=C2=A0err_pclk:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_unprepare(pc-&gt;pclk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable_unprepare(pc-&gt;pclk);<br>
=C2=A0err_clk:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable_unprepare(pc-&gt;clk);<br>
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

--000000000000623b8805b744a45e--
