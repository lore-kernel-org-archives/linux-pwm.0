From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [RESEND PATCH] pwm-backlight: fix the panel power sequence
Date: Fri, 16 Oct 2015 10:36:16 +0200
Message-ID: <20151016083616.GA7858@pengutronix.de>
References: <1444959454-1516-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47725 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbbJPIgT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Oct 2015 04:36:19 -0400
Content-Disposition: inline
In-Reply-To: <1444959454-1516-1-git-send-email-yh.huang@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: YH Huang <yh.huang@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org

On Fri, Oct 16, 2015 at 09:37:34AM +0800, YH Huang wrote:
> In order to match the panel power sequence, disable the enable_gpio
> in the probe function. Also, reorder the code in the power_on and
> power_off function to match the timing.
> @@ -241,8 +242,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	pb->dev = &pdev->dev;
>  	pb->enabled = false;
>  
> -	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> -						  GPIOD_OUT_HIGH);
> +	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");

Please actually test your patches. This change here won't compile.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
