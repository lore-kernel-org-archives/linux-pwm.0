From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
Subject: Re: [PATCH 5/6] pwm: sun4i: Add support to output
 source clock directly
Date: Mon, 29 Jul 2019 18:16:55 +0200
Message-ID: <2499807.IN78SsLMYo@jernej-laptop>
References: <20190726184045.14669-1-jernej.skrabec@siol.net> <20190726184045.14669-6-jernej.skrabec@siol.net> <20190729070605.vlu7kgzn362ph2q3@pengutronix.de>
Reply-To: jernej.skrabec-gGgVlfcn5nU@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDQNBWPU7YERB6VX7TUQKGQEG4CNJOA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190729070605.vlu7kgzn362ph2q3-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

Dne ponedeljek, 29. julij 2019 ob 09:06:05 CEST je Uwe Kleine-K=C3=B6nig=20
napisal(a):
> On Fri, Jul 26, 2019 at 08:40:44PM +0200, Jernej Skrabec wrote:
> > PWM core has an option to bypass whole logic and output unchanged sourc=
e
> > clock as PWM output. This is achieved by enabling bypass bit.
> >=20
> > Note that when bypass is enabled, no other setting has any meaning, not
> > even enable bit.
> >=20
> > This mode of operation is needed to achieve high enough frequency to
> > serve as clock source for AC200 chip, which is integrated into same
> > package as H6 SoC.
> >=20
> > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> > ---
> >=20
> >  drivers/pwm/pwm-sun4i.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 9e0eca79ff88..848cff26f385 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -120,6 +120,19 @@ static void sun4i_pwm_get_state(struct pwm_chip
> > *chip,
> >=20
> >  	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> >=20
> > +	/*
> > +	 * PWM chapter in H6 manual has a diagram which explains that if=20
bypass
> > +	 * bit is set, no other setting has any meaning. Even more,=20
experiment
> > +	 * proved that also enable bit is ignored in this case.
> > +	 */
> > +	if (val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) {
> > +		state->period =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,=20
clk_rate);
> > +		state->duty_cycle =3D state->period / 2;
> > +		state->polarity =3D PWM_POLARITY_NORMAL;
> > +		state->enabled =3D true;
> > +		return;
> > +	}
> > +
> >=20
> >  	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK) &&
> >  =09
> >  	    sun4i_pwm->data->has_prescaler_bypass)
> >  	=09
> >  		prescaler =3D 1;
> >=20
> > @@ -211,7 +224,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,
> > struct pwm_device *pwm,>=20
> >  {
> > =20
> >  	struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
> >  	struct pwm_state cstate;
> >=20
> > -	u32 ctrl;
> > +	u32 ctrl, clk_rate;
> > +	bool bypass;
> >=20
> >  	int ret;
> >  	unsigned int delay_us;
> >  	unsigned long now;
> >=20
> > @@ -226,6 +240,16 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,
> > struct pwm_device *pwm,>=20
> >  		}
> >  =09
> >  	}
> >=20
> > +	/*
> > +	 * Although it would make much more sense to check for bypass in
> > +	 * sun4i_pwm_calculate(), value of bypass bit also depends on=20
"enabled".
> > +	 * Period is allowed to be rounded up or down.
> > +	 */
>=20
> Every driver seems to implement rounding the way its driver considers it
> sensible. @Thierry: This is another patch where it would be good to have
> a global directive about how rounding is supposed to work to provide the
> users an reliable and uniform way to work with PWMs.
>=20
> > +	clk_rate =3D clk_get_rate(sun4i_pwm->clk);
> > +	bypass =3D (state->period =3D=3D NSEC_PER_SEC / clk_rate ||
> > +		 state->period =3D=3D DIV_ROUND_UP(NSEC_PER_SEC, clk_rate))=20
&&
> > +		 state->enabled;
>=20
> Not sure if the compiler is clever enough to notice the obvious
> optimisation with this code construct, but you can write this test in a
> more clever way which has zero instead of up to two divisions. Something
> like:
>=20
> bypass =3D ((state->period * clk_rate >=3D NSEC_PER_SEC &&
> 	   state->period * clk_rate < NSEC_PER_SEC + clk_rate) &&
> 	  state->enabled);
>=20
> In the commit log you write the motivation for using bypass is that it
> allows to implement higher frequency then with the "normal" operation.
> As you don't skip calculating the normal parameters requesting such a
> high-frequency setting either errors out or doesn't catch the impossible
> request. In both cases there is something to fix.

It's the latter, otherwise it wouldn't work for my case. I'll fix the check=
 and=20
skip additional logic.

>=20
> > +
> >=20
> >  	spin_lock(&sun4i_pwm->ctrl_lock);
> >  	ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> >=20
> > @@ -273,6 +297,11 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,
> > struct pwm_device *pwm,>=20
> >  		ctrl &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> >  =09
> >  	}
> >=20
> > +	if (bypass)
> > +		ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > +	else
> > +		ctrl &=3D ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > +
>=20
> Does switching on (or off) the bypass bit complete the currently running
> period?

I don't really know. If I understand correctly, it just bypasses PWM logic=
=20
completely, so I would say it doesn't complete the currently running period=
.

Take a look at chapter 3.9.2 http://linux-sunxi.org/
File:Allwinner_H6_V200_User_Manual_V1.1.pdf

Best regards,
Jernej

>=20
> >  	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
> >  =09
> >  	spin_unlock(&sun4i_pwm->ctrl_lock);
>=20
> Best regards
> Uwe




--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/2499807.IN78SsLMYo%40jernej-laptop.
