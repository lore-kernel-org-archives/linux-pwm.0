From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/2] Add PWM fan controller driver for LGM SoC
Date: Thu, 25 Jun 2020 07:58:18 +0200
Message-ID: <20200625055818.nv5snblkm4nwvxw2@taurus.defre.kleine-koenig.org>
References: <cover.1592474693.git.rahul.tanwar@linux.intel.com>
 <79fefda4aad5ebeb368129375bf128b74ed12224.1592474693.git.rahul.tanwar@linux.intel.com>
 <41a3c509e8d72d1e1c45b6b87f52f0a75018e6b0.camel@pengutronix.de>
 <25560ece-5d71-562d-359a-490d70cc5453@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xfbgim4wbqyditz2"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389600AbgFYF6Z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 25 Jun 2020 01:58:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B9DC061573
        for <linux-pwm@vger.kernel.org>; Wed, 24 Jun 2020 22:58:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <25560ece-5d71-562d-359a-490d70cc5453@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, andriy.shevchenko@intel.com, songjun.Wu@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com


--xfbgim4wbqyditz2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 12:23:54PM +0800, Tanwar, Rahul wrote:
>=20
> Hi Philipp,
>=20
> On 18/6/2020 8:25 pm, Philipp Zabel wrote:
> > Hi Rahul,
> >
> > On Thu, 2020-06-18 at 20:05 +0800, Rahul Tanwar wrote:
> >> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
> >> This PWM controller does not have any other consumer, it is a
> >> dedicated PWM controller for fan attached to the system. Add
> >> driver for this PWM fan controller.
> >>
> >> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> >> ---
> >>  drivers/pwm/Kconfig         |   9 +
> >>  drivers/pwm/Makefile        |   1 +
> >>  drivers/pwm/pwm-intel-lgm.c | 400 +++++++++++++++++++++++++++++++++++=
+++++++++
> >>  3 files changed, 410 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
> >>
> > [...]
> >> diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
> >> new file mode 100644
> >> index 000000000000..3c7077acb161
> >> --- /dev/null
> >> +++ b/drivers/pwm/pwm-intel-lgm.c
> >> @@ -0,0 +1,400 @@
> > [...]
> >> +static int lgm_pwm_probe(struct platform_device *pdev)
> >> +{
> >> +	struct lgm_pwm_chip *pc;
> >> +	struct device *dev =3D &pdev->dev;
> >> +	void __iomem *io_base;
> >> +	int ret;
> >> +
> >> +	pc =3D devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> >> +	if (!pc)
> >> +		return -ENOMEM;
> >> +
> >> +	io_base =3D devm_platform_ioremap_resource(pdev, 0);
> >> +	if (IS_ERR(io_base))
> >> +		return PTR_ERR(io_base);
> >> +
> >> +	pc->regmap =3D devm_regmap_init_mmio(dev, io_base, &pwm_regmap_confi=
g);
> >> +	if (IS_ERR(pc->regmap)) {
> >> +		ret =3D PTR_ERR(pc->regmap);
> >> +		dev_err(dev, "failed to init register map: %pe\n", pc->regmap);
> >> +		return ret;
> >> +	}
> >> +
> >> +	pc->clk =3D devm_clk_get(dev, NULL);
> >> +	if (IS_ERR(pc->clk)) {
> >> +		ret =3D PTR_ERR(pc->clk);
> >> +		dev_err(dev, "failed to get clock: %pe\n", pc->clk);
> >> +		return ret;
> >> +	}
> >> +
> >> +	pc->rst =3D devm_reset_control_get(dev, NULL);
> >> +	if (IS_ERR(pc->rst)) {
> >> +		ret =3D PTR_ERR(pc->rst);
> >> +		dev_err(dev, "failed to get reset control: %pe\n", pc->rst);
> >> +		return ret;
> >> +	}
> > Please use devm_reset_control_get_exclusive() to make it explicit an
> > that exclusive reset control is requested. Given how the reset control
> > is used, I think this driver could also use
> > devm_reset_control_get_shared() to potentially allow sharing a reset
> > line with other devices.
>=20
> devm_reset_control_get() is a wrapper for devm_reset_control_get_exclusiv=
e().
> Code as below:
> static inline struct reset_control *devm_reset_control_get(
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 struct device *dev, const char *id)
> {
> =A0=A0=A0=A0=A0=A0=A0 return devm_reset_control_get_exclusive(dev, id);
> }
> Am i missing something else?

Obviously you're missing the comment above of_reset_control_get about
some functions being compatibility wrappers.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xfbgim4wbqyditz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl70PPcACgkQwfwUeK3K
7AkhKQf+O1Q3b69RDRigsJQ6oPI7YpwFFFIk6H9cC3YPWKTX1Fc/3BGAL2kPX0om
ASGuU6fBKG1EXvSLQjcQcY03Q2I3B+uCjbH4KpiGlbNeOJ0iYgKNc0OQJ3qDUqJZ
PqTLKAB1RWap9qT5URgQ/gCI8bkzGgmdamsCWVSRmCn3Sbw/vVybx2SsvOYUk2QJ
94wrsYQeUi8+FoyF6xE6MT6oOJ8ospIAFekBNZnFHIeGXlcPNqNLH1Djg517SJyE
mbHmTn7kWKbRV4BiOWIufF5PCyo5Ep0GPK4+nUHTr8mzsfd6ucH46hZVnoeeYfpY
kwm2SvOhRB6/L3ZiqUL/sg1gO9w48A==
=I8HR
-----END PGP SIGNATURE-----

--xfbgim4wbqyditz2--
