From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH RESEND] pwm: samsung: Fix output race on disabling
Date: Thu, 15 Jan 2015 21:54:24 +0900
Message-ID: <CA+Ln22E3QpH_F8DU==z7b_Ju8txcx5uSOnYv2RMf4b1ha-1tOA@mail.gmail.com>
References: <1420671497-25270-1-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:52866 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbbAOMyZ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Jan 2015 07:54:25 -0500
In-Reply-To: <1420671497-25270-1-git-send-email-sjoerd.simons@collabora.co.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Ajay Kumar <ajaykumar.rs@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>

Hi Sjoerd,

Thanks for the patch. I posted some comments inline, though.

2015-01-08 7:58 GMT+09:00 Sjoerd Simons <sjoerd.simons@collabora.co.uk>:
> When disabling the samsung PWM the output state remains at the level it
> was in the end of a pwm cycle. In other words, calling pwm_disable when
> at 100% duty will keep the output active, while at all other setting the
> output will go/stay inactive. On top of that the samsung PWM settings are
> double-buffered, which means the new settings only get applied at the
> start of a new PWM cycle.
>
> This results in a race if the PWM is at 100% duty and a driver calls:
>   pwm_config (pwm, 0, period);
>   pwm_disable (pwm);
>
> In this case the PWMs output will unexpectedly stay active, unless a new
> PWM cycle happened to start between the register writes in _config and
> _disable. As far as i can tell this is a regression introduced by 3bdf878,
> before that a call to pwm_config would call pwm_samsung_enable which,
> while heavy-handed, made sure the expected settings were live.
>
> To resolve this, while not re-introducing the issues 3bdf878 (flickering
> as the PWM got reset while in a PWM cycle). Only force an update of the
> settings when at 100% duty, which shouldn't have a noticeable effect on
> the output but is enough to ensure the behaviour is as expected on
> disable.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
>  drivers/pwm/pwm-samsung.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index 3e9b583..3e252dc 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -335,6 +335,27 @@ static int pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
>         writel(tcnt, our_chip->base + REG_TCNTB(pwm->hwpwm));
>         writel(tcmp, our_chip->base + REG_TCMPB(pwm->hwpwm));
>
> +       /* In case the PWM is currently at 100% duty, trigger a manual update to
> +        * prevent unexpected results when disabling the pwm */

IMHO it wouldn't be a bad idea to specify exactly what those
unexpected results are and why a manual update helps instead of
repeating the same thing that can be understood from reading the code.

nit: According to CodingStyle multi-line comments should start and end
with empty line, i.e.

/*
 * Line 1
 * Line 2
 */

nit: s/pwm/PWM/
nit: Missing dot at the end of the sentence.

> +       if (chan->period_ns/chan->tin_ns == chan->duty_ns/chan->tin_ns) {

This check looks really heavy weight and is not really obvious at
first look (especially the need to divide both sides by chan->tin_ns
to account for integer rounding). Maybe instead you could read back
tcmp before writing the new one and compare it with -1U?

Also nit (if you decide to keep the condition as is): There should be
spaces on both sides of the slash.

> +               unsigned int tcon_chan = to_tcon_channel(pwm->hwpwm);
> +               u32 tcon;
> +               unsigned long flags;
> +
> +               dev_dbg(our_chip->chip.dev, "Forcing manual update");
> +
> +               spin_lock_irqsave(&samsung_pwm_lock, flags);
> +
> +               tcon = readl(our_chip->base + REG_TCON);
> +               tcon |= TCON_MANUALUPDATE(tcon_chan);
> +               writel(tcon, our_chip->base + REG_TCON);
> +
> +               tcon &= ~TCON_MANUALUPDATE(tcon_chan);
> +               writel(tcon, our_chip->base + REG_TCON);
> +
> +               spin_unlock_irqrestore(&samsung_pwm_lock, flags);
> +       }

I would move out the contents of the if block above to a separate
helper function, e.g. pwm_samsung_manual_update().

Best regards,
Tomasz
