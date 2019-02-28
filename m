From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 6/7] drm: atmel-hlcdc: enable sys_clk during
 initalization.
Date: Thu, 28 Feb 2019 22:55:19 +0100
Message-ID: <20190228215519.GE30188@ravnborg.org>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <1551284609-14594-7-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551284609-14594-7-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sandeep.Sheriker@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Claudiu

On Wed, Feb 27, 2019 at 04:24:40PM +0000, Claudiu.Beznea@microchip.com wrote:
> From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> 
> For SAM9X60 SoC, sys_clk is through lcd_gclk clock source and this
> needs to be enabled before enabling lcd_clk.

We have "ownership" of the clocks in the mfd device.
So it would make more sense to let the mfd device handle
the base clocks.
In other words - what about pushing enable of perigh_clk and sys_clk to
the mfd driver.

This may have the nice side-effect that we avoid
that both the drm driver and the pwm driver enable/disable the periph_clk
as it is today.

Another comment - fixed_clksrc is used to determine if sys_clk is enabled.
But that flag is about the clksource selection, and it is just a coincidence
that the same flag can be used here.
Why we cannot always enable sys_clk? Do we need to do this only
for sam9x60?
IF yes, then add a new falg. If no, then skip the flag.

	Sam


> 
> Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> [claudiu.beznea@microchip.com: add fixed_clksrc checks]
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> index 0be13eceedba..8bf51f853721 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> @@ -625,10 +625,18 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>  	dc->hlcdc = dev_get_drvdata(dev->dev->parent);
>  	dev->dev_private = dc;
>  
> +	if (dc->desc->fixed_clksrc) {
> +		ret = clk_prepare_enable(dc->hlcdc->sys_clk);
> +		if (ret) {
> +			dev_err(dev->dev, "failed to enable sys_clk\n");
> +			goto err_destroy_wq;
> +		}
> +	}
> +
>  	ret = clk_prepare_enable(dc->hlcdc->periph_clk);
>  	if (ret) {
>  		dev_err(dev->dev, "failed to enable periph_clk\n");
> -		goto err_destroy_wq;
> +		goto err_sys_clk_disable;
>  	}
>  
>  	pm_runtime_enable(dev->dev);
> @@ -664,6 +672,9 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>  err_periph_clk_disable:
>  	pm_runtime_disable(dev->dev);
>  	clk_disable_unprepare(dc->hlcdc->periph_clk);
> +err_sys_clk_disable:
> +	if (dc->desc->fixed_clksrc)
> +		clk_disable_unprepare(dc->hlcdc->sys_clk);
>  
>  err_destroy_wq:
>  	destroy_workqueue(dc->wq);
> @@ -688,6 +699,8 @@ static void atmel_hlcdc_dc_unload(struct drm_device *dev)
>  
>  	pm_runtime_disable(dev->dev);
>  	clk_disable_unprepare(dc->hlcdc->periph_clk);
> +	if (dc->desc->fixed_clksrc)
> +		clk_disable_unprepare(dc->hlcdc->sys_clk);
>  	destroy_workqueue(dc->wq);
>  }
>  
> @@ -805,6 +818,8 @@ static int atmel_hlcdc_dc_drm_suspend(struct device *dev)
>  	regmap_read(regmap, ATMEL_HLCDC_IMR, &dc->suspend.imr);
>  	regmap_write(regmap, ATMEL_HLCDC_IDR, dc->suspend.imr);
>  	clk_disable_unprepare(dc->hlcdc->periph_clk);
> +	if (dc->desc->fixed_clksrc)
> +		clk_disable_unprepare(dc->hlcdc->sys_clk);
>  
>  	return 0;
>  }
> @@ -814,6 +829,8 @@ static int atmel_hlcdc_dc_drm_resume(struct device *dev)
>  	struct drm_device *drm_dev = dev_get_drvdata(dev);
>  	struct atmel_hlcdc_dc *dc = drm_dev->dev_private;
>  
> +	if (dc->desc->fixed_clksrc)
> +		clk_prepare_enable(dc->hlcdc->sys_clk);
>  	clk_prepare_enable(dc->hlcdc->periph_clk);
>  	regmap_write(dc->hlcdc->regmap, ATMEL_HLCDC_IER, dc->suspend.imr);
>  
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
