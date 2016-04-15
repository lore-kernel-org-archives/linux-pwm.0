From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND 07/11] pwm: sti: Initialise PWM Capture channel data
Date: Fri, 15 Apr 2016 16:22:43 +0200
Message-ID: <20160415142243.GE3472@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
 <20160412102926.GC18882@ulmo.ba.sec>
 <20160415123941.GD3589@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33842 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbcDOOWs (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Apr 2016 10:22:48 -0400
Content-Disposition: inline
In-Reply-To: <20160415123941.GD3589@x1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 01:39:41PM +0100, Lee Jones wrote:
> On Tue, 12 Apr 2016, Thierry Reding wrote:
>=20
> > On Wed, Mar 02, 2016 at 03:32:05PM +0000, Lee Jones wrote:
> > [...]
> > > +struct sti_cpt_data {
> > > +	u32 snapshot[3];
> > > +	int index;
> > > +	int gpio;
> >=20
> > On a side-note, this should probably use struct gpio_desc * instead of
> > an integer along with the gpiod_*() APIs for the GPIO handling.
>=20
> Why would you need to do that?
>=20
> of_get_named_gpio() does all that for you.

Use the of_get_named_gpio*d*() function instead. My understanding is
that referring to GPIOs by integer is deprecated and should not be used
in new code.

Thierry

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXEPkzAAoJEN0jrNd/PrOhO3EQALH7XbzDHh2g0KdP/uhC8HzB
YsKSSp+IoEIZH7B3u+SwqTB4e3NL+SnElW2pHu0BoOg0ogK+h7/IAOhWqEoEcjgS
Tqkfk7OWakcaFR28ASGx/9USKY7JIuMvUANeyx2xuhe+Zx4/aP3pfqVgRpiNa9hG
NljQzSdpd1anc1quacI8KW4R7VoilOoW4O1eRMgIhbzAeRKcu7/9ctGd+QmlwiCd
50h+H0NBBmdElKXliCMANAjiwCXUCwp8bmxOtFJI2TLmQ9co0RUUMtPDse5eKnrP
iXDm9smQMdiid1LWGv06DeZSKUMeQYrJ/AcouFjxfIb1BH6mo6X+YoBEhwIj3TqK
LLF14uwZPtsH6D0Ei1MgOqffNZ0jipghpBfMttNHMJQNzcBJ/ZZ8czpM8L50OZMW
BXg3ZOltzej3S8rJx9OP+Zg4J/60eORpdt4TwMRucMuvUCxQLO3gPfBIiIQGRHVP
meOcSE6/o8Xex10dz/8gf6YD8UkX65vV36CCABejYReYkbqid5P3ocrVdD7GlXto
64QoXRWnFNj7QgLl9KTvoOpB4cpVgwZSbXIAgBC+0l8LW+6BQJXnEdDY48hdsAjJ
GJuj71iiJY8XlRMBASg5jA9UG28VdHB9rm4lNj7X/W7GF47XUbm2bRq3PQUr3MRx
VTIeDM4t0cVrdxzIHwWh
=TYWD
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
