From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/7] drm: atmel-hlcdc: add config option for clock
 selection
Date: Thu, 28 Feb 2019 22:25:58 +0100
Message-ID: <20190228212558.GB30188@ravnborg.org>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <1551284609-14594-2-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551284609-14594-2-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Claudiu

On Wed, Feb 27, 2019 at 04:24:16PM +0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> SAM9x60 LCD Controller has no option to select clock source as previous
> controllers have. To be able to use the same driver even for this LCD
> controller add a config option to know if controller supports this.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 12 +++++++-----
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h   |  2 ++
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 8070a558d7b1..17a7a18f6a07 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -78,7 +78,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  	unsigned long mode_rate;
>  	struct videomode vm;
>  	unsigned long prate;
> -	unsigned int cfg;
> +	unsigned int mask = ATMEL_HLCDC_CLKDIV_MASK | ATMEL_HLCDC_CLKPOL;
> +	unsigned int cfg = 0;
>  	int div;
Here cfg and mask has initial values.

>  
>  	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
> @@ -101,7 +102,10 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  		     (adj->crtc_hdisplay - 1) |
>  		     ((adj->crtc_vdisplay - 1) << 16));
>  
> -	cfg = ATMEL_HLCDC_CLKSEL;
> +	if (!crtc->dc->desc->fixed_clksrc) {
> +		cfg = ATMEL_HLCDC_CLKSEL;
> +		mask |= ATMEL_HLCDC_CLKSEL;
> +	}
And here mask is bitwise or with ATMEL_HLCDC_CLKSEL - fine.
But cfg is directly assigned.
If cfg was bitwise or the ATMEL_HLCDC_CLKSEL value then the code was prepared
to have extra flags added above these lines.

Only a small change and no functional difference.

With or without this change:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
