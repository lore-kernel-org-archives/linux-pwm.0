Return-path: <kever.yang@gmail.com>
MIME-Version: 1.0
References: <cover.1608735481.git.simon@simonsouth.net> <1c2f85dafab03d6f5cdbcac37e7288de8f90e6d8.1608735481.git.simon@simonsouth.net>
In-Reply-To: <1c2f85dafab03d6f5cdbcac37e7288de8f90e6d8.1608735481.git.simon@simonsouth.net>
From: Kever Yang <kever.yang@rock-chips.com>
Date: Fri, 25 Dec 2020 15:13:05 +0800
Message-ID: <CAKUh=Rx2OhPnARJFEcK6difu1p5hnSHLEQbDghWUKs7zJA-6dQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000800ad905b744a876"
Subject: Re: [PATCH v3 3/7] pwm: rockchip: Replace "bus clk" with "PWM clk"
To: Simon South <simon@simonsouth.net>
Cc: tpiepho@gmail.com, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, Robin Murphy <robin.murphy@arm.com>, lee.jones@linaro.org, Heiko Stuebner <heiko@sntech.de>, bbrezillon@kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, David Wu <david.wu@rock-chips.com>, steven.liu@rock-chips.com
List-ID: <linux-pwm.vger.kernel.org>

--000000000000800ad905b744a876
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ David and Steven,

Hi Steven,
    please help to review this patch set.

Thanks
- Kever

Simon South <simon@simonsouth.net> =E4=BA=8E2020=E5=B9=B412=E6=9C=8824=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:01=E5=86=99=E9=81=93=EF=BC=9A

> Clarify the Rockchip PWM driver's error messages by referring to the cloc=
k
> that operates a PWM device as the "PWM" clock, rather than the "bus"
> clock (which is especially misleading in the case of devices that also us=
e
> a separate clock for bus access).
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Simon South <simon@simonsouth.net>
> ---
>  drivers/pwm/pwm-rockchip.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index 0c940c7508ea..3b1aa5daafff 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -309,7 +309,7 @@ static int rockchip_pwm_probe(struct platform_device
> *pdev)
>                 pc->clk =3D devm_clk_get(&pdev->dev, NULL);
>                 if (IS_ERR(pc->clk))
>                         return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk)=
,
> -                                            "Can't get bus clk\n");
> +                                            "Can't get PWM clk\n");
>         }
>
>         count =3D of_count_phandle_with_args(pdev->dev.of_node,
> @@ -328,7 +328,7 @@ static int rockchip_pwm_probe(struct platform_device
> *pdev)
>
>         ret =3D clk_prepare_enable(pc->clk);
>         if (ret) {
> -               dev_err(&pdev->dev, "Can't prepare enable bus clk: %d\n",
> ret);
> +               dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n",
> ret);
>                 return ret;
>         }
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

--000000000000800ad905b744a876
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
b(204,204,204);padding-left:1ex">Clarify the Rockchip PWM driver&#39;s erro=
r messages by referring to the clock<br>
that operates a PWM device as the &quot;PWM&quot; clock, rather than the &q=
uot;bus&quot;<br>
clock (which is especially misleading in the case of devices that also use<=
br>
a separate clock for bus access).<br>
<br>
Suggested-by: Robin Murphy &lt;<a href=3D"mailto:robin.murphy@arm.com" targ=
et=3D"_blank">robin.murphy@arm.com</a>&gt;<br>
Signed-off-by: Simon South &lt;<a href=3D"mailto:simon@simonsouth.net" targ=
et=3D"_blank">simon@simonsouth.net</a>&gt;<br>
---<br>
=C2=A0drivers/pwm/pwm-rockchip.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c<br>
index 0c940c7508ea..3b1aa5daafff 100644<br>
--- a/drivers/pwm/pwm-rockchip.c<br>
+++ b/drivers/pwm/pwm-rockchip.c<br>
@@ -309,7 +309,7 @@ static int rockchip_pwm_probe(struct platform_device *p=
dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pc-&gt;clk =3D devm=
_clk_get(&amp;pdev-&gt;dev, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(pc-&gt;c=
lk))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return dev_err_probe(&amp;pdev-&gt;dev, PTR_ERR(pc-&gt;clk),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;Can&#39;t get bus clk\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &quot;Can&#39;t get PWM clk\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 count =3D of_count_phandle_with_args(pdev-&gt;d=
ev.of_node,<br>
@@ -328,7 +328,7 @@ static int rockchip_pwm_probe(struct platform_device *p=
dev)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D clk_prepare_enable(pc-&gt;clk);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&=
gt;dev, &quot;Can&#39;t prepare enable bus clk: %d\n&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&=
gt;dev, &quot;Can&#39;t prepare enable PWM clk: %d\n&quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
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

--000000000000800ad905b744a876--
