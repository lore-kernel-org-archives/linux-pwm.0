Return-path: <alex.mobigo@gmail.com>
MIME-Version: 1.0
References: <20200109233106.17060-1-peron.clem@gmail.com>
In-Reply-To: <20200109233106.17060-1-peron.clem@gmail.com>
From: Alexander <alex.mobigo@gmail.com>
Date: Sun, 12 Jan 2020 21:37:15 -0300
Message-ID: <CAGfOxi0pAYO7VorX6gT7scrYfLTh9V7-TkJXriD8Fp+EY3rPcw@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f727a9059bfaad38"
Subject: Re: [PATCH] [RFC] pwm: sun4i: Move pwm_calculate out of spin_lock
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vasily Khoruzhick <anarsoul@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>

--000000000000f727a9059bfaad38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2020 at 8:31 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.co=
m> wrote:
>
> pwm_calculate calls clk_get_rate while holding a spin_lock.
>
> This create an issue as clk_get_rate() may sleep.
>
> Move pwm_calculate out of this spin_lock.
>
> Fixes: c32c5c50d4fe ("pwm: sun4i: Switch to atomic PWM")
> Reported-by: Alex Mobigo <alex.mobigo@gmail.com>
> Suggested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>
> Hi,
>
> this issue has been reported on linux-sunxi Google groups.
>
> I don't have a board with PWM to confirm it.
>
> Please wait a tested-by.
>
> Thanks,
> Cl=C3=A9ment
>
>  drivers/pwm/pwm-sun4i.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 1afd41ebd3fd..6b230029dc49 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -248,19 +248,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,
struct pwm_device *pwm,
>                 }
>         }
>
> -       spin_lock(&sun4i_pwm->ctrl_lock);
> -       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> -
>         ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period,
&prescaler,
>                                   &bypass);
>         if (ret) {
>                 dev_err(chip->dev, "period exceeds the maximum value\n");
> -               spin_unlock(&sun4i_pwm->ctrl_lock);
>                 if (!cstate.enabled)
>                         clk_disable_unprepare(sun4i_pwm->clk);
>                 return ret;
>         }
>
> +       spin_lock(&sun4i_pwm->ctrl_lock);
> +       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> +
>         if (sun4i_pwm->data->has_direct_mod_clk_output) {
>                 if (bypass) {
>                         ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> --
> 2.20.1
"""""""""""""""""
Tested on my board Pine64+, problems occurs before the patch but not
after...

Tested-By: Alexander Finger <alex.mobigo@gmail.com>
"""""""""""""""

--000000000000f727a9059bfaad38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, Jan 9, 2020 at 8:31 PM Cl=C3=A9ment P=C3=
=A9ron &lt;<a href=3D"mailto:peron.clem@gmail.com">peron.clem@gmail.com</a>=
&gt; wrote:<br>&gt;<br>&gt; pwm_calculate calls clk_get_rate while holding =
a spin_lock.<br>&gt;<br>&gt; This create an issue as clk_get_rate() may sle=
ep.<br>&gt;<br>&gt; Move pwm_calculate out of this spin_lock.<br>&gt;<br>&g=
t; Fixes: c32c5c50d4fe (&quot;pwm: sun4i: Switch to atomic PWM&quot;)<br>&g=
t; Reported-by: Alex Mobigo &lt;<a href=3D"mailto:alex.mobigo@gmail.com">al=
ex.mobigo@gmail.com</a>&gt;<br>&gt; Suggested-by: Vasily Khoruzhick &lt;<a =
href=3D"mailto:anarsoul@gmail.com">anarsoul@gmail.com</a>&gt;<br>&gt; Signe=
d-off-by: Cl=C3=A9ment P=C3=A9ron &lt;<a href=3D"mailto:peron.clem@gmail.co=
m">peron.clem@gmail.com</a>&gt;<br>&gt; ---<br>&gt;<br>&gt; Hi,<br>&gt;<br>=
&gt; this issue has been reported on linux-sunxi Google groups.<br>&gt;<br>=
&gt; I don&#39;t have a board with PWM to confirm it.<br>&gt;<br>&gt; Pleas=
e wait a tested-by.<br>&gt;<br>&gt; Thanks,<br>&gt; Cl=C3=A9ment<br>&gt;<br=
>&gt; =C2=A0drivers/pwm/pwm-sun4i.c | 7 +++----<br>&gt; =C2=A01 file change=
d, 3 insertions(+), 4 deletions(-)<br>&gt;<br>&gt; diff --git a/drivers/pwm=
/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c<br>&gt; index 1afd41ebd3fd..6b230029=
dc49 100644<br>&gt; --- a/drivers/pwm/pwm-sun4i.c<br>&gt; +++ b/drivers/pwm=
/pwm-sun4i.c<br>&gt; @@ -248,19 +248,18 @@ static int sun4i_pwm_apply(struc=
t pwm_chip *chip, struct pwm_device *pwm,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=
&gt;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 spin_lock(&amp;sun4i_pwm-&gt;ctrl_lock)=
;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CT=
RL_REG);<br>&gt; -<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D sun4i_pwm_ca=
lculate(sun4i_pwm, state, &amp;duty, &amp;period, &amp;prescaler,<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;bypass);<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (ret) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 dev_err(chip-&gt;dev, &quot;period exceeds the maximum=
 value\n&quot;);<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 spin_unlock(&amp;sun4i_pwm-&gt;ctrl_lock);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cstate.enabled)<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c=
lk_disable_unprepare(sun4i_pwm-&gt;clk);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }<br>&gt;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 spin_lock(&amp;sun4i_pwm-&g=
t;ctrl_lock);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 ctrl =3D sun4i_pwm_readl(sun4i=
_pwm, PWM_CTRL_REG);<br>&gt; +<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sun4=
i_pwm-&gt;data-&gt;has_direct_mod_clk_output) {<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bypass) {<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctrl =
|=3D BIT_CH(PWM_BYPASS, pwm-&gt;hwpwm);<br>&gt; --<br>&gt; 2.20.1<br>&quot;=
&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&qu=
ot;&quot;&quot;&quot;<br>Tested on my board Pine64+, problems occurs before=
 the patch but not after...<br><br>Tested-By: Alexander Finger &lt;<a href=
=3D"mailto:alex.mobigo@gmail.com">alex.mobigo@gmail.com</a>&gt;<br>&quot;&q=
uot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot;&quot=
;&quot;</div>

--000000000000f727a9059bfaad38--
