From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 1/1] pwm: samsung: avoid setting manual update bit
 unnecessarily
Date: Thu, 28 Nov 2013 15:05:20 +0100
Message-ID: <2248800.7gDdjlWdkv@amdc1227>
References: <1383108704-3297-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:8472 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab3K1OF1 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Nov 2013 09:05:27 -0500
In-reply-to: <1383108704-3297-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, linux-samsung-soc@vger.kernel.org, tomasz.figa@gmail.com, Andrew Bresticker <abrestic@chromium.org>

Hi Sachin, Andrew,

On Wednesday 30 of October 2013 10:21:44 Sachin Kamat wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
> 
> When possible, avoid setting the manual update bit and starting/stopping
> the PWM when adjusting the PWM as it causes noticable flickering when
> setting the backlight brightness.

Hmm, I have tested the driver with a PWM-driven backlight and have not
observed any flickering, but you are right, a sudden manual update could
cause an instant transition of the TOUTn pin from 1 to 0, depending on
time of reconfiguration, so it's not a good behavior.

Please see my further comments inline, though.

> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/pwm/pwm-samsung.c |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index b59639e..6d23eb3 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -34,6 +34,7 @@
>  
>  #define REG_TCNTB(chan)			(0x0c + ((chan) * 0xc))
>  #define REG_TCMPB(chan)			(0x10 + ((chan) * 0xc))
> +#define REG_TCNTO(chan)			(0x14 + ((chan) * 0xc))
>  
>  #define TCFG0_PRESCALER_MASK		0xff
>  #define TCFG0_PRESCALER1_SHIFT		8
> @@ -234,15 +235,29 @@ static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
>  	unsigned int tcon_chan = to_tcon_channel(pwm->hwpwm);
>  	unsigned long flags;
> -	u32 tcon;
> +	u32 tcon, tcnt, tcnt_o;
>  
>  	spin_lock_irqsave(&samsung_pwm_lock, flags);
>  
>  	tcon = readl(our_chip->base + REG_TCON);
> +	tcnt = readl(our_chip->base + REG_TCNTB(pwm->hwpwm));
> +	tcnt_o = readl(our_chip->base + REG_TCNTO(pwm->hwpwm));
>  
> -	tcon &= ~TCON_START(tcon_chan);
> -	tcon |= TCON_MANUALUPDATE(tcon_chan);
> -	writel(tcon, our_chip->base + REG_TCON);
> +	/*
> +	 * If we've got a big value stuck in the PWM we need to adjust it using
> +	 * manualupdate.  The start bit needs to be off for that to work
> +	 * properly so we only do this if strictly necessary since it can cause
> +	 * the PWM to blink.
> +	 *
> +	 * We will also use manualupdate if we find that the autoreload bit
> +	 * wasn't set previously since the very first time the timer is
> +	 * configured we seem to need to kickstart the PWM.
> +	 */
> +	if ((tcnt_o > tcnt) || !(tcon & TCON_AUTORELOAD(tcon_chan))) {

Hmm, how is it possible to have a bigger value in TCNTO than in TCNTB?
When you start a timer the first time, you load it manually with a value
from TCNTB. Then, subsequent overflows (underflows?) will cause it to
reload the value of TCNTB automatically. So the value can be at most
equal to TCNTB.

Same for the autoreload bit. This driver allows only continuous operation
of the channel, where autoreload bit is always set, if the channel is
under operation.

> +		tcon &= ~TCON_START(tcon_chan);
> +		tcon |= TCON_MANUALUPDATE(tcon_chan);
> +		writel(tcon, our_chip->base + REG_TCON);
> +	}

In general, I believe that it would be enough to simply skip the manual
update when the channel is already running, by simply removing the call
to pwm_samsung_enable() from pwm_samsung_config(). I really can't
remember why I added it.

In fact, the most appropriate solution would be to stop the channel, write
new TCTNB and TCMPB values and restart it from where it stopped, as this
is the only method to assure that both TCTNB and TCMPB are loaded to TCNT
and TCMP atomically on next reload.

Best regards,
Tomasz

