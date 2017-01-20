From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: pca9685: fix prescaler initialization
Date: Fri, 20 Jan 2017 07:39:07 +0100
Message-ID: <20170120063907.GA4894@ulmo.ba.sec>
References: <20161213155251.28684-2-clemens.gruber@pqgruber.com>
 <20170118105735.GM18989@ulmo.ba.sec>
 <1484737764.2133.193.camel@linux.intel.com>
 <20170118135325.GA2498@archie.localdomain>
 <1484748118.2133.206.camel@linux.intel.com>
 <20170118142533.GA17640@archie.localdomain>
 <1484829279.2133.236.camel@linux.intel.com>
 <20170119144925.GA1660@archie.localdomain>
 <1484842208.2133.245.camel@linux.intel.com>
 <20170119165210.GA2139@archie.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170119165210.GA2139@archie.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 05:52:10PM +0100, Clemens Gruber wrote:
> On Thu, Jan 19, 2017 at 06:10:08PM +0200, Andy Shevchenko wrote:
> > Combining with your proposal I would see the best approach is to set
> > pca->period_ns accordingly to current prescaler value if you want to.
>=20
> Yes, I agree.
>=20
> > In your patch I see no benefit, since it's quite unlikely user will want
> > to have 5ms period among all possibilities.
>=20
> It is the hardware default, but you are right, the user probably does
> not care about that.
>=20
> > So, summarize, I prefer (in order of preference from high to low):
> > - enforce default prescaler value based on default period (it's just one
> > line to write a register)
> > - calculate default period based on actual prescaler value
>=20
> Let's go with this one. I'll spin up a v2 where I calculate the
> period_ns value from the current prescaler value in the probe function.

This effectively ends up duplicating much of what the atomic API is
supposed to be doing.

So generally before the atomic API there is no way for the PWM driver
(and consequently the PWM users) to know what the current setting is.
That implies that we either can't care about the settings that were
programmed by some bootloader or that we force the PWM to a setting
on ->probe().

The result is inconsistent behaviour across drivers, and that's just
fine for many cases. But for some cases it is really not something that
we can work with.

So perhaps another possibility would be for this driver to implement the
atomic API. This should give you the necessary infrastructure to do
exactly what you want.

> Thierry: I think you could merge v1 of patch 1/2 from my series
> independently.

Okay, will do.

> I'll send v2 of patch 2/2 with aforementioned changes in the next
> days.

Like I said above, I think atomic API conversion wouldn't be very
difficult for this driver and it has the added advantage of giving you
the proper infrastructure to do this rather than having to duplicate
it in the driver.

That would be my preference, but I'm willing to take v2 of 2/2 as well
if it ends up being really nice and compact. =3D)

Thierry

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliBsIgACgkQ3SOs138+
s6HLzxAAstQIbCtVOULUvga/eT5LdWY6/Prll2SrtKCx99wsSu/5bh0mE7QcZ6LU
nbr/QJABS4FbYMNuRJNUZVNr/Yi0sGcWsrDRrdLw0YuYA1pdZebPRAMMjmGNme+v
XWiKK+3AxHbD26isAf/RNsP8DorRY568vCwxEwuCbiiyc92dPpUL711AWZZjM7x0
/QhST6qjbfdCOS8u6csAeK27tAEku02J1qPqJVQAq6X4eYUHgJxbkwaFuOlTyR13
6H8+GP2LSkTXt6299+z3mf6LtSG++QvLOH9IurNQvynE/Pu/k6ZfNBmCpjKs1JN5
WitUNVt34Q9wRhzoY64UXj679eeOoK/rJdQKeSvewRdxqKFZZ5aLgAhBET1A3tx6
KBYedJu7vXN+D76zO898FAt+w2yqnaGZEeIILUJQfBu4ok0DpF/34EwunL2OwvX5
Sk45WXsnEwbBAumrmjrmXQNCYql6Km5aksbmg65qc7X9n2fi6fJjgCoO3qLDsiIW
/Cu/qqljSXKMrop911Jk6wCHkyipJm0iVkeVUbByGunoH5UifEQztQjQOtkBO4s1
zKcWuI5zToZ4Xdmfl+NdFIb/5m0DlBTauS+5AA0q1DWFPhHZwDzK8XsoADQryfED
IV0rLwpv0WNURPzOMK5k1cl2fcwT+3COEv+SSOzRg/sua5YXjW0=
=lJlu
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
