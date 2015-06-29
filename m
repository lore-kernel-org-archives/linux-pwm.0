From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 2/2] pwm: Add support for R-Car PWM Timer
Date: Mon, 29 Jun 2015 11:12:16 +0200
Message-ID: <20150629091215.GE5431@ulmo>
References: <1432205846-4312-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1432205846-4312-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20150612120600.GM19400@ulmo.nvidia.com>
 <SG2PR06MB09195A961FECE276F001493AD8B80@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SG2PR06MB09195A961FECE276F001493AD8B80@SG2PR06MB0919.apcprd06.prod.outlook.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2015 at 05:48:00AM +0000, Yoshihiro Shimoda wrote:
[...]
> > > +static void rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div,
> > > +				 int duty_ns, int period_ns)
> > > +{
> > > +	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */
> > > +	unsigned long clk_rate =3D clk_get_rate(rp->clk);
> > > +	u32 cyc, ph;
> > > +
> > > +	one_cycle =3D (unsigned long long)NSEC_PER_SEC * 100ULL * (1 << div=
);
> > > +	do_div(one_cycle, clk_rate);
> > > +
> > > +	tmp =3D period_ns * 100ULL;
> > > +	do_div(tmp, one_cycle);
> > > +	cyc =3D (tmp << RCAR_PWMCNT_CYC0_SHIFT) & RCAR_PWMCNT_CYC0_MASK;
> > > +
> > > +	tmp =3D duty_ns * 100ULL;
> > > +	do_div(tmp, one_cycle);
> > > +	ph =3D tmp & RCAR_PWMCNT_PH0_MASK;
> > > +
> > > +	/* Avoid prohibited setting */
> > > +	if (cyc && ph)
> > > +		rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
> >=20
> > So if a period and duty-cycle are passed in that yield the prohibited
> > setting the operation will simply be silently ignored?
>=20
> Yes, to update values of pwm->duty_cycle and ->period by pwm_config(),
> this code will be silently ignored.

That's not right. If someone passes in invalid values you should report
an error.

Also, are you sure the check is correct? The current check:

	if (cyc && ph)

is the same as

	if (cyc !=3D 0 && ph !=3D 0)

which means that you will never be able to set a zero duty cycle. Is
that really what you want here?

Thierry

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVkQvsAAoJEN0jrNd/PrOhpQwP/RMu1TPTDhRN301ey5/lSLnX
sJfl4txBUkbZxhuOr7JZagitPMbMot8HabKqbjjDOF+CZvH7osJHitUrTUHch6v8
NoE4jQGMcytsT8pwpbJGyLttneS01WOJaW0cIhpUdhgclA5cp1HhN1pHs24oA8b3
KUzwwvOd1zL8OqGgmr9f6pjHGkvvI4eZj8K7kFc2bYJ7lTIBQ9FhsvNOZwXmK9VI
VkJ7pQ0r7aLYEyaubUDW7IciWDwYV+0+fcTrUsQdRMCG7jxhxkbWc9CBNxmzIcdM
86i/gbJ4/IhPOpyJAGQVIkWySk17Q3Z7RhQa/8WMmBjiNzmZoPj9WPz505w4Maqs
43W5x1hNtcdUrCMVuN3IP2Q7TSsEwS1F7VQS9/YE8MsZULgS0/u1G5u2hcjDB2OQ
hb1qEnt2DFuFFWIQ90egu7oD2htJwL1k86tTA848saqxw4Mv4JkfkwongLnM1aKM
89fgvS2gia9TWpE1BsZ0bGssmGoLTtLi717BD/oQhM1IyDgqy1q1CqzV2ZL1yiLw
Wq63ldbrpCxNzwawNxgr/tihkkEK/ocpaSg3Ob2dBPg/zaRYmz5Ce5URgf4AWY5b
PktPdfOY3j7rVhfrvZ+mgfl9d7J9A9i9vy/WguxLbpXG5rowohodGkC8oqNf1g7L
6YfovRNfna3vRxJ/D+ru
=Gq/Z
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
