From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] pwm: add Mediatek display PWM driver support
Date: Tue, 12 May 2015 15:00:05 +0200
Message-ID: <20150512130005.GS6325@pengutronix.de>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
 <1431336382-13167-3-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431336382-13167-3-git-send-email-yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, May 11, 2015 at 05:26:22PM +0800, YH Huang wrote:
> +
> +static int mtk_disp_pwm_probe(struct platform_device *pdev)
> +{
> +	struct mtk_disp_pwm_chip *pwm;

The struct mtk_disp_pwm_chip * is named 'mpc' in the other functions.
For consistency reasons you should do that here aswell.

> +	struct resource *r;
> +	int ret;
> +
> +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->dev = &pdev->dev;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwm->mmio_base = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(pwm->mmio_base))
> +		return PTR_ERR(pwm->mmio_base);
> +
> +	pwm->clk_main = devm_clk_get(&pdev->dev, "main");
> +	if (IS_ERR(pwm->clk_main))
> +		return PTR_ERR(pwm->clk_main);
> +	pwm->clk_mm = devm_clk_get(&pdev->dev, "mm");
> +	if (IS_ERR(pwm->clk_mm))
> +		return PTR_ERR(pwm->clk_mm);
> +
> +	ret = clk_prepare_enable(pwm->clk_main);
> +	if (ret < 0)
> +		return ret;
> +	ret = clk_prepare_enable(pwm->clk_mm);
> +	if (ret < 0) {
> +		clk_disable_unprepare(pwm->clk_main);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	pwm->chip.dev = &pdev->dev;
> +	pwm->chip.ops = &mtk_disp_pwm_ops;
> +	pwm->chip.base = -1;
> +	pwm->chip.npwm = NUM_PWM;
> +
> +	ret = pwmchip_add(&pwm->chip);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> +		return ret;

This error path leaves the clocks enabled.

> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_disp_pwm_remove(struct platform_device *pdev)
> +{
> +	struct mtk_disp_pwm_chip *pc = platform_get_drvdata(pdev);
> +
> +	if (WARN_ON(!pc))
> +		return -ENODEV;
> +
> +	clk_disable_unprepare(pc->clk_main);
> +	clk_disable_unprepare(pc->clk_mm);
> +
> +	return pwmchip_remove(&pc->chip);

You should first remove the pwmchip and disable the clocks afterwards.
Also note that this function can fail.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
