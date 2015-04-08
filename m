From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 5/6] pwm: samsung: Fix output race on disabling
Date: Wed, 08 Apr 2015 10:28:11 +0200
Message-ID: <20150408102811.219b964f@amdc2363>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
 <1427387955-5129-6-git-send-email-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1427387955-5129-6-git-send-email-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Anand,

> From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> When disabling the samsung PWM the output state remains at the level
> it was in the end of a pwm cycle. In other words, calling pwm_disable
> when at 100% duty will keep the output active, while at all other
> setting the output will go/stay inactive. On top of that the samsung
> PWM settings are double-buffered, which means the new settings only
> get applied at the start of a new PWM cycle.
> 
> This results in a race if the PWM is at 100% duty and a driver calls:
>   pwm_config (pwm, 0, period);
>   pwm_disable (pwm);
> 
> In this case the PWMs output will unexpectedly stay active, unless a
> new PWM cycle happened to start between the register writes in
> _config and _disable. As far as i can tell this is a regression
> introduced by 3bdf878, before that a call to pwm_config would call
> pwm_samsung_enable which, while heavy-handed, made sure the expected
> settings were live.
> 
> To resolve this, while not re-introducing the issues 3bdf878
> (flickering as the PWM got reset while in a PWM cycle). Only force an
> update of the settings when at 100% duty, which shouldn't have a
> noticeable effect on the output but is enough to ensure the behaviour
> is as expected on disable.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pwm/pwm-samsung.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index 3e9b583..649f6c4 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -269,12 +269,31 @@ static void pwm_samsung_disable(struct pwm_chip
> *chip, struct pwm_device *pwm)
> spin_unlock_irqrestore(&samsung_pwm_lock, flags); }
>  
> +static void pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
> +				      struct pwm_device *pwm)
> +{
> +	unsigned int tcon_chan = to_tcon_channel(pwm->hwpwm);
> +	u32 tcon;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&samsung_pwm_lock, flags);
> +
> +	tcon = readl(chip->base + REG_TCON);
> +	tcon |= TCON_MANUALUPDATE(tcon_chan);
> +	writel(tcon, chip->base + REG_TCON);
> +
> +	tcon &= ~TCON_MANUALUPDATE(tcon_chan);
> +	writel(tcon, chip->base + REG_TCON);
> +
> +	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
> +}
> +
>  static int pwm_samsung_config(struct pwm_chip *chip, struct
> pwm_device *pwm, int duty_ns, int period_ns)
>  {
>  	struct samsung_pwm_chip *our_chip =
> to_samsung_pwm_chip(chip); struct samsung_pwm_channel *chan =
> pwm_get_chip_data(pwm);
> -	u32 tin_ns = chan->tin_ns, tcnt, tcmp;
> +	u32 tin_ns = chan->tin_ns, tcnt, tcmp, oldtcmp;
>  
>  	/*
>  	 * We currently avoid using 64bit arithmetic by using the
> @@ -288,6 +307,7 @@ static int pwm_samsung_config(struct pwm_chip
> *chip, struct pwm_device *pwm, return 0;
>  
>  	tcnt = readl(our_chip->base + REG_TCNTB(pwm->hwpwm));
> +	oldtcmp = readl(our_chip->base + REG_TCMPB(pwm->hwpwm));
>  
>  	/* We need tick count for calculation, not last tick. */
>  	++tcnt;
> @@ -335,6 +355,15 @@ static int pwm_samsung_config(struct pwm_chip
> *chip, struct pwm_device *pwm, writel(tcnt, our_chip->base +
> REG_TCNTB(pwm->hwpwm)); writel(tcmp, our_chip->base +
> REG_TCMPB(pwm->hwpwm)); 
> +	/* In case the PWM is currently at 100% duty, force a manual
> update
	
	Cosmetic comment:

	Wasn't checkpatch complaining about this comment style?
	/* .....
         * .....

	instead of:
	/*
	 * .....
	 * .....

> +	 * to prevent the signal staying high in the pwm is disabled
> shortly
> +	 * afer this update (before it autoreloaded the new values) .
> +	 */
> +	if (oldtcmp == (u32) -1) {
> +		dev_dbg(our_chip->chip.dev, "Forcing manual update");
> +		pwm_samsung_manual_update(our_chip, pwm);
> +	}
> +
>  	chan->period_ns = period_ns;
>  	chan->tin_ns = tin_ns;
>  	chan->duty_ns = duty_ns;

Despite the above,

Acked-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
