From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] pwm: imx: Support very long period lengths
Date: Mon, 28 Apr 2014 11:22:55 +0200
Message-ID: <20140428092255.GO5858@pengutronix.de>
References: <1398675331-10980-1-git-send-email-xobs@kosagi.com>
 <1398675331-10980-2-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48024 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbaD1JW6 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Apr 2014 05:22:58 -0400
Content-Disposition: inline
In-Reply-To: <1398675331-10980-2-git-send-email-xobs@kosagi.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sean Cross <xobs@kosagi.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Apr 28, 2014 at 04:55:31PM +0800, Sean Cross wrote:
> The IMX PWM block supports using both the system clock and a 32 kHz
> clock for driving PWM events.  For very long period lengths, use the
> 32 kHz clock instead of the high-speed clock.
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> ---
>  drivers/pwm/pwm-imx.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index cc47733..8410455 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -36,9 +36,11 @@
>  #define MX3_PWMCR_DOZEEN                (1 << 24)
>  #define MX3_PWMCR_WAITEN                (1 << 23)
>  #define MX3_PWMCR_DBGEN			(1 << 22)
> +#define MX3_PWMCR_CLKSRC_IPG_32K  (3 << 16)
>  #define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
>  #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
>  #define MX3_PWMCR_EN              (1 << 0)
> +#define MX3_SLOW_THRESHOLD_NS	100000
>  
>  struct imx_chip {
>  	struct clk	*clk_per;
> @@ -107,7 +109,13 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>  	unsigned long period_cycles, duty_cycles, prescale;
>  	u32 cr;
>  
> -	c = clk_get_rate(imx->clk_per);
> +	if (duty_ns > MX3_SLOW_THRESHOLD_NS) {

If anything you have to check the period_cycles, not the duty_cycles.

100000 seems to be some arbitrary value suitable for some unspecified
ipg clock rate. I think you should use it when the period_cycles
register overflows.

> +		cr = MX3_PWMCR_CLKSRC_IPG_32K;
> +		c = 32768;

How about providing a proper clock instead of hardcoding this?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
