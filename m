From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Date: Thu, 29 Oct 2015 16:40:59 +0100
Message-ID: <1446133259.3274.52.camel@pengutronix.de>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
	 <1444988219.3541.3.camel@pengutronix.de>
	 <1445526750.27586.8.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34857 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbbJ2PlG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Oct 2015 11:41:06 -0400
In-Reply-To: <1445526750.27586.8.camel@mtksdaap41>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

Hi YH,

Am Donnerstag, den 22.10.2015, 23:12 +0800 schrieb YH Huang:
> In the case of the panel disabled by the bootloader,
> your patch still has the following code and always enables the backlight
> in the probe function.
> pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> -						  GPIOD_OUT_HIGH);

You are right.

> What do you think if I remove these two lines in my patch?
> if (pb->enable_gpio)
> 	gpiod_direction_output(pb->enable_gpio, 0);

That won't work if the gpio is still configured as input. How about I
add the GPIOD_ASIS change to my patch you remove that and the above from
yours?

best regards
Philipp
