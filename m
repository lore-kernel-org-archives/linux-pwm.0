Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43532 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391656AbfJPNHV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 09:07:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so27966731wrq.10
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 06:07:19 -0700 (PDT)
Date: Wed, 16 Oct 2019 15:07:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20191016130716.GC1772382@ulmo>
References: <20191016110601.1765415-1-thierry.reding@gmail.com>
 <20191016110601.1765415-4-thierry.reding@gmail.com>
 <20191016111522.vzsipskmt66q27bq@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <20191016111522.vzsipskmt66q27bq@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 3/3] pwm: stm32: Validate breakinput data from DT
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 01:15:22PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Oct 16, 2019 at 01:06:01PM +0200, Thierry Reding wrote:
> > Both index and level can only be either 0 or 1 and the filter value is
> > limited to values between (and including) 0 and 15. Validate that the
> > device tree node contains values that are within these ranges.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  drivers/pwm/pwm-stm32.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > index db1d675b45fb..7ff48c14fae8 100644
> > --- a/drivers/pwm/pwm-stm32.c
> > +++ b/drivers/pwm/pwm-stm32.c
> > @@ -530,6 +530,7 @@ static int stm32_pwm_probe_breakinputs(struct stm32=
_pwm *priv,
> >  				       struct device_node *np)
> >  {
> >  	int nb, ret, array_size;
> > +	unsigned int i;
> > =20
> >  	nb =3D of_property_count_elems_of_size(np, "st,breakinput",
> >  					     sizeof(struct stm32_breakinput));
> > @@ -551,6 +552,13 @@ static int stm32_pwm_probe_breakinputs(struct stm3=
2_pwm *priv,
> >  	if (ret)
> >  		return ret;
> > =20
> > +	for (i =3D 0; i < priv->num_breakinputs; i++) {
> > +		if (priv->breakinputs[i].index > 1 ||
> > +		    priv->breakinputs[i].level > 1 ||
> > +		    priv->breakinputs[i].filter > 15)
> > +			return -EINVAL;
> > +	}
> > +
>=20
> maybe put this patch before patch 1 that relies on index not being
> bigger than 1?

Yeah, that's a good idea. Does that resolve the concerns you had on
patch 1?

Thierry

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2nFgMACgkQ3SOs138+
s6GoXhAAjM9CLPbTtmBWccz2KqxoEz5fs2Ztss4ayn1mUX7tGd0oAXkFb/gil+a5
1jy5cXNsjzSAmCHbFsGpW+7UyJeAZmpBIcSmnP360Kk3iODTUhSnRw/Z605slf+y
+jqeuJ/p7tSrPJBSXCNyUNquGkMg9uIKzP02kHtt+1Y5qHpCoPnaxR/M+03c7jI7
QkLF0hTZCTd+2sZLy3F1Dhykw4Ylm5MCJaEftcPkZcBLjUrneSwnASDomItmaUxf
Ng/NZ0mtvnlBQPwz+eKD98bOr5fYwmMchuHDuY9CbwJxXTExeluukofIxV/DvH2p
dOKC8WobR4Fhji6nMLiXpgaW94eo6UfP4UlPV044DUPIkfBK+qMDY4uNDpNbWpcs
QlhLuIW9dH9WBEl8bOO72rf47jSAWWo08SzPS4qAN4wPVJKrgdVVnOtIsX4CCO8W
ZXnyyuklRBXh+fH8VDinLAjeyJLUw/jAKoHQ+qa5p67azcS7/VHaOgG4EKqWFVcB
+MPSLImJ60xNkaBA2S9PyWTTtElXXQmjJz/ji22MJQZ6XjE9fYPkljLpI2Au838Z
dzKK0ace/qcrH3EjrthH/dhLzeEgs6PZjI/uwkRq74T53US4Pa+m5YvrGOFWvp9C
NSIrulFPkmRFAIVKeZQ+8FlTcSatGejmUdE35VVib9Bd5ELYpcM=
=TDCT
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
