From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCH] pwm: pca9685: depends on I2C rather than REGMAP_I2C
Date: Tue, 17 Dec 2013 10:15:30 +0100
Message-ID: <20131217091530.GL25478@pengutronix.de>
References: <1387252289.4816.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54475 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab3LQJPd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Dec 2013 04:15:33 -0500
Content-Disposition: inline
In-Reply-To: <1387252289.4816.1.camel@phoenix>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org

On Tue, Dec 17, 2013 at 11:51:29AM +0800, Axel Lin wrote:
> REGMAP_I2C is not a visible config option.
> Thus make PWM_PCA9685 depend on I2c and then select REGMAP_I2C.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 77aef3b..7139e1d 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -122,7 +122,8 @@ config PWM_MXS
>  
>  config PWM_PCA9685
>  	tristate "NXP PCA9685 PWM driver"
> -	depends on OF && REGMAP_I2C
> +	depends on OF && I2C
> +	select REGMAP_I2C
>  	help
>  	  Generic PWM framework driver for NXP PCA9685 LED controller.
>  

Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
