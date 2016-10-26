From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] backlight: pwm_bl: Check the pwm state for initial
 backlight power state
Date: Wed, 26 Oct 2016 13:13:29 +0100
Message-ID: <20161026121329.GR8574@dell>
References: <20160930070259.5710-1-peter.ujfalusi@ti.com>
 <20160930070259.5710-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33556 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755370AbcJZMK4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Oct 2016 08:10:56 -0400
Received: by mail-wm0-f50.google.com with SMTP id o81so3166307wma.0
        for <linux-pwm@vger.kernel.org>; Wed, 26 Oct 2016 05:10:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160930070259.5710-3-peter.ujfalusi@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: thierry.reding@gmail.com, jingoohan1@gmail.com, tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de

On Fri, 30 Sep 2016, Peter Ujfalusi wrote:

> If the pwm is not enabled the backlight initially should not be enabled
> either if we have booted with DT and there is a phandle pointing to the
> backlight node.
> 
> The patch extends the checks to decide if we should keep the backlight off
> initially.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 4 ++++
>  1 file changed, 4 insertions(+)

Makes sense to me.

I'm going to apply this until someone screams at me.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 9bc4715bf116..e4326bbf807f 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -223,6 +223,10 @@ static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
>  	if (!regulator_is_enabled(pb->power_supply))
>  		return FB_BLANK_POWERDOWN;
>  
> +	/* The pwm is disabled, keep it like this */
> +	if (!pwm_is_enabled(pb->pwm))
> +		return FB_BLANK_POWERDOWN;
> +
>  	return FB_BLANK_UNBLANK;
>  }
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
