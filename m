From: Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH v2 2/2] gpio: bcm-kona: use platform_irq_count
Date: Wed, 4 Dec 2019 08:41:14 +0000
Message-ID: <AM0PR04MB4481D76A9779C2DA7B1331C3885D0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
 <1575433106-16171-2-git-send-email-peng.fan@nxp.com>
 <20191204072744.b7ytzi5gffjcq6sj@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204072744.b7ytzi5gffjcq6sj@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>
List-Id: linux-pwm@vger.kernel.org

> Subject: Re: [PATCH v2 2/2] gpio: bcm-kona: use platform_irq_count
>=20
> On Wed, Dec 04, 2019 at 04:20:45AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > platform_irq_count() is the more generic way (independent of device
> > trees) to determine the count of available interrupts. So use this
> > instead.
> >
> > As platform_irq_count() might return an error code (which of_irq_count
> > doesn't) some additional handling is necessary.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  Update commit log, and add err handling  Not tested, just code
> > inspection
> >
> >  drivers/gpio/gpio-bcm-kona.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-bcm-kona.c
> > b/drivers/gpio/gpio-bcm-kona.c index 4122683eb1f9..52ff56166263
> 100644
> > --- a/drivers/gpio/gpio-bcm-kona.c
> > +++ b/drivers/gpio/gpio-bcm-kona.c
> > @@ -19,7 +19,6 @@
> >  #include <linux/io.h>
> >  #include <linux/gpio/driver.h>
> >  #include <linux/of_device.h>
> > -#include <linux/of_irq.h>
> >  #include <linux/init.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/irqchip/chained_irq.h> @@ -586,11 +585,18 @@ static
> > int bcm_kona_gpio_probe(struct platform_device *pdev)
> >
> >  	kona_gpio->gpio_chip =3D template_chip;
> >  	chip =3D &kona_gpio->gpio_chip;
> > -	kona_gpio->num_bank =3D of_irq_count(dev->of_node);
> > -	if (kona_gpio->num_bank =3D=3D 0) {
> > +	ret =3D platform_irq_count(pdev);
> > +	if (!ret) {
> >  		dev_err(dev, "Couldn't determine # GPIO banks\n");
> >  		return -ENOENT;
> > +	} else if (ret < 0) {
> > +		if (ret !=3D -EPROBE_DEFER)
> > +			dev_err(dev, "Couldn't determine GPIO banks: %d\n",
> > +				ret);
>=20
> You can use the new %pe feature here:

Checkpatch reports warning:

WARNING: Invalid vsprintf pointer extension '%pe'
#49: FILE: drivers/gpio/gpio-bcm-kona.c:593:
+               if (ret !=3D -EPROBE_DEFER)
+                       dev_err(dev, "Couldn't determine GPIO banks: (%pe)\=
n",
+                               ERR_PTR(ret));

Thanks,
Peng.

>=20
> 	dev_err(dev, "Couldn't determine GPIO banks: %pe\n",
> 		ERR_PTR(ret));
>=20
> > +		return ret;
> >  	}
> > +	kona_gpio->num_bank =3D ret;
> > +
>=20
> Looks otherwise ok.
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C8c566
> 59ba01b4b5db43608d7788b77fa%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C637110412715339679&amp;sdata=3DMDjn8C9mtDqZCN01nOT
> KhVJoLiqPue8In5v5OT91B6Y%3D&amp;reserved=3D0 |
