From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v3 02/11] pwm: imx: remove ipg clock
Date: Mon, 28 Nov 2016 07:02:20 +0100
Message-ID: <20161128070220.00d756b9@jawa>
References: <1477984230-18071-1-git-send-email-l.majewski@majess.pl>
        <1477984230-18071-3-git-send-email-l.majewski@majess.pl>
        <369235b4acf1cc29991c18b05202ca49@agner.ch>
        <20161123094305.75f1eb7a@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/UWSjVe.ooAwz/Dl./jKvf0G"; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 19.mo6.mail-out.ovh.net ([188.165.56.177]:33140 "EHLO
        19.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754122AbcK1GJC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Nov 2016 01:09:02 -0500
Received: from player738.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5E2356155E
        for <linux-pwm@vger.kernel.org>; Mon, 28 Nov 2016 07:02:42 +0100 (CET)
In-Reply-To: <20161123094305.75f1eb7a@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Stefan Agner <stefan@agner.ch>, Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>

--Sig_/UWSjVe.ooAwz/Dl./jKvf0G
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Boris, Stefan,

> On Tue, 22 Nov 2016 13:04:11 -0800
> Stefan Agner <stefan@agner.ch> wrote:
>=20
> > On 2016-11-01 00:10, Lukasz Majewski wrote:
> > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > >=20
> > > The use of the ipg clock was introduced with commit 7b27c160c681
> > > ("pwm: i.MX: fix clock lookup").
> > > In the commit message it was claimed that the ipg clock is
> > > enabled for register accesses. This is true for the ->config()
> > > callback, but not for the ->set_enable() callback. Given that the
> > > ipg clock is not consistently enabled for all register accesses
> > > we can assume that either it is not required at all or that the
> > > current code does not work. Remove the ipg clock code for now so
> > > that it's no longer in the way of refactoring the driver.
> > >=20
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Philipp Zabel <p.zabel@pengutronix.de> =20
> >=20
> > I have to NACK here, sorry guys.
> >=20
> > Just tested this on a i.MX 7, the kernel freezes in imx_pwm_config,
> > I guess that is where the code accesses a register first.
> >=20
> > The i.MX 7 DT (imx7s.dtsi) specifies the same clock for ipg and
> > per, but it seems that this clock is crucial for register access on
> > i.MX 7:
> >=20
> > clocks =3D <&clks IMX7D_PWM1_ROOT_CLK>,
> >          <&clks IMX7D_PWM1_ROOT_CLK>;
> > clock-names =3D "ipg", "per";         =20
> >=20
> > So since the "per" clock is the same in the i.MX 7 case,
> > imx_pwm_enable worked...
> >=20
> > I agree that the old code is a bit weird, especially that we get the
> > clock in imx_pwm_enable. It seems that all device trees specify a
> > "ipg" clock, so I guess we can get the clock at probe time for all
> > variants of this IP and just enable it on peripheral access...
>=20
> Or, we patch the code to take the per clk before accessing PWM regs,
> and release it once we're done.
> AFAIU, the IPG clock is only supposed to be enabled when the PWM takes
> its sources from the IPG channel,=20

+1

That is what TRM says about this clock.

> it has nothing to do we register
> accesses. If this is correct, then doing what you suggest implies
> abusing the IPG clk meaning.

+1

Best regards,
=C5=81ukasz Majewski

>=20
> >=20
> > --
> > Stefan
> >=20
> >=20
> > > ---
> > > [commit message text refactored by Lukasz Majewski
> > > <l.majewski@majess.pl>] ---
> > > Changes for v3:
> > > - New patch
> > > ---
> > >  drivers/pwm/pwm-imx.c | 19 +------------------
> > >  1 file changed, 1 insertion(+), 18 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > index d600fd5..70609ef2 100644
> > > --- a/drivers/pwm/pwm-imx.c
> > > +++ b/drivers/pwm/pwm-imx.c
> > > @@ -49,7 +49,6 @@
> > > =20
> > >  struct imx_chip {
> > >  	struct clk	*clk_per;
> > > -	struct clk	*clk_ipg;
> > > =20
> > >  	void __iomem	*mmio_base;
> > > =20
> > > @@ -204,17 +203,8 @@ static int imx_pwm_config(struct pwm_chip
> > > *chip, struct pwm_device *pwm, int duty_ns, int period_ns)
> > >  {
> > >  	struct imx_chip *imx =3D to_imx_chip(chip);
> > > -	int ret;
> > > -
> > > -	ret =3D clk_prepare_enable(imx->clk_ipg);
> > > -	if (ret)
> > > -		return ret;
> > > =20
> > > -	ret =3D imx->config(chip, pwm, duty_ns, period_ns);
> > > -
> > > -	clk_disable_unprepare(imx->clk_ipg);
> > > -
> > > -	return ret;
> > > +	return imx->config(chip, pwm, duty_ns, period_ns);
> > >  }
> > > =20
> > >  static int imx_pwm_enable(struct pwm_chip *chip, struct
> > > pwm_device *pwm) @@ -293,13 +283,6 @@ static int
> > > imx_pwm_probe(struct platform_device *pdev) return
> > > PTR_ERR(imx->clk_per); }
> > > =20
> > > -	imx->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
> > > -	if (IS_ERR(imx->clk_ipg)) {
> > > -		dev_err(&pdev->dev, "getting ipg clock failed
> > > with %ld\n",
> > > -				PTR_ERR(imx->clk_ipg));
> > > -		return PTR_ERR(imx->clk_ipg);
> > > -	}
> > > -
> > >  	imx->chip.ops =3D &imx_pwm_ops;
> > >  	imx->chip.dev =3D &pdev->dev;
> > >  	imx->chip.base =3D -1; =20
>=20


--Sig_/UWSjVe.ooAwz/Dl./jKvf0G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlg7yHMACgkQf9/hG2YwgjHq0wCgm5agRgXUuznBFuGZjyMXI2v1
SDsAn3jLxztMx8vsk5SnpYqm9iv0oGX6
=gr/F
-----END PGP SIGNATURE-----

--Sig_/UWSjVe.ooAwz/Dl./jKvf0G--
