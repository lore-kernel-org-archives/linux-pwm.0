From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 13/15] pwm: rockchip: add support for atomic update
Date: Thu, 2 Jul 2015 09:43:19 +0200
Message-ID: <20150702094319.11794da8@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<1435738921-25027-14-git-send-email-boris.brezillon@free-electrons.com>
	<1709826.dVqTms8REP@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1709826.dVqTms8REP@diego>
Sender: linux-leds-owner@vger.kernel.org
To: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bryan Wu <cooloney@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Doug Anderson <dianders@google.com>, Mark Brown <broonie@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jingoohan1@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Heiko,

On Wed, 01 Jul 2015 23:48:31 +0200
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> Hi Boris,
>=20
>=20
> Am Mittwoch, 1. Juli 2015, 10:21:59 schrieb Boris Brezillon:
> > Implement the ->apply() function to add support for atomic update.
> >=20
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> > @@ -110,6 +113,26 @@ static void rockchip_pwm_set_enable_v2(struct =
pwm_chip
> > *chip, writel_relaxed(val, pc->base + pc->data->regs.ctrl);
> >  }
> >=20
> > +static void rockchip_pwm_init_v2(struct pwm_chip *chip, struct pwm=
_device
> > *pwm) +{
> > +	struct rockchip_pwm_chip *pc =3D to_rockchip_pwm_chip(chip);
> > +	u32 enable_conf =3D PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE=
 |
> > +			  PWM_CONTINUOUS;
> > +	u32 val;
> > +
> > +	val =3D readl(pc->base + pc->data->regs.ctrl);
> > +
> > +	if ((val & enable_conf) !=3D enable_conf)
> > +		return;
> > +
> > +	pwm->state.enabled =3D true;
> > +
> > +	enable_conf =3D PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
> > +
> > +	if ((val & enable_conf) =3D=3D enable_conf)
> > +		pwm->state.polarity =3D PWM_POLARITY_INVERSED;
>=20
> the inactive setting does not affect the polarity of the running pwm,=
 only what=20
> to do when it gets turned off. Also PWM_DUTY_NEGATIVE is the "0" valu=
e for the=20
> bit so also is bad to compare against (and results in wrong readings)=
=2E So I=20
> would suggest changing this like

Indeed

>=20
> -       enable_conf =3D PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
> +       enable_conf =3D PWM_DUTY_POSITIVE;
> =20
> -       if ((val & enable_conf) =3D=3D enable_conf)
> +       if ((val & enable_conf) !=3D enable_conf)

Or just:

	if(val & PWM_DUTY_POSITIVE)


Thanks for the fix.

Best Regards,

Boris

--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
