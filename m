From: Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
Date: Tue, 3 Dec 2019 07:00:40 +0000
Message-ID: <AM0PR04MB4481AD45530915B0BA18C45F88420@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
 <1575352925-17271-2-git-send-email-peng.fan@nxp.com>
 <20191203065751.w23dypag4745qv7i@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191203065751.w23dypag4745qv7i@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>
List-Id: linux-pwm@vger.kernel.org

> Subject: Re: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
>=20
> On Tue, Dec 03, 2019 at 06:04:27AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Use platform_irq_count to replace of_irq_count
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1:
> >  Code inspection, not tested
> >
> >  drivers/gpio/gpio-bcm-kona.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-bcm-kona.c
> > b/drivers/gpio/gpio-bcm-kona.c index 4122683eb1f9..c50721980a7c
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
> >  #include <linux/irqchip/chained_irq.h> @@ -586,7 +585,7 @@ static int
> > bcm_kona_gpio_probe(struct platform_device *pdev)
> >
> >  	kona_gpio->gpio_chip =3D template_chip;
> >  	chip =3D &kona_gpio->gpio_chip;
> > -	kona_gpio->num_bank =3D of_irq_count(dev->of_node);
> > +	kona_gpio->num_bank =3D platform_irq_count(pdev);
>=20
> of_irq_count returns 0 or a positive int while platform_irq_count might r=
eturn
> a negative error code. This needs handling. Also I wonder why
> platform_irq_count() is better than of_irq_count() which would be good to
> describe in the commit log.

Inspired from https://lkml.org/lkml/2015/11/18/466
From Rob:
"
So I started looking at why you are using of_irq_count which drivers
shouldn't need to. In patch 5 you use it to allocate memory to store
the irq names, then use them here...
"

Is this ok?

Thanks,
Peng.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C36e86
> 59eca384830eee508d777be21cc%7C686ea1d3bc2b4c6fa92cd99c5c301635
> %7C0%7C0%7C637109530809227993&amp;sdata=3Dy95EHGlmw12IVVlWoiUiS
> cQzO7GIBjQmnAfYrtd7P6k%3D&amp;reserved=3D0 |
