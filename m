Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39274 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfJPJat (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 05:30:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so27195160wrj.6
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 02:30:47 -0700 (PDT)
Date: Wed, 16 Oct 2019 11:30:44 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20191016093044.GA1303817@ulmo>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
 <20191016073842.1300297-2-thierry.reding@gmail.com>
 <20191016082612.fwpig3pup6bor5cn@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20191016082612.fwpig3pup6bor5cn@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 1/3] pwm: stm32: Remove clutter from ternary operator
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 10:26:12AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Oct 16, 2019 at 09:38:40AM +0200, Thierry Reding wrote:
> > Remove usage of the ternary operator to assign values for register
> > fields. This removes clutter and improves readability.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  drivers/pwm/pwm-stm32.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > index 9430b4cd383f..b12fb11b7a55 100644
> > --- a/drivers/pwm/pwm-stm32.c
> > +++ b/drivers/pwm/pwm-stm32.c
> > @@ -493,11 +493,19 @@ static const struct pwm_ops stm32pwm_ops =3D {
> >  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
> >  				    int index, int level, int filter)
> >  {
> > -	u32 bke =3D (index =3D=3D 0) ? TIM_BDTR_BKE : TIM_BDTR_BK2E;
> > -	int shift =3D (index =3D=3D 0) ? TIM_BDTR_BKF_SHIFT : TIM_BDTR_BK2F_S=
HIFT;
> > -	u32 mask =3D (index =3D=3D 0) ? TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDT=
R_BKF
> > -				: TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
> > -	u32 bdtr =3D bke;
> > +	u32 bke, shift, mask, bdtr;
> > +
> > +	if (index =3D=3D 0) {
> > +		bke =3D TIM_BDTR_BKE;
> > +		shift =3D TIM_BDTR_BKF_SHIFT;
> > +		mask =3D TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
> > +	} else {
> > +		bke =3D TIM_BDTR_BK2E;
> > +		shift =3D TIM_BDTR_BK2F_SHIFT;
> > +		mask =3D TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
> > +	}
> > +
> > +	bdtr =3D bke;
>=20
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Is index always in {0, 1}? Maybe a comment or a check about that would
> be helpful. (-> separate patch I think).

The bindings say that index can only be 0 or 1. I guess strictly it
might actually depend on the number of break inputs, but given these
register definitions, there's only ever two.

But yeah, it might be a good idea to sanitize the values upon probe.
I'll add another patch to do that.

Thierry

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2m40IACgkQ3SOs138+
s6E+VxAAoevpPIDLcmfiVv1/WqzfYJ3oThy/mxnj5wJn42nO6Eww3YzDYOnKRpgJ
MtiNT4DYfnhZPBc9QowMW5hTv1TRIE6yiqlcGTv8MlOAjQtVf17EqClpEm8uefLq
vXZDW8u8xgXZ2hxTjVAiv6UakwiIwdlQqarw52peLP3ohCSzahi2VwZ5pR9iZnev
E49lnjsdz265BnMi9/WVEnbKpJwmYj5uxjJhcHsYhhoVKWpRqDFt85Rwk+DqiPib
01FZT7WCDsryP5CWgBjlX1nIhWpWcz3ujqZM2cYmQ3wj82Mclu7LBa+ruQ7MZEBU
OLmo4R1QsZzH5aK+5qdYPD187LJPUCNH/OzL7Vav+Q5u/xt5c8svwq1NFSLu2vvK
XEIw+966q28q7H7NqlXCt4vqq/Wdvn4bhlGY7IhGi2uFP/cKGQNChUuPyY7Li7uG
Y+2Svu6qwx0cHatKqzFgSNM+pfix2ditR1kv3CxnX2Z59jgKu+9K1TfYTnBXMXRl
VnaaTJdDtzUjEAe/58FGLyx0JUuHkKVJ6cpcS1QBXBZs5lRL/LM4l/VO8GbXXv31
eNCNCcXuUkxXsPSK2n79VCmZsERlxdRg/V7NuKtot9+3epaiWSIznve/t96W+fci
5rCkVHBNXPvIeZ8oiKqkhM3KKkkoEPZs9Zm9WRQRS1q9zO4w3+M=
=+xhd
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
