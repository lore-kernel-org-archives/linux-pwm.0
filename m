From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH 6/6] pwm: imx: Introduce "polarity_supported" flag to
 PWMv2 driver
Date: Tue, 25 Oct 2016 08:58:49 +0200
Message-ID: <20161025085849.2a0225f0@jawa>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <1477259146-19167-7-git-send-email-l.majewski@majess.pl>
        <20161024172852.40662611@bbrezillon>
        <20161024173410.6e641b9c@bbrezillon>
        <20161024231458.075ea50b@jawa>
        <20161025083700.342f9abe@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_//=B6cmInJ8DQWqQWR0Kb5Yh"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:38576 "EHLO
        5.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750833AbcJYG7K (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Oct 2016 02:59:10 -0400
Received: from player693.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id E352C4D8F3
        for <linux-pwm@vger.kernel.org>; Tue, 25 Oct 2016 08:59:07 +0200 (CEST)
In-Reply-To: <20161025083700.342f9abe@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de

--Sig_//=B6cmInJ8DQWqQWR0Kb5Yh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Boris,

> Hi Lukasz,
>=20
> On Mon, 24 Oct 2016 23:14:58 +0200
> Lukasz Majewski <l.majewski@majess.pl> wrote:
>=20
> > Hi Boris,
> >=20
> > > On Mon, 24 Oct 2016 17:28:52 +0200
> > > Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> > >  =20
> > > > On Sun, 23 Oct 2016 23:45:46 +0200
> > > > Lukasz Majewski <l.majewski@majess.pl> wrote:
> > > >  =20
> > > > > The need for set_polarity() function has been removed by
> > > > > implementing PWM atomic support (apply() callback).
> > > > >=20
> > > > > To indicate that the PWMv2 supports polarity inversion, new
> > > > > flag - "polarity_supported" has been introduced.
> > > > >=20
> > > > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > > > ---
> > > > >  drivers/pwm/pwm-imx.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > > > index 02d3dfd..be3034d 100644
> > > > > --- a/drivers/pwm/pwm-imx.c
> > > > > +++ b/drivers/pwm/pwm-imx.c
> > > > > @@ -258,6 +258,7 @@ static struct pwm_ops imx_pwm_ops_v2 =3D {
> > > > >  };
> > > > > =20
> > > > >  struct imx_pwm_data {
> > > > > +	bool polarity_supported;
> > > > >  	struct pwm_ops *pwm_ops;
> > > > >  };
> > > > > =20
> > > > > @@ -266,6 +267,7 @@ static struct imx_pwm_data
> > > > > imx_pwm_data_v1 =3D { };
> > > > > =20
> > > > >  static struct imx_pwm_data imx_pwm_data_v2 =3D {
> > > > > +	.polarity_supported =3D true,
> > > > >  	.pwm_ops =3D &imx_pwm_ops_v2,
> > > > >  };
> > > > > =20
> > > > > @@ -313,7 +315,7 @@ static int imx_pwm_probe(struct
> > > > > platform_device *pdev) imx->chip.base =3D -1;
> > > > >  	imx->chip.npwm =3D 1;
> > > > >  	imx->chip.can_sleep =3D true;
> > > > > -	if (data->pwm_ops->set_polarity) {
> > > > > +	if (data->polarity_supported) {   =20
> > > >=20
> > > > You're still breaking backward compatibility with DTs defining
> > > > #pwm-cells =3D 2.
> > > >=20
> > > > Please test the #pwm-cells value before deciding which of_xlate
> > > > should be used. =20
> > >=20
> > > Nevermind, I didn't look at [1] and [2]. =20
> >=20
> > Yes, some patches are required to make this code work. Especially, I
> > wanted to explicitly reuse and credit work already done by
> > Bhuvanchandra.
> >=20
> > > But still, your series is not bisectable: this change should be
> > > part of patch 5 where you remove the ->set_polarity
> > > implementation. Otherwise, this means you don't support polarity
> > > setting between patch 5 and 6. =20
> >=20
> > Frankly speaking, I did it on purpose, to have operations in commits
> > logically separated.
> >=20
> > I personally, do detest commits which blur the picture and are not
> > corresponding to one single logical change - for example remove some
> > large chunk of code and also add some tiny, new flag.
> >=20
> > For me it is not a problem to have polarity disabled between
> > patches 5 and 6, since at the end of the day we have it enabled.
>=20
> It's really simple to make this series bisectable, all you have to do
> is move patch 6 before patch 5.

Hmm... You are right, I do wonder why I didn't get this idea from the
very beginning.

> This being said, I really think you
> should follow Stefan's recommendation: base your changes on mainline
> and switch to the atomic hook before supporting polarity setting.

I will do my best :-)

Best regards,

=C5=81ukasz Majewski

>=20
> Regards,
>=20
> Boris


--Sig_//=B6cmInJ8DQWqQWR0Kb5Yh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgPArEACgkQf9/hG2YwgjGOEwCgzgkK/XfGjalDJpzcsp4rNdGW
v4oAoLAB3FEz3cNnIKMUWdV/3I37mOC0
=b+4Y
-----END PGP SIGNATURE-----

--Sig_//=B6cmInJ8DQWqQWR0Kb5Yh--
