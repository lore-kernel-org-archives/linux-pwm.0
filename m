From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Subject: Re: [PATCH] pwm: Add clk enable/disable for
 pwm_samsung_enable/pwm_samsung_disable
Date: Wed, 15 Apr 2015 10:34:07 +0200
Message-ID: <1429086847.22057.159.camel@collabora.co.uk>
References: <1429034708-4537-1-git-send-email-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:36034 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbbDOIeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Apr 2015 04:34:10 -0400
In-Reply-To: <1429034708-4537-1-git-send-email-linux.amoon@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On Wed, 2015-04-15 at 03:35 +0930, Anand Moon wrote:
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index 3e9b583..b579753 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -247,6 +247,7 @@ static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	tcon &= ~TCON_MANUALUPDATE(tcon_chan);
>  	tcon |= TCON_START(tcon_chan) | TCON_AUTORELOAD(tcon_chan);
>  	writel(tcon, our_chip->base + REG_TCON);
> +	clk_prepare_enable(our_chip->base_clk);
>  
>  	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
>  
> @@ -265,6 +266,7 @@ static void pwm_samsung_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	tcon = readl(our_chip->base + REG_TCON);
>  	tcon &= ~TCON_AUTORELOAD(tcon_chan);
>  	writel(tcon, our_chip->base + REG_TCON);
> +	clk_disable_unprepare(our_chip->base_clk);
>  
>  	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
>  }

As far as i can tell this code doesn't have any effect. 

clk_enable is refcounted, so the clock will stay enabled for as long as
the driver is loaded (as it's enabled in _probe). Your code above just
raises and lowers the clocks enabled refcount, but won't actually ever
cause it to be disabled.

With respect to trying to disabling the clocks on pwm_disable, that will
need some more work to ensure the output signal has the expected level
when you turn of the clock. Specifically, when disabling from a non-100%
duty state the driver relies on the PWM turning the output signal low at
the end of a duty cycle. However if you turn off the clock at the start
of a duty cycle while the output signal is still high it will
unexpectedly remain high.


-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
