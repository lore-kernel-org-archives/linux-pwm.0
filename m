Return-path: <tpgalchenko@gmail.com>
MIME-Version: 1.0
References: <20201216174309.1604658-1-thierry.reding@gmail.com>
In-Reply-To: <20201216174309.1604658-1-thierry.reding@gmail.com>
From: Taras Galchenko <tpgalchenko@gmail.com>
Date: Thu, 17 Dec 2020 10:46:53 +0300
Message-ID: <CADO=Lw57JwaY1gjaBOLtPiBQAXhr38AZGB=GLCMhjMp0PsYGHA@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a6ad2505b6a4329f"
Subject: Re: [PATCH] pwm: sun4i: Remove erroneous else branch
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>

--000000000000a6ad2505b6a4329f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Taras Galchenko <tpgalchenko@gmail.com>

=D1=81=D1=80, 16 =D0=B4=D0=B5=D0=BA. 2020 =D0=B3. =D0=B2 20:43, Thierry Red=
ing <thierry.reding@gmail.com>:

> Commit d3817a647059 ("pwm: sun4i: Remove redundant needs_delay") changed
> the logic of an else branch so that the PWM_EN and PWM_CLK_GATING bits
> are now cleared if the PWM is to be disabled, whereas previously the
> condition was always false, and hence the branch never got executed.
>
> This code is reported causing backlight issues on boards based on the
> Allwinner A20 SoC. Fix this by removing the else branch, which restores
> the behaviour prior to the offending commit.
>
> Note that the PWM_EN and PWM_CLK_GATING bits still get cleared later in
> sun4i_pwm_apply() if the PWM is to be disabled.
>
> Fixes: d3817a647059 ("pwm: sun4i: Remove redundant needs_delay")
> Reported-by: Taras Galchenko <tpgalchenko@gmail.com>
> Suggested-by: Taras Galchenko <tpgalchenko@gmail.com>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index cc1eb0818648..ce5c4fc8da6f 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -294,12 +294,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,
> struct pwm_device *pwm,
>
>         ctrl |=3D BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
>
> -       if (state->enabled) {
> +       if (state->enabled)
>                 ctrl |=3D BIT_CH(PWM_EN, pwm->hwpwm);
> -       } else {
> -               ctrl &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> -               ctrl &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> -       }
>
>         sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
>
> --
> 2.29.2
>
>

--000000000000a6ad2505b6a4329f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div>
Tested-by: Taras Galchenko &lt;<a href=3D"mailto:tpgalchenko@gmail.com">tpg=
alchenko@gmail.com</a>&gt;</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 16 =D0=B4=D0=B5=D0=BA. 2020 =
=D0=B3. =D0=B2 20:43, Thierry Reding &lt;<a href=3D"mailto:thierry.reding@g=
mail.com">thierry.reding@gmail.com</a>&gt;:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Commit d3817a647059 (&quot;pwm: sun4i: Remove r=
edundant needs_delay&quot;) changed<br>
the logic of an else branch so that the PWM_EN and PWM_CLK_GATING bits<br>
are now cleared if the PWM is to be disabled, whereas previously the<br>
condition was always false, and hence the branch never got executed.<br>
<br>
This code is reported causing backlight issues on boards based on the<br>
Allwinner A20 SoC. Fix this by removing the else branch, which restores<br>
the behaviour prior to the offending commit.<br>
<br>
Note that the PWM_EN and PWM_CLK_GATING bits still get cleared later in<br>
sun4i_pwm_apply() if the PWM is to be disabled.<br>
<br>
Fixes: d3817a647059 (&quot;pwm: sun4i: Remove redundant needs_delay&quot;)<=
br>
Reported-by: Taras Galchenko &lt;<a href=3D"mailto:tpgalchenko@gmail.com" t=
arget=3D"_blank">tpgalchenko@gmail.com</a>&gt;<br>
Suggested-by: Taras Galchenko &lt;<a href=3D"mailto:tpgalchenko@gmail.com" =
target=3D"_blank">tpgalchenko@gmail.com</a>&gt;<br>
Signed-off-by: Thierry Reding &lt;<a href=3D"mailto:thierry.reding@gmail.co=
m" target=3D"_blank">thierry.reding@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/pwm/pwm-sun4i.c | 6 +-----<br>
=C2=A01 file changed, 1 insertion(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c<br>
index cc1eb0818648..ce5c4fc8da6f 100644<br>
--- a/drivers/pwm/pwm-sun4i.c<br>
+++ b/drivers/pwm/pwm-sun4i.c<br>
@@ -294,12 +294,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctrl |=3D BIT_CH(PWM_CLK_GATING, pwm-&gt;hwpwm)=
;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (state-&gt;enabled) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (state-&gt;enabled)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctrl |=3D BIT_CH(PW=
M_EN, pwm-&gt;hwpwm);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctrl &amp;=3D ~BIT_=
CH(PWM_EN, pwm-&gt;hwpwm);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctrl &amp;=3D ~BIT_=
CH(PWM_CLK_GATING, pwm-&gt;hwpwm);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG)=
;<br>
<br>
-- <br>
2.29.2<br>
<br>
</blockquote></div>

--000000000000a6ad2505b6a4329f--
