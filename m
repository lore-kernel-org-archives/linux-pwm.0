From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Date: Thu, 22 Oct 2015 23:12:30 +0800
Message-ID: <1445526750.27586.8.camel@mtksdaap41>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
	 <1444988219.3541.3.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:39970 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756693AbbJVPMe (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Oct 2015 11:12:34 -0400
In-Reply-To: <1444988219.3541.3.camel@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

On Fri, 2015-10-16 at 11:36 +0200, Philipp Zabel wrote:
> Am Freitag, den 16.10.2015, 17:17 +0800 schrieb YH Huang:
> > In order to match the panel power sequence, disable the enable_gpio
> > in the probe function. Also, reorder the code in the power_on and
> > power_off function to match the timing.
> 
> Could you also have a look at the "pwm-backlight: Avoid backlight
> flicker when probed from DT" patch?
> I think in case of a panel left enabled by the bootloader, your patch
> will disable the backlight for a short time.
> 
> best regards
> Philipp
> 
In the case of the panel disabled by the bootloader,
your patch still has the following code and always enables the backlight
in the probe function.
pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
-						  GPIOD_OUT_HIGH);

What do you think if I remove these two lines in my patch?
if (pb->enable_gpio)
	gpiod_direction_output(pb->enable_gpio, 0);


Regards,
YH Huang
