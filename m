From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm-backlight: fix the panel power sequence
Date: Wed, 14 Oct 2015 13:27:14 +0100
Message-ID: <20151014122714.GI32409@x1>
References: <1442414556-32381-1-git-send-email-yh.huang@mediatek.com>
 <1444816875.31675.2.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38505 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbbJNM1S (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Oct 2015 08:27:18 -0400
Received: by wieq12 with SMTP id q12so80612855wie.1
        for <linux-pwm@vger.kernel.org>; Wed, 14 Oct 2015 05:27:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444816875.31675.2.camel@mtksdaap41>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com

On Wed, 14 Oct 2015, YH Huang wrote:

> Hi all,
>=20
> If you have any suggestion, please let me know.
> Thanks.

Please don't do that.

If you think the patch has fallen through the gaps, please just RESEND
it, like [RESEND vX] $subject.

> On Wed, 2015-09-16 at 22:42 +0800, YH Huang wrote:
> > In order to match the panel power sequence, disable the enable_gpio
> > in the probe function. Also, reorder the code in the power_on and
> > power_off function to match the timing.
> >=20
> > Signed-off-by: YH Huang <yh.huang@mediatek.com>
> > ---
> >  drivers/video/backlight/pwm_bl.c |   15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backl=
ight/pwm_bl.c
> > index eff379b..99eca1e 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -54,10 +54,11 @@ static void pwm_backlight_power_on(struct pwm_b=
l_data *pb, int brightness)
> >  	if (err < 0)
> >  		dev_err(pb->dev, "failed to enable power supply\n");
> > =20
> > +	pwm_enable(pb->pwm);
> > +
> >  	if (pb->enable_gpio)
> >  		gpiod_set_value(pb->enable_gpio, 1);
> > =20
> > -	pwm_enable(pb->pwm);
> >  	pb->enabled =3D true;
> >  }
> > =20
> > @@ -66,12 +67,12 @@ static void pwm_backlight_power_off(struct pwm_=
bl_data *pb)
> >  	if (!pb->enabled)
> >  		return;
> > =20
> > -	pwm_config(pb->pwm, 0, pb->period);
> > -	pwm_disable(pb->pwm);
> > -
> >  	if (pb->enable_gpio)
> >  		gpiod_set_value(pb->enable_gpio, 0);
> > =20
> > +	pwm_config(pb->pwm, 0, pb->period);
> > +	pwm_disable(pb->pwm);
> > +
> >  	regulator_disable(pb->power_supply);
> >  	pb->enabled =3D false;
> >  }
> > @@ -241,8 +242,7 @@ static int pwm_backlight_probe(struct platform_=
device *pdev)
> >  	pb->dev =3D &pdev->dev;
> >  	pb->enabled =3D false;
> > =20
> > -	pb->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable",
> > -						  GPIOD_OUT_HIGH);
> > +	pb->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable")=
;
> >  	if (IS_ERR(pb->enable_gpio)) {
> >  		ret =3D PTR_ERR(pb->enable_gpio);
> >  		goto err_alloc;
> > @@ -264,6 +264,9 @@ static int pwm_backlight_probe(struct platform_=
device *pdev)
> >  		pb->enable_gpio =3D gpio_to_desc(data->enable_gpio);
> >  	}
> > =20
> > +	if (pb->enable_gpio)
> > +		gpiod_direction_output(pb->enable_gpio, 0);
> > +
> >  	pb->power_supply =3D devm_regulator_get(&pdev->dev, "power");
> >  	if (IS_ERR(pb->power_supply)) {
> >  		ret =3D PTR_ERR(pb->power_supply);
>=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
