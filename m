From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] pwm: jz4740: Add support for the JZ4725B
Date: Sun, 24 May 2020 19:37:11 +0200
Message-ID: <20200524173711.ofprgoueyimhkowj@pengutronix.de>
References: <20200413121445.72996-1-paul@crapouillou.net>
 <20200413121445.72996-3-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbgEXRhO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 May 2020 13:37:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9533CC061A0E
        for <linux-pwm@vger.kernel.org>; Sun, 24 May 2020 10:37:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200413121445.72996-3-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 02:14:45PM +0200, Paul Cercueil wrote:
> The PWM hardware in the JZ4725B works the same as in the JZ4740, but has
> only six channels available.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     I did not add documentation for the new jz4725b-pwm compatible
>     string on purpose. The reason is that the documentation file
>     for the Timer/Counter Unit (TCU) of Ingenic SoCs will be
>     completely rewritten from .txt to YAML in a separate patchset.
> 
>  drivers/pwm/pwm-jz4740.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index f566f9d248d6..bb27934fb6c2 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -22,6 +22,10 @@
>  
>  #define NUM_PWM 8
>  
> +struct soc_info {
> +	unsigned int num_pwms;
> +};
> +
>  struct jz4740_pwm_chip {
>  	struct pwm_chip chip;
>  	struct regmap *map;
> @@ -36,7 +40,7 @@ static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz,
>  				   unsigned int channel)
>  {
>  	/* Enable all TCU channels for PWM use by default except channels 0/1 */
> -	u32 pwm_channels_mask = GENMASK(NUM_PWM - 1, 2);
> +	u32 pwm_channels_mask = GENMASK(jz->chip.npwm - 1, 2);
>  
>  	device_property_read_u32(jz->chip.dev->parent,
>  				 "ingenic,pwm-channels-mask",
> @@ -214,6 +218,7 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct jz4740_pwm_chip *jz4740;
> +	const struct soc_info *info = device_get_match_data(dev);
>  
>  	jz4740 = devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
>  	if (!jz4740)
> @@ -227,8 +232,8 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
>  
>  	jz4740->chip.dev = dev;
>  	jz4740->chip.ops = &jz4740_pwm_ops;
> -	jz4740->chip.npwm = NUM_PWM;
>  	jz4740->chip.base = -1;
> +	jz4740->chip.npwm = info ? info->num_pwms : NUM_PWM;

Can info be actually NULL? I don't think so, so you can just use
info->num_pwms here and drop the definition of NUM_PWM.

>  	jz4740->chip.of_xlate = of_pwm_xlate_with_flags;
>  	jz4740->chip.of_pwm_n_cells = 3;
>  

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
