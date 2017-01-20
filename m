From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 4/4] pwm: lpss: Switch to new atomic API
Date: Fri, 20 Jan 2017 11:48:27 +0100
Message-ID: <20170120104827.GI3824@ulmo.ba.sec>
References: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
 <20170102091647.86910-5-andriy.shevchenko@linux.intel.com>
 <20170118111518.GP18989@ulmo.ba.sec>
 <1484836366.2133.243.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36809 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbdATKsb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Jan 2017 05:48:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id r126so5736619wmr.3
        for <linux-pwm@vger.kernel.org>; Fri, 20 Jan 2017 02:48:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1484836366.2133.243.camel@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ilkka Koskinen <ilkka.koskinen@intel.com>


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 04:32:46PM +0200, Andy Shevchenko wrote:
> On Wed, 2017-01-18 at 12:15 +0100, Thierry Reding wrote:
> > On Mon, Jan 02, 2017 at 11:16:47AM +0200, Andy Shevchenko wrote:
> > > Instead of doing things separately, which is not so reliable on some
> > > platforms,
> > > switch the driver to use new atomic API, i.e. ->apply() callback.
> > >=20
> > > The change has been tested on Intel platforms such as Broxton,
> > > BayTrail, and
> > > Merrifield.
>=20
> > > +static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device
> > > *pwm,
> > > +			=C2=A0=C2=A0struct pwm_state *state)
> > > +{
> > > +	struct pwm_lpss_chip *lpwm =3D to_lpwm(chip);
> > > +
> > > +	if (state->enabled) {
> > > +		if (!pwm_is_enabled(pwm)) {
> > > +			pm_runtime_get_sync(chip->dev);
> > > +			pwm_lpss_config(lpwm, pwm, state-
> > > >duty_cycle, state->period);
> > > +			pwm_lpss_enable(pwm);
> > > +		} else {
> > > +			pwm_lpss_config(lpwm, pwm, state-
> > > >duty_cycle, state->period);
> > > +		}
> > > +	} else if (pwm_is_enabled(pwm)) {
> > > +		pwm_lpss_disable(pwm);
> > > +		pm_runtime_put(chip->dev);
> > > +	}
> >=20
> > Would you mind doing another pass over this and inline the
> > pwm_lpss_enable(), pwm_lpss_disable() and pwm_lpss_config() functions
> > into pwm_lpss_apply()? Your current version effectively duplicates the
> > transitional helpers, but the goal should be to fully get rid of the
> > remainders of the legacy API.
>=20
> I don't see how inlining them helps. For me readability of code is more
> important than names of the functions.
>=20
> I can rename functions, but I would like to have them separate from the
> ->apply() callback.
>=20
> Compiler inlines them during optimization.
>=20
> > Besides being much cleaner this also gets rid of slight
> > inconsistencies
> > between the two APIs.
>=20
> I don't see how One Big Function can be cleaner than split version. But
> I give a try to see it on my side when you have settled with Mika's
> patch.

It doesn't necessarily have to be one big function. You obviously need
to find the right balance. If the combined function is still readable,
there's no reason, in my opinion, to split it up. If it gets too large
I think a good split is to keep all of the register programming to be
within ->apply() and have a helper that computes the values to program
and that is called from ->apply().

What I want to avoid is people converting to atomic by mindlessly
duplicating the fallback path in pwm_apply_state().

The goal of the atomic API is that programming of the hardware becomes
atomic. So if you have any computations that may fail because of invalid
inputs or similar, then all of that should happen before any registers
are touched. That's difficult to do with the old enable/config/disable
callbacks, so I don't think we should be following it when converting.

Thierry

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB6vsACgkQ3SOs138+
s6HbFQ/9HCOu7qRFYAxf8I5gn+DpqkMZoQxX7+GjZ+rknH6DsoZd3hRJW5rUS3sN
4b9ZnYzLCehB9XumUSb5onLhx8l1KAAa6rAevHL927zQawj/5cHGAB6S22MpGZ99
mWxhT5KDuPVPDbQGi2B9Ve2Ow8vesD5bnAohGYtRO9uO3TbZjlOa592z3nkIj2sx
9fFbB3o6hQUq7HEOGbe0I2buLUhe8pACDx7EwzluTOPd9HeTquYdF/F1c/Hma5HS
7AS/BGuRxjLzx6sGDWXT8LcDebt8am0q4x4W+WTA2zi3vPwBFEhaqyWyrrI18zDS
mE56c6WTi/3ZroO7l+xHx+weT6PMgND/h1Vt3f9A/QUBe2YqH9aQhdZs5CK4HyqK
8HmRLb/NF+97hCogw17CjdaJdKoE3UR9aOOmFULP33KOCHFie1m40M3iovnu9S51
isg1PevfF1of96qcpe2v20OYirgHEK7XVJxxrR6xOaoCZoiwXW/jO3ew9BY7KLsC
wEQnLFGb2B3tzRQEhX645v8WJqzIPmpdFmiirrry4g11f7HEtQLRgCB3Ix4chYOL
LlpLCU6FoECaIPjoLlj54cd2gC8Wh/WIIhkgwMPZKO9K3uWr0nUevteMeWP8dq+S
mUcB01fEFjXQ3VVYuNLDoYkTQise0rWVqyhBacst4kK1Eb0tTLo=
=otUm
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
