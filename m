From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Date: Fri, 30 Oct 2015 11:34:31 +0100
Message-ID: <1446201271.3334.22.camel@pengutronix.de>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
	 <1444988219.3541.3.camel@pengutronix.de>
	 <1445526750.27586.8.camel@mtksdaap41>
	 <1446133259.3274.52.camel@pengutronix.de>
	 <1446190900.17558.16.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46894 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758792AbbJ3Kee (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Oct 2015 06:34:34 -0400
In-Reply-To: <1446190900.17558.16.camel@mtksdaap41>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, yingjoe.chen@mediatek.com, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

Am Freitag, den 30.10.2015, 15:41 +0800 schrieb YH Huang:
> > That won't work if the gpio is still configured as input. How about I
> > add the GPIOD_ASIS change to my patch you remove that and the above from
> > yours?
> 
> I revise these two lines 
> if (pb->enable_gpio)
> 	gpiod_direction_output(pb->enable_gpio, 0);
> into
> if (pb->enable_gpio) {
> 	if(gpiod_get_value(pb->enable_gpio) == 0)
> 		gpiod_direction_output(pb->enable_gpio, 0);
> 	else
> 		gpiod_direction_output(pb->enable_gpio, 1);
> }

If the GPIO is still configured as an input, the return value of
gpiod_get_value could be random.

> I am not sure what "phandle" is working for.

The reasoning is that devices where there is no phandle link pointing to
the backlight (for example from a simple-panel node), we should keep the
current default behaviour (enable during probe).

> My change is like your patch but remove the "phandle related" and
> "gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT".
> Do we really need these?

See above, I wanted to be careful not to change existing behavior in
unexpected ways.

> Also, do you think it is right that I do the "pwm_enable(pb->pwm);"
> before "gpiod_set_value(pb->enable_gpio, 1);" in power on function?

That is unclear to me, because I'm sure that depends on the actual
constant current LED driver used.
I suspect EN and PWM pins are completely independent on a lot of them,
so enabling EN last should be ok to work around the problem that the PWM
pin state might not be well defined when the PWM is disabled.

For example, the STCS1A datasheet doesn't mention any order for enabling
EN and PWM. In the LP8545 datasheet, the modes of operation state
diagram suggests that enabling EN first is the proper way, on the other
hand the PWM interface characteristics table also lists a startup delay
for a rising EN edge while PWM is already active.

But I'm not sure that there aren't any LED drivers that somehow have a
problem with this order.

regards
Philipp
