From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] pwm-backlight: Avoid backlight flicker when probed from
 DT
Date: Mon, 02 Nov 2015 17:30:47 +0100
Message-ID: <1446481847.3442.61.camel@pengutronix.de>
References: <1446133906-3076-1-git-send-email-p.zabel@pengutronix.de>
	 <20151030182113.GH4058@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59010 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbbKBQa6 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Nov 2015 11:30:58 -0500
In-Reply-To: <20151030182113.GH4058@x1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, YH Huang <yh.huang@mediatek.com>, Christian Gmeiner <christian.gmeiner@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hi Lee,

Am Freitag, den 30.10.2015, 18:21 +0000 schrieb Lee Jones:
> > @@ -264,12 +266,32 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
> >  	}
> >  
> > +	phandle = of_find_property(pdev->dev.of_node, "phandle", NULL) != NULL;
> 
> This is a little ugly.
> 
> If this is the only way to identify the probedness of a device then
> you probably want to neaten it up a little.  I suggest something along
> the lines of:
>
> if (of_find_property(pdev->dev.of_node, "phandle", NULL))
> 	already_probed = true;
> 
> Also, do you also want to check for "linux,phandle", as this is always
> catered for in drivers/of/*

Thanks for pointing this out. I suppose I should just check
pdev->dev.of_node->phandle != 0 instead. That will already be
initialized by unflatten_dt_node if either property was found.

regards
Philipp
