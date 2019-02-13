From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Wed, 13 Feb 2019 13:39:02 +0100
Message-ID: <20190213123902.GF647@ulmo>
References: <1550049978-20705-1-git-send-email-yash.shah@sifive.com>
 <1550049978-20705-3-git-send-email-yash.shah@sifive.com>
 <20190213103459.t5bvemxrb2x6iagm@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="27ZtN5FSuKKSZcBU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190213103459.t5bvemxrb2x6iagm@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yash Shah <yash.shah@sifive.com>, palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 11:34:59AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Feb 13, 2019 at 02:56:18PM +0530, Yash Shah wrote:
[...]
> > +	unsigned long scale_pow =3D
> > +			div64_ul(pwm->real_period * (u64)rate, NSEC_PER_SEC);
> > +	int scale =3D clamp(ilog2(scale_pow) - PWM_SIFIVE_CMPWIDTH, 0, 0xf);
> > +
> > +	writel((1 << PWM_SIFIVE_PWMCFG_EN_ALWAYS) | (scale <<
> > +	       PWM_SIFIVE_PWMCFG_SCALE), pwm->regs + PWM_SIFIVE_PWMCFG);
>=20
> I think this would be better readable with the newline after the |. With
> my editor's configuration when broken like this, the 2nd line would be
> intended with the opening ( after the |.
>=20
> > +
> > +	/* As scale <=3D 15 the shift operation cannot overflow. */
> > +	pwm->real_period =3D div64_ul(1000000000ULL << (PWM_SIFIVE_CMPWIDTH +
> > +				    scale), rate);
>=20
> ditto. Maybe break after the =3D?
>=20
> > +	dev_dbg(pwm->chip.dev, "New real_period =3D %u ns\n", pwm->real_perio=
d);
> > +}
> > +
> > +static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *dev,
> > +				 struct pwm_state *state)
> > +{
> > +	struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> > +	u32 duty;
> > +	int val;
> > +
> > +	duty =3D readl(pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm *
> > +		     PWM_SIFIVE_SIZE_PWMCMP);
> > +
> > +	val =3D readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> > +	state->enabled =3D (val & BIT(PWM_SIFIVE_PWMCFG_EN_ALWAYS)) > 0;
> > +
> > +	val &=3D 0x0F;
> > +	pwm->real_period =3D div64_ul(1000000000ULL << (PWM_SIFIVE_CMPWIDTH +
> > +				    val), clk_get_rate(pwm->clk));
>=20
> Another bad line break.

Maybe just split all of these very long expressions up by introducing
temporary variables to make things more palatable?

Thierry

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxkD+YACgkQ3SOs138+
s6E7jQ//UQwS8ncrUfiucp+4IA2Ttqa0MkZBKpHZFYd5NABgdUdAFrxiUkNHRx3k
Ziz1Og6o1xAcdhlQwFsirpvgkSuB27t0UPwVEfjhOtE2nsp4NlMrulqzLhhTMRqm
dJOXUdnz5DlnmXAvTVLEqwM0oVdcotD7flgqcSbJ5/C9Xj3GVnybLsYvluNrfkgD
FOO6uXAl84hwzk8eoPMVZ4xyT4M08FVyxUG4S4abayZ+ZO7qGuMCFByebbfk3qXI
9Wp/5TgEfndb5vYv0BGHwRLjTtjm7zk5x/cAQgd+i9vB3dQRTekdPg87XiY3gq2j
+Do5Otmno1yBowJ2Q5HTatN+o246BEgbaUjyqS/ZxSK5T8ei2HKZgR2fv6DQqPYy
etOx8wOfVOxgF7allr4E5hAnKhUlfV1nXE+K15vXNVeE8vTggpdQa8y8cj0Qvx2g
xfEFBlf92sEQ1uSQEvPoEBLRLKNK1N4ZlscIhKz84vrMfeN+l5vchJ9j6jCqq29l
Qi6xTgCb49tBLdhjO7Od7evIY6E7tPzax1YAg1oeNjNGm0q5xEmXH85mSILeeCO3
jdfOyaEIGGDziBcJ6xVROejOHowX+09hJQDFyK/xUQ8/U4rppxSs/cuhPAXCFRQG
/Axaqlt3wF1V1Oj0ZEwDc27VQT3I31heLxz4cyeLjCjJknUi0zU=
=VfjV
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--
