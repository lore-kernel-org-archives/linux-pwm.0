Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36677 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfJPJur (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Oct 2019 05:50:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so27277314wrd.3
        for <linux-pwm@vger.kernel.org>; Wed, 16 Oct 2019 02:50:45 -0700 (PDT)
Date: Wed, 16 Oct 2019 11:50:42 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20191016095042.GB1303817@ulmo>
References: <20191016073842.1300297-1-thierry.reding@gmail.com>
 <20191016073842.1300297-3-thierry.reding@gmail.com>
 <20191016083107.fetprdj7k52hkdvy@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <20191016083107.fetprdj7k52hkdvy@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 2/3] pwm: stm32: Remove confusing bitmask
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 10:31:07AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Oct 16, 2019 at 09:38:41AM +0200, Thierry Reding wrote:
> > Both BKP bits are set in the BDTR register and the code relies on the
> > mask used during write to make sure only one of them is written. Since
> > this isn't immediately obvious, a comment is needed to explain it. The
> > same can be achieved by making explicit what happens, so add another
> > temporary variable that contains only the one bit that is actually ORed
> > into the register and get rid of the comment.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >  drivers/pwm/pwm-stm32.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > index b12fb11b7a55..8f1f3371e1dd 100644
> > --- a/drivers/pwm/pwm-stm32.c
> > +++ b/drivers/pwm/pwm-stm32.c
> > @@ -493,26 +493,24 @@ static const struct pwm_ops stm32pwm_ops =3D {
> >  static int stm32_pwm_set_breakinput(struct stm32_pwm *priv,
> >  				    int index, int level, int filter)
> >  {
> > -	u32 bke, shift, mask, bdtr;
> > +	u32 bke, bkp, shift, mask, bdtr;
> > =20
> >  	if (index =3D=3D 0) {
> >  		bke =3D TIM_BDTR_BKE;
> > +		bkp =3D TIM_BDTR_BKP;
> >  		shift =3D TIM_BDTR_BKF_SHIFT;
> >  		mask =3D TIM_BDTR_BKE | TIM_BDTR_BKP | TIM_BDTR_BKF;
> >  	} else {
> >  		bke =3D TIM_BDTR_BK2E;
> > +		bkp =3D TIM_BDTR_BK2P;
> >  		shift =3D TIM_BDTR_BK2F_SHIFT;
> >  		mask =3D TIM_BDTR_BK2E | TIM_BDTR_BK2P | TIM_BDTR_BK2F;
>=20
> Assuming in the else branch index is always 1, the following would be
> IMHO nicer:
>=20
> #define TIM_BDTR_BKE(i) BIT(12 + 12 * (i))
> #define TIM_BDTR_BKP(i) BIT(13 + 12 * (i))
> #define TIM_BDTR_BKF_SHIFT(i) (16 + 4 * (i))
>=20
> ..
>=20
> 	bke =3D TIM_BDTR_BKE(index);
> 	bkp =3D TIM_BDTR_BKP(index);

I had thought about that, but ultimately decided against it because
the original defines might match exactly what's in the datasheet, so
there's some value to keep the originals.

I suppose one other alternative would be to let the macros be and do the
computations in the driver instead, something like:

	bke =3D TIM_BDTR_BKE << (index * 12);
	bkp =3D TIM_BDTR_BKP << (index * 12);
	bkf =3D TIM_BDTR_BKF << (index *  4);

But yeah, I agree that having the parameters be part of the macros is
even better.

Fabrice, any objection to redefining the macros as above?

Thierry

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2m5+8ACgkQ3SOs138+
s6GSqA/+MTdWclsUcjCM3mrE8mDdl7NpUvdj/aCo5d6Q6f6Ihyy+f9RhBX27Sirk
K917UMgnm5ZXnDX2WHBJd/ntPePAzeQaFtedR8aiprk87C+8iWqgBzRxEyobNDAO
Z2fwAMqTsnHpdy+GedKAPugzsHvYuKqdrlkEuT3ka5/Yxs+kVqyVZsJVNJou6pIa
BMqxclu4q7mHWmhLCZN1Xk8Aejk/IyHi9KQr5SljOm4RLkVASZ2z740YZC4O1DCc
cqH4+sa6CrmI2nYBGrS8nYLjg3yZq6NzDLmN68VUseGpNYZXJsMe6AJ12JChOiIh
Dg9uNHyRNAEEXOzNblGif+fJnIfaTIQ7oX3pLST9c9nwGSieNsOpNf/1PMdY1+vE
H+duv5ojUZGxw54FshUpXzKbJMWKL/AxHVN/LRsPI/1rpus3uQMSCJbzKdsPaKQF
0qvm1YeRvj79QRcnt4k7i0eiUxPyy/VHsVNENad/xiX3BkluiPpSnAtKD9mh54fE
roZBEPCNmAOLg0T8h1LiL4p03TIvxqGYAv7nV2rcD4bPUfOy2A+zBOr+ZmLttfVB
zzBrsubXxkSttLbTEPYBPrC7OLIPCdDPHEjQpmWK6vT6LjSawT1z/pPVXZAGQnsK
aU0jP2YxgdkLFOMhawaEeBXHIQwphunGkkJTj1IrK9TtK3O8428=
=YbQI
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
