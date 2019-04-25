From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 5/7] pwm: atmel-hlcdc: add compatible for SAM9X60
 HLCDC's PWM
Date: Thu, 25 Apr 2019 09:31:32 +0100
Message-ID: <20190425083132.GD14758@dell>
References: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
 <1551780434-4580-6-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551780434-4580-6-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 05 Mar 2019, Claudiu.Beznea@microchip.com wrote:

> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add compatible string for SAM9X60 HLCDC's PWM.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index 54c6633d9b5d..331ca0233d9e 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -246,6 +246,9 @@ static const struct of_device_id atmel_hlcdc_dt_ids[] = {
>  		.compatible = "atmel,sama5d4-hlcdc",
>  		.data = &atmel_hlcdc_pwm_sama5d3_errata,
>  	},
> +	{
> +		.compatible = "microchip,sam9x60-hlcdc",
> +	},

Please make this a single line entry, like the one below.

>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, atmel_hlcdc_dt_ids);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
