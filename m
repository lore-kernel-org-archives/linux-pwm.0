From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v2 03/10] pwm: imx: Rewrite imx_pwm_*_v1 code to
 facilitate switch to atomic pwm operation
Date: Mon, 31 Oct 2016 09:06:00 +0100
Message-ID: <20161031090600.6d56c4a4@jawa>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
        <1477549785-4972-4-git-send-email-l.majewski@majess.pl>
        <20161027094005.2da3b7d4@bbrezillon>
        <20161031055904.av45k535c26gjonz@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/B6T6SEl+Gspe9X3w5LTzN/l"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:57117 "EHLO
        4.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762077AbcJaIQX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Oct 2016 04:16:23 -0400
Received: from player716.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 215C51DD5
        for <linux-pwm@vger.kernel.org>; Mon, 31 Oct 2016 09:06:23 +0100 (CET)
In-Reply-To: <20161031055904.av45k535c26gjonz@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Philipp Zabel <pza@pengutronix.de>

--Sig_/B6T6SEl+Gspe9X3w5LTzN/l
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sascha,

> On Thu, Oct 27, 2016 at 09:40:05AM +0200, Boris Brezillon wrote:
> > On Thu, 27 Oct 2016 08:29:39 +0200
> > Lukasz Majewski <l.majewski@majess.pl> wrote:
> >=20
> > > The code has been rewritten to remove "generic" calls to
> > > imx_pwm_{enable|disable|config}.
> > >=20
> > > Such approach would facilitate switch to atomic PWM (a.k.a
> > > ->apply()) implementation.
> > >=20
> > > Suggested-by: Stefan Agner <stefan@agner.ch>
> > > Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > > ---
> > > Changes for v2:
> > > - Add missing clock unprepare for clk_ipg
> > > - Enable peripheral PWM clock (clk_per)
> > > ---
> > >  drivers/pwm/pwm-imx.c | 50
> > > ++++++++++++++++++++++++++++++++++++++------------ 1 file
> > > changed, 38 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > index ea3ce79..822eb5a 100644
> > > --- a/drivers/pwm/pwm-imx.c
> > > +++ b/drivers/pwm/pwm-imx.c
> > > @@ -65,8 +65,6 @@ struct imx_chip {
> > >  static int imx_pwm_config_v1(struct pwm_chip *chip,
> > >  		struct pwm_device *pwm, int duty_ns, int
> > > period_ns) {
> > > -	struct imx_chip *imx =3D to_imx_chip(chip);
> > > -
> > >  	/*
> > >  	 * The PWM subsystem allows for exact frequencies.
> > > However,
> > >  	 * I cannot connect a scope on my device to the PWM line
> > > and @@ -84,26 +82,56 @@ static int imx_pwm_config_v1(struct
> > > pwm_chip *chip,
> > >  	 * both the prescaler (/1 .. /128) and then by CLKSEL
> > >  	 * (/2 .. /16).
> > >  	 */
> > > +	struct imx_chip *imx =3D to_imx_chip(chip);
> > >  	u32 max =3D readl(imx->mmio_base + MX1_PWMP);
> > >  	u32 p =3D max * duty_ns / period_ns;
> > > +	int ret;
> > > +
> > > +	ret =3D clk_prepare_enable(imx->clk_ipg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	writel(max - p, imx->mmio_base + MX1_PWMS);
> > > =20
> > > +	clk_disable_unprepare(imx->clk_ipg);
> > > +
> > >  	return 0;
> > >  }
> > > =20
> > > -static void imx_pwm_set_enable_v1(struct pwm_chip *chip, bool
> > > enable) +static int imx_pwm_enable_v1(struct pwm_chip *chip,
> > > struct pwm_device *pwm) {
> > >  	struct imx_chip *imx =3D to_imx_chip(chip);
> > > +	int ret;
> > >  	u32 val;
> > > =20
> > > +	ret =3D clk_prepare_enable(imx->clk_ipg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D clk_prepare_enable(imx->clk_per);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	val =3D readl(imx->mmio_base + MX1_PWMC);
> > > +	val |=3D MX1_PWMC_EN;
> > > +	writel(val, imx->mmio_base + MX1_PWMC);
> > > =20
> > > -	if (enable)
> > > -		val |=3D MX1_PWMC_EN;
> > > -	else
> > > -		val &=3D ~MX1_PWMC_EN;
> > > +	clk_disable_unprepare(imx->clk_ipg);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void imx_pwm_disable_v1(struct pwm_chip *chip, struct
> > > pwm_device *pwm) +{
> > > +	struct imx_chip *imx =3D to_imx_chip(chip);
> > > +	u32 val;
> > > +
> > > +	val =3D readl(imx->mmio_base + MX1_PWMC);
> > > +	val &=3D ~MX1_PWMC_EN;
> > > =20
> > >  	writel(val, imx->mmio_base + MX1_PWMC);
> >=20
> > Are you sure you don't need to enable the ipg clk when manipulating
> > the PWMC register?
> > If it's not needed here, then it's probably not needed in
> > imx_pwm_enable_v1() either.
>=20
> As said, even the commit 7b27c160c68 introducing the register clk did
> not enable the clock consistently for all register accesses.=20

If I might ask - do you have i.MX hardware with PWMv1? If yes, I would
be grateful for testing (and provide proper patch), since I don't posses
one.

> Maybe
> it's best to include the following patch so that we can find a clear
> culprit=20

If we don't have HW to test the solution - why should we apply this
patch and introduce regression?



If you can provide (and test) fix for v1 - please prepare patch, so it
could be added on top of this patch series (as done with pwm polarity
inversion in this patch series).


> and do not bury the ipg clock changes in larger patches.
>=20
> Sascha
>=20
> -----------------------------8<-----------------------------------
>=20
> From 30b77e83269a58c2cb5ce6de8be647e027030d34 Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Mon, 31 Oct 2016 06:45:33 +0100
> Subject: [PATCH] pwm: imx: remove ipg clock
>=20
> The use of the ipg clock was introduced with commit 7b27c160c6. In the
> commit message it was claimed that the ipg clock is enabled for
> register accesses. This is true for the ->config() callback, but not
> for the ->set_enable() callback. Given that the ipg clock is not
> consistently enabled for all register accesses we can assume that
> either it is not required at all or that the current code does not
> work. Remove the ipg clock code for now so that it's no longer in the
> way of refactoring the driver.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/pwm/pwm-imx.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index d600fd5..70609ef2 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -49,7 +49,6 @@
> =20
>  struct imx_chip {
>  	struct clk	*clk_per;
> -	struct clk	*clk_ipg;
> =20
>  	void __iomem	*mmio_base;
> =20
> @@ -204,17 +203,8 @@ static int imx_pwm_config(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns)
>  {
>  	struct imx_chip *imx =3D to_imx_chip(chip);
> -	int ret;
> -
> -	ret =3D clk_prepare_enable(imx->clk_ipg);
> -	if (ret)
> -		return ret;
> =20
> -	ret =3D imx->config(chip, pwm, duty_ns, period_ns);
> -
> -	clk_disable_unprepare(imx->clk_ipg);
> -
> -	return ret;
> +	return imx->config(chip, pwm, duty_ns, period_ns);
>  }
> =20
>  static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device
> *pwm) @@ -293,13 +283,6 @@ static int imx_pwm_probe(struct
> platform_device *pdev) return PTR_ERR(imx->clk_per);
>  	}
> =20
> -	imx->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
> -	if (IS_ERR(imx->clk_ipg)) {
> -		dev_err(&pdev->dev, "getting ipg clock failed with
> %ld\n",
> -				PTR_ERR(imx->clk_ipg));
> -		return PTR_ERR(imx->clk_ipg);
> -	}

And in that way also v2 would be affected.

My gut feeling now is that the "community" wants to solve too many
issues with PWM atomic support rework.=20

Why cannot we add patches on top of already done work, but require
large patch series to be rewritten and resend ?

> -
>  	imx->chip.ops =3D &imx_pwm_ops;
>  	imx->chip.dev =3D &pdev->dev;
>  	imx->chip.base =3D -1;

Best regards,

=C5=81ukasz Majewski

--Sig_/B6T6SEl+Gspe9X3w5LTzN/l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgW+20ACgkQf9/hG2YwgjEWlgCglPZEHFDqN7/BTVHEV9UzEO6g
kmcAoLwIIIFB2KGbUgoUzQ+e6GrqYX3i
=K//f
-----END PGP SIGNATURE-----

--Sig_/B6T6SEl+Gspe9X3w5LTzN/l--
