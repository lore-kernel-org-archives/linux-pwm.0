From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH 2/6] pwm: imx: Move PWMv2 software reset code to a
 separate function
Date: Mon, 24 Oct 2016 23:02:32 +0200
Message-ID: <20161024230232.3527fd42@jawa>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
        <1477259146-19167-3-git-send-email-l.majewski@majess.pl>
        <20161024172322.3924eb8a@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/X77/RGRthTMdkAQeAQs5=eO"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161024172322.3924eb8a@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

--Sig_/X77/RGRthTMdkAQeAQs5=eO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Boris,

> On Sun, 23 Oct 2016 23:45:42 +0200
> Lukasz Majewski <l.majewski@majess.pl> wrote:
>=20
> > The software reset code has been extracted from imx_pwm_config_v2
> > function and moved to new one - imx_pwm_sw_reset().
> >=20
> > This change reduces the overall size of imx_pwm_config_v2() and
> > prepares it for atomic PWM operation.
> >=20
> > Suggested-by: Stefan Agner <stefan@agner.ch>
> > Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
>=20
> Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>=20
> Just a nit below ;).
>=20
> BTW, can't you just merge path 2 and 3?

I do prefer to have many small patches touching and changing just one
thing.

>=20
> > ---
> >  drivers/pwm/pwm-imx.c | 34 ++++++++++++++++++++++------------
> >  1 file changed, 22 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > index 83e43d5..fac5c93 100644
> > --- a/drivers/pwm/pwm-imx.c
> > +++ b/drivers/pwm/pwm-imx.c
> > @@ -131,6 +131,25 @@ static void imx_pwm_disable_v1(struct pwm_chip
> > *chip, struct pwm_device *pwm) clk_disable_unprepare(imx->clk_per);
> >  }
> > =20
> > +static void imx_pwm_sw_reset(struct pwm_chip *chip)
> > +{
> > +	struct imx_chip *imx =3D to_imx_chip(chip);
> > +	struct device *dev =3D chip->dev;
> > +	int wait_count =3D 0;
> > +	u32 cr;
> > +
> > +	writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
> > +	do {
> > +		usleep_range(200, 1000);
> > +		cr =3D readl(imx->mmio_base + MX3_PWMCR);
> > +	} while ((cr & MX3_PWMCR_SWR) &&
> > +		 (wait_count++ < MX3_PWM_SWR_LOOP));
> > +
> > +	if (cr & MX3_PWMCR_SWR)
> > +		dev_warn(dev, "software reset timeout\n");
> > +}
> > +
> > +
> >  static int imx_pwm_config_v2(struct pwm_chip *chip,
> >  		struct pwm_device *pwm, int duty_ns, int period_ns)
> >  {
> > @@ -140,7 +159,7 @@ static int imx_pwm_config_v2(struct pwm_chip
> > *chip, unsigned long period_cycles, duty_cycles, prescale;
> >  	unsigned int period_ms;
> >  	bool enable =3D pwm_is_enabled(pwm);
> > -	int wait_count =3D 0, fifoav;
> > +	int fifoav;
> >  	u32 cr, sr;
> > =20
> >  	/*
> > @@ -162,17 +181,8 @@ static int imx_pwm_config_v2(struct pwm_chip
> > *chip, if (fifoav =3D=3D (sr & MX3_PWMSR_FIFOAV_MASK))
> >  				dev_warn(dev, "there is no free
> > FIFO slot\n"); }
> > -	} else {
> > -		writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
> > -		do {
> > -			usleep_range(200, 1000);
> > -			cr =3D readl(imx->mmio_base + MX3_PWMCR);
> > -		} while ((cr & MX3_PWMCR_SWR) &&
> > -			 (wait_count++ < MX3_PWM_SWR_LOOP));
> > -
> > -		if (cr & MX3_PWMCR_SWR)
> > -			dev_warn(dev, "software reset timeout\n");
> > -	}
> > +	} else
> > +		imx_pwm_sw_reset(chip);
>=20
> 	} else {
> 		imx_pwm_sw_reset(chip);
> 	}

OK.

>=20
> > =20
> >  	c =3D clk_get_rate(imx->clk_per);
> >  	c =3D c * period_ns;
>=20

Best regards,

=C5=81ukasz Majewski

--Sig_/X77/RGRthTMdkAQeAQs5=eO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgOdu0ACgkQf9/hG2YwgjEJ2QCcDZe8anNTk8fxkq3aBSehxLCZ
QC0AnjHWUQPHH8Ir9pjia3nlfr7BZ8wk
=orfo
-----END PGP SIGNATURE-----

--Sig_/X77/RGRthTMdkAQeAQs5=eO--
