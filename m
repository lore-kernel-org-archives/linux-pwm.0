From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH 6/6] pwm: imx: Introduce "polarity_supported" flag to
 PWMv2 driver
Date: Mon, 24 Oct 2016 23:14:58 +0200
Message-ID: <20161024231458.075ea50b@jawa>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <1477259146-19167-7-git-send-email-l.majewski@majess.pl>
        <20161024172852.40662611@bbrezillon>
        <20161024173410.6e641b9c@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Qzg.UH4Wtnc8Wj_GLzOWK+B"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 11.mo3.mail-out.ovh.net ([87.98.184.158]:35126 "EHLO
        11.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755128AbcJXVPS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Oct 2016 17:15:18 -0400
Received: from player693.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 8FCBC4B513
        for <linux-pwm@vger.kernel.org>; Mon, 24 Oct 2016 23:15:16 +0200 (CEST)
In-Reply-To: <20161024173410.6e641b9c@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de

--Sig_/Qzg.UH4Wtnc8Wj_GLzOWK+B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Boris,

> On Mon, 24 Oct 2016 17:28:52 +0200
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>=20
> > On Sun, 23 Oct 2016 23:45:46 +0200
> > Lukasz Majewski <l.majewski@majess.pl> wrote:
> >=20
> > > The need for set_polarity() function has been removed by
> > > implementing PWM atomic support (apply() callback).
> > >=20
> > > To indicate that the PWMv2 supports polarity inversion, new flag -
> > > "polarity_supported" has been introduced.
> > >=20
> > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > ---
> > >  drivers/pwm/pwm-imx.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > index 02d3dfd..be3034d 100644
> > > --- a/drivers/pwm/pwm-imx.c
> > > +++ b/drivers/pwm/pwm-imx.c
> > > @@ -258,6 +258,7 @@ static struct pwm_ops imx_pwm_ops_v2 =3D {
> > >  };
> > > =20
> > >  struct imx_pwm_data {
> > > +	bool polarity_supported;
> > >  	struct pwm_ops *pwm_ops;
> > >  };
> > > =20
> > > @@ -266,6 +267,7 @@ static struct imx_pwm_data imx_pwm_data_v1 =3D {
> > >  };
> > > =20
> > >  static struct imx_pwm_data imx_pwm_data_v2 =3D {
> > > +	.polarity_supported =3D true,
> > >  	.pwm_ops =3D &imx_pwm_ops_v2,
> > >  };
> > > =20
> > > @@ -313,7 +315,7 @@ static int imx_pwm_probe(struct
> > > platform_device *pdev) imx->chip.base =3D -1;
> > >  	imx->chip.npwm =3D 1;
> > >  	imx->chip.can_sleep =3D true;
> > > -	if (data->pwm_ops->set_polarity) {
> > > +	if (data->polarity_supported) { =20
> >=20
> > You're still breaking backward compatibility with DTs defining
> > #pwm-cells =3D 2.
> >=20
> > Please test the #pwm-cells value before deciding which of_xlate
> > should be used.
>=20
> Nevermind, I didn't look at [1] and [2].

Yes, some patches are required to make this code work. Especially, I
wanted to explicitly reuse and credit work already done by
Bhuvanchandra.

> But still, your series is not bisectable: this change should be part
> of patch 5 where you remove the ->set_polarity implementation.
> Otherwise, this means you don't support polarity setting between
> patch 5 and 6.

Frankly speaking, I did it on purpose, to have operations in commits
logically separated.

I personally, do detest commits which blur the picture and are not
corresponding to one single logical change - for example remove some
large chunk of code and also add some tiny, new flag.

For me it is not a problem to have polarity disabled between patches 5
and 6, since at the end of the day we have it enabled.

Thanks for your support and review,

Best regards,

=C5=81ukasz Majewski

>=20
> >=20
> > >  		dev_dbg(&pdev->dev, "PWM supports output
> > > inversion\n"); imx->chip.of_xlate =3D of_pwm_xlate_with_flags;
> > >  		imx->chip.of_pwm_n_cells =3D 3; =20
> >=20
>=20
> [1]http://patchwork.ozlabs.org/patch/679706/
> [2]http://patchwork.ozlabs.org/patch/679707/


--Sig_/Qzg.UH4Wtnc8Wj_GLzOWK+B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgOedcACgkQf9/hG2YwgjEXywCgqWAJ5ANUieWzZC7g/Al/nAr7
PIIAoKX9CVeNxDmBqw3RdNPOyNhvBqpu
=Zfdt
-----END PGP SIGNATURE-----

--Sig_/Qzg.UH4Wtnc8Wj_GLzOWK+B--
