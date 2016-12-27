From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v3 RESEND 02/11] pwm: imx: remove ipg clock
Date: Tue, 27 Dec 2016 08:54:01 +0100
Message-ID: <20161227085401.0115add5@jawa>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
        <1482792961-12702-3-git-send-email-l.majewski@majess.pl>
        <46d2d434303d416645f27bb20358d46e@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/KxMo/vF_kO=aSVEoVd4fTVm"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 18.mo6.mail-out.ovh.net ([46.105.73.110]:37851 "EHLO
        18.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbcL0IAn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Dec 2016 03:00:43 -0500
Received: from player776.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 128B16BE82
        for <linux-pwm@vger.kernel.org>; Tue, 27 Dec 2016 08:54:24 +0100 (CET)
In-Reply-To: <46d2d434303d416645f27bb20358d46e@agner.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>

--Sig_/KxMo/vF_kO=aSVEoVd4fTVm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> On 2016-12-26 23:55, Lukasz Majewski wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >=20
> > The use of the ipg clock was introduced with commit 7b27c160c681
> > ("pwm: i.MX: fix clock lookup").
> > In the commit message it was claimed that the ipg clock is enabled
> > for register accesses. This is true for the ->config() callback,
> > but not for the ->set_enable() callback. Given that the ipg clock
> > is not consistently enabled for all register accesses we can assume
> > that either it is not required at all or that the current code does
> > not work. Remove the ipg clock code for now so that it's no longer
> > in the way of refactoring the driver.
>=20
> Hi Lukasz,
>=20
> Has my concern addressed in any way with this resend?
> https://lkml.org/lkml/2016/11/22/729

Unfortunately not, since I don't have iMX7 for testing.

>=20
> Breaking hardware is usually not an option :-)

Yes, I know, but

Please look on the patch set from my perspective:

I originally wanted to add polarity inversion to PWM. Then, there was
the request from you and Boris to go with "atomicity" support, so I
converted the driver to support it.

This patch set has been resent on purpose at the end of merge window,
so we do have some time to fix it if it would be accepted to -next
tree (or any other PWM related one). Moreover, the burden for preparing
patches would be smaller - since we all have agreed that "atomicity" is
a more than welcome feature.


>=20
> I checked the i.MX 7 reference manual again, and in this case the
> peripheral access clock is a clock line named "ipg_clk_s" (Table
> 12-20), with a clock root "PWM1_CLK_ROOT" (Table 5-12). In i.MX 7 all
> clocks are behind a single gate, so in fact it does not matter which
> clock we take. Given that others have peripheral access behind the
> "pwm" gate, I guess we should take the "pwm" gate...


If possible please prepare a patch. It would be the best solution.

Thanks in advance,
=C5=81ukasz Majewski

>=20
> --
> Stefan
>=20
> >=20
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> > [commit message text refactored by Lukasz Majewski
> > <l.majewski@majess.pl>] ---
> > Changes for v3:
> > - New patch
> > ---
> >  drivers/pwm/pwm-imx.c | 19 +------------------
> >  1 file changed, 1 insertion(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > index d600fd5..70609ef2 100644
> > --- a/drivers/pwm/pwm-imx.c
> > +++ b/drivers/pwm/pwm-imx.c
> > @@ -49,7 +49,6 @@
> > =20
> >  struct imx_chip {
> >  	struct clk	*clk_per;
> > -	struct clk	*clk_ipg;
> > =20
> >  	void __iomem	*mmio_base;
> > =20
> > @@ -204,17 +203,8 @@ static int imx_pwm_config(struct pwm_chip
> > *chip, struct pwm_device *pwm, int duty_ns, int period_ns)
> >  {
> >  	struct imx_chip *imx =3D to_imx_chip(chip);
> > -	int ret;
> > -
> > -	ret =3D clk_prepare_enable(imx->clk_ipg);
> > -	if (ret)
> > -		return ret;
> > =20
> > -	ret =3D imx->config(chip, pwm, duty_ns, period_ns);
> > -
> > -	clk_disable_unprepare(imx->clk_ipg);
> > -
> > -	return ret;
> > +	return imx->config(chip, pwm, duty_ns, period_ns);
> >  }
> > =20
> >  static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device
> > *pwm) @@ -293,13 +283,6 @@ static int imx_pwm_probe(struct
> > platform_device *pdev) return PTR_ERR(imx->clk_per);
> >  	}
> > =20
> > -	imx->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
> > -	if (IS_ERR(imx->clk_ipg)) {
> > -		dev_err(&pdev->dev, "getting ipg clock failed with
> > %ld\n",
> > -				PTR_ERR(imx->clk_ipg));
> > -		return PTR_ERR(imx->clk_ipg);
> > -	}
> > -
> >  	imx->chip.ops =3D &imx_pwm_ops;
> >  	imx->chip.dev =3D &pdev->dev;
> >  	imx->chip.base =3D -1;


--Sig_/KxMo/vF_kO=aSVEoVd4fTVm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlhiHiIACgkQf9/hG2YwgjHOfwCfb+OISow3ckSweVTWY5Lny1dr
VbcAn3ANz+GU43rv7onIwjamMUt+whxo
=3Uqd
-----END PGP SIGNATURE-----

--Sig_/KxMo/vF_kO=aSVEoVd4fTVm--
