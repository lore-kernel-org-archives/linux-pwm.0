From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v2 03/10] pwm: imx: Rewrite imx_pwm_*_v1 code to
 facilitate switch to atomic pwm operation
Date: Thu, 27 Oct 2016 10:22:18 +0200
Message-ID: <20161027102218.028384ff@jawa>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
        <1477549785-4972-4-git-send-email-l.majewski@majess.pl>
        <20161027094005.2da3b7d4@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/cLESMSui2ED3VAhNYH.eaMp"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161027094005.2da3b7d4@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

--Sig_/cLESMSui2ED3VAhNYH.eaMp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Boris,

> On Thu, 27 Oct 2016 08:29:39 +0200
> Lukasz Majewski <l.majewski@majess.pl> wrote:
>=20
> > The code has been rewritten to remove "generic" calls to
> > imx_pwm_{enable|disable|config}.
> >=20
> > Such approach would facilitate switch to atomic PWM (a.k.a
> > ->apply()) implementation.
> >=20
> > Suggested-by: Stefan Agner <stefan@agner.ch>
> > Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
> > ---
> > Changes for v2:
> > - Add missing clock unprepare for clk_ipg
> > - Enable peripheral PWM clock (clk_per)
> > ---
> >  drivers/pwm/pwm-imx.c | 50
> > ++++++++++++++++++++++++++++++++++++++------------ 1 file changed,
> > 38 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > index ea3ce79..822eb5a 100644
> > --- a/drivers/pwm/pwm-imx.c
> > +++ b/drivers/pwm/pwm-imx.c
> > @@ -65,8 +65,6 @@ struct imx_chip {
> >  static int imx_pwm_config_v1(struct pwm_chip *chip,
> >  		struct pwm_device *pwm, int duty_ns, int period_ns)
> >  {
> > -	struct imx_chip *imx =3D to_imx_chip(chip);
> > -
> >  	/*
> >  	 * The PWM subsystem allows for exact frequencies. However,
> >  	 * I cannot connect a scope on my device to the PWM line
> > and @@ -84,26 +82,56 @@ static int imx_pwm_config_v1(struct
> > pwm_chip *chip,
> >  	 * both the prescaler (/1 .. /128) and then by CLKSEL
> >  	 * (/2 .. /16).
> >  	 */
> > +	struct imx_chip *imx =3D to_imx_chip(chip);
> >  	u32 max =3D readl(imx->mmio_base + MX1_PWMP);
> >  	u32 p =3D max * duty_ns / period_ns;
> > +	int ret;
> > +
> > +	ret =3D clk_prepare_enable(imx->clk_ipg);
> > +	if (ret)
> > +		return ret;
> > +
> >  	writel(max - p, imx->mmio_base + MX1_PWMS);
> > =20
> > +	clk_disable_unprepare(imx->clk_ipg);
> > +
> >  	return 0;
> >  }
> > =20
> > -static void imx_pwm_set_enable_v1(struct pwm_chip *chip, bool
> > enable) +static int imx_pwm_enable_v1(struct pwm_chip *chip, struct
> > pwm_device *pwm) {
> >  	struct imx_chip *imx =3D to_imx_chip(chip);
> > +	int ret;
> >  	u32 val;
> > =20
> > +	ret =3D clk_prepare_enable(imx->clk_ipg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D clk_prepare_enable(imx->clk_per);
> > +	if (ret)
> > +		return ret;
> > +
> >  	val =3D readl(imx->mmio_base + MX1_PWMC);
> > +	val |=3D MX1_PWMC_EN;
> > +	writel(val, imx->mmio_base + MX1_PWMC);
> > =20
> > -	if (enable)
> > -		val |=3D MX1_PWMC_EN;
> > -	else
> > -		val &=3D ~MX1_PWMC_EN;
> > +	clk_disable_unprepare(imx->clk_ipg);
> > +
> > +	return 0;
> > +}
> > +
> > +static void imx_pwm_disable_v1(struct pwm_chip *chip, struct
> > pwm_device *pwm) +{
> > +	struct imx_chip *imx =3D to_imx_chip(chip);
> > +	u32 val;
> > +
> > +	val =3D readl(imx->mmio_base + MX1_PWMC);
> > +	val &=3D ~MX1_PWMC_EN;
> > =20
> >  	writel(val, imx->mmio_base + MX1_PWMC);
>=20
> Are you sure you don't need to enable the ipg clk when manipulating
> the PWMC register?
> If it's not needed here, then it's probably not needed in
> imx_pwm_enable_v1() either.

Yes, probably it is needed.

As I've mentioned in the cover letter - I do not have PWMv1 HW so I can
only compile test the code.

(And here support from the community is very welcome).

Best regards,
=C5=81ukasz Majewski

>=20
> > +
> > +	clk_disable_unprepare(imx->clk_per);
> >  }
> > =20
> >  static int imx_pwm_config_v2(struct pwm_chip *chip,
> > @@ -241,9 +269,9 @@ static void imx_pwm_disable(struct pwm_chip
> > *chip, struct pwm_device *pwm) }
> > =20
> >  static struct pwm_ops imx_pwm_ops_v1 =3D {
> > -	.enable =3D imx_pwm_enable,
> > -	.disable =3D imx_pwm_disable,
> > -	.config =3D imx_pwm_config,
> > +	.enable =3D imx_pwm_enable_v1,
> > +	.disable =3D imx_pwm_disable_v1,
> > +	.config =3D imx_pwm_config_v1,
> >  	.owner =3D THIS_MODULE,
> >  };
> > =20
> > @@ -262,8 +290,6 @@ struct imx_pwm_data {
> >  };
> > =20
> >  static struct imx_pwm_data imx_pwm_data_v1 =3D {
> > -	.config =3D imx_pwm_config_v1,
> > -	.set_enable =3D imx_pwm_set_enable_v1,
> >  	.pwm_ops =3D &imx_pwm_ops_v1,
> >  };
> > =20
>=20


--Sig_/cLESMSui2ED3VAhNYH.eaMp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgRuT8ACgkQf9/hG2YwgjGSWACgs8dBXwciCIzFq9zUFPpZZzLo
eMUAn1sqhk1WGFO7MmsJbErjMQSPtK74
=MqVz
-----END PGP SIGNATURE-----

--Sig_/cLESMSui2ED3VAhNYH.eaMp--
