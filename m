From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/4] ARM: S3C24XX: rx1950: make use of atomic PWM API
Date: Thu, 15 Nov 2018 17:15:16 +0100
Message-ID: <20181115161516.GC8611@ulmo>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
 <20181114120814.GD2620@ulmo>
 <20181115085808.ihg4of72forhulzc@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5381565430339417435=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181115085808.ihg4of72forhulzc@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============5381565430339417435==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 09:58:08AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Nov 14, 2018 at 01:08:14PM +0100, Thierry Reding wrote:
> > On Fri, Oct 26, 2018 at 08:41:56PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > +static struct pwm_state lcd_pwm_state;
> >=20
> > You shouldn't need this. The whole point of the atomic API is that the
> > PWM carries its state, so the proper way to make a change is to query
> > the current state, make any required modifications and then apply the
> > new state.
>=20
> I thought the whole point of the atomic API is to be atomic :-)
>=20
> > >  static struct pwm_device *lcd_pwm;
> > > =20
> > >  static void rx1950_lcd_power(int enable)
> > > @@ -428,15 +429,17 @@ static void rx1950_lcd_power(int enable)
> > > =20
> > >  		/* GPB1->OUTPUT, GPB1->0 */
> > >  		gpio_direction_output(S3C2410_GPB(1), 0);
> > > -		pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
> > > -		pwm_disable(lcd_pwm);
> > > +		lcd_pwm_state.duty_cycle =3D 0;
> > > +		lcd_pwm_state.enabled =3D false;
> > > +		pwm_apply_state(lcd_pwm, &lcd_pwm_state);
> >=20
> > The correct way to do this would be:
> >=20
> > 	struct pwm_state state;
> >=20
> > 	pwm_get_state(lcd_pwm, &state);
> > 	state.enabled =3D false;
> > 	state.duty_cycle =3D 0;
> > 	pwm_apply_state(lcd_pwm, &state);
>=20
> The difference here is that with my approach the rx1950 driver caches
> the intended pwm_state saving a few cycles for repeatedly copying the
> pwm cache to a stack variable at the cost of some memory. I like my
> approach a little better but I'm not willing to argue about that one and
> can give in.

It's a redundant copy of the PWM's internal state and not guaranteed to
remain in sync with the PWM hardware state. You also require a global
variable, which is usually a bad idea. And we're not repeatedly copying
data. We occasionally do. These operations are typically only executed
once or twice per boot, so hardly anything that needs to be optimized
for speed.

> > >  		gpio_direction_output(S3C2410_GPC(0), 1);
> > >  		gpio_direction_output(S3C2410_GPC(5), 1);
> > > @@ -491,11 +494,8 @@ static int rx1950_backlight_init(struct device *=
dev)
> > >  		return PTR_ERR(lcd_pwm);
> > >  	}
> > > =20
> > > -	/*
> > > -	 * FIXME: pwm_apply_args() should be removed when switching to
> > > -	 * the atomic PWM API.
> > > -	 */
> > > -	pwm_apply_args(lcd_pwm);
> > > +	pwm_get_state_default(lcd_pwm, &lcd_pwm_state);
> > > +	lcd_pwm_state.period =3D LCD_PWM_PERIOD;
> >=20
> > This is wrong, though it's probably because the comment is also
> > confusing. There should be nothing wrong with using pwm_apply_args() in
> > this case.
>=20
> In my eyes it is wrong because it results in a call to the backend
> driver's apply callback to get the default setting just to fix the
> configuration and apply that in the code to follow.

Okay, I see. But there's already pwm_init_state() which pretty much does
what you do here, right?

Thinking about it some more, I wonder if we shouldn't be more consistent
about state handling here. So the reason why pwm_apply_args() exists is
to program the PWM with a known state if the PWM doesn't support
hardware readout. Since most drivers don't support hardware readout, we
need this to at some specific point synchronize the hardware and
internal states.

In retrospect I'm not sure that's necessary, because there's more and
more evidence that we don't want to touch a PWM configuration until a
consumer explicitly says so. There's also the slight problem that the
pwm_apply_args() is really only necessary if the PWM driver doesn't
support hardware readout, but that's not something that consumers are
aware of or should worry about.

In light of that I think perhaps a better solution would be to basically
apply the PWM arguments to the internal state at request time. We can't
do it earlier because we don't know the arguments before the PWM is
requested. So I think at request time we could do something like this:

	if (chip->ops->get_state)
		chip->ops->get_state(chip, pwm, &pwm->state);
	else
		pwm_init_state(pwm, &pwm->state);

That way drivers always get either the current state or the "default"
state that was configured via platform-specific means (DT or lookup).

> > While at it, I think the conversion should also be include replacing the
> > call to pwm_request() by pwm_get(). There's already a PWM lookup table
> > in the RX1950 board code, so pwm_get() would be able to use that. Note
> > that for some reason that table contains a period that is different from
> > LCD_PWM_PERIOD, so I think that should also be addressed. Basically all
> > the information other than duty cycle should be coming from either DT or
> > a lookup table.
>=20
> Yeah, I noticed that, too. It's not entirely clear to me how to do that
> yet. So I thought to care about getting rid of the legacy usage of
> pwm_config and pwm_apply_args first.

So I think I got the backlight PWM confused with the LCD PWM. The former
is what we have in the PWM lookup table and which controls the backlight
brightness. The latter is what we don't have in the table and which is
requested using the legacy pwm_request() function. That also explains
why there's a difference between the period in the PWM lookup table for
the backlight PWM and the LCD_PWM_PERIOD macro.

Adding support for pwm_get() should be as simple ad adding an entry to
rx1950_pwm_lookup[], such as this:

	PWM_LOOKUP("samsung-pwm", 1, "pwm-backlight.0", "lcd", 192960,
		   PWM_POLARITY_NORMAL),

Then in rx1950_backlight_init(), which is passed the device structure
that represents the backlight (i.e. "pwm-backlight.0"), pwm_get() can
be called like this:

	lcd_pwm =3D pwm_get(dev, "lcd");

The matching code should then be able to find the second entry as the
best match and return the correct one.

Thierry

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvtm5IACgkQ3SOs138+
s6H1pw/9G7CieTdIsiTWaGiGwG6OpXKZqCTg+7NRxUTi90dvfgnlw2qOOYoSrINK
bqypc9RFJjq/SqGHv8SXqGzUeoyO1El+UCjC+m60OCZVSSAYs865F6W/U9Jl5+fX
wEY2XoSe0vLmf+BwGw/cUT3kv4BBDz5HRVllO0MzsaiGZGqE6e9qyktphY1/hs2f
NJXBCEHQ/2X2Hft9/JO4wcHqRnuC/eWZru4CRlm7r1gtZLH7LkxWTMNA1pXWn5Xd
AKbfyjS3LKZEdn7R/UOuA8fWFhJcnLeIl2P0hAtPf2RkbJLj0lxmPhoNkLmBAfgu
KCljYysVqoT6brRGOMDXV0RwN6sfdqeVbyx8fH5XZcLglsLcHa4JJIV2ZCSy1el/
UqeLv1cOGAs0kLdSTgHg/YfLGUTOlfKeFYw1ZstkJu/4cleRX+QFyUbiowj3b1fQ
sfrh7kVa5xSRkKsdunf5/d7ek3uvrw3OPKZRviDTFgNFNQvpqOU9LOWRwIv4uvCD
mEyrucfg+3C8l/mj45FuT7TFtoLRW9htNdO/Kew45wHsxxNUs7YOu65hLO0AsxBR
fsQTPJo/KMyJE9pwTMQYGS9J/cLJl1ObXZ5aiOppSumQki3ADMhS2UoMW0Yx47B/
B1qPdNYprwaCiqj3YD94KqOIf9FVvqeQ35mb4ETH7GhclVeElVw=
=qRmh
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--


--===============5381565430339417435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5381565430339417435==--
