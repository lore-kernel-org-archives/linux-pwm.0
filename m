From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 Resend] pwm: samsung: Fix output race on disabling
Date: Wed, 18 Mar 2015 09:08:25 +0100
Message-ID: <20150318090825.77b06ff7@amdc2363>
References: <1425543243-6587-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1426665046.9099.74.camel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1426665046.9099.74.camel@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi Sjoerd,

> Hey Jingoo, Kukjijn, Lukasz,
> 
> Pinging on this one again, could you please review this patch so it
> can be merged through the PWM tree? 

As fair as I remember, I've already acked the patch :-)


> 
> On Thu, 2015-03-05 at 09:14 +0100, Sjoerd Simons wrote:
> > When disabling the samsung PWM the output state remains at the
> > level it was in the end of a pwm cycle. In other words, calling
> > pwm_disable when at 100% duty will keep the output active, while at
> > all other setting the output will go/stay inactive. On top of that
> > the samsung PWM settings are double-buffered, which means the new
> > settings only get applied at the start of a new PWM cycle.
> > 
> > This results in a race if the PWM is at 100% duty and a driver
> > calls: pwm_config (pwm, 0, period);
> >   pwm_disable (pwm);
> > 
> > In this case the PWMs output will unexpectedly stay active, unless
> > a new PWM cycle happened to start between the register writes in
> > _config and _disable. As far as i can tell this is a regression
> > introduced by 3bdf878, before that a call to pwm_config would call
> > pwm_samsung_enable which, while heavy-handed, made sure the
> > expected settings were live.
> > 
> > To resolve this, while not re-introducing the issues 3bdf878
> > (flickering as the PWM got reset while in a PWM cycle). Only force
> > an update of the settings when at 100% duty, which shouldn't have a
> > noticeable effect on the output but is enough to ensure the
> > behaviour is as expected on disable.
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> > ---
> > Changes since v1:
> >   Fix small issues pointed out by Tomasz Figa
> >   - Correct various coding style issues
> >   - Read the current value of the tcmp register for comparison
> > rather then using a non-trivial comparison to decide whether the
> > current state was 100% duty
> >   - Move the code to force manual update out into its own function
> >   - Clarify the comment indicating why a manual update is sometimes
> > required
> > 
> >  drivers/pwm/pwm-samsung.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> > index 3e9b583..649f6c4 100644
> > --- a/drivers/pwm/pwm-samsung.c
> > +++ b/drivers/pwm/pwm-samsung.c
> > @@ -269,12 +269,31 @@ static void pwm_samsung_disable(struct
> > pwm_chip *chip, struct pwm_device *pwm)
> > spin_unlock_irqrestore(&samsung_pwm_lock, flags); }
> >  
> > +static void pwm_samsung_manual_update(struct samsung_pwm_chip
> > *chip,
> > +				      struct pwm_device *pwm)
> > +{
> > +	unsigned int tcon_chan = to_tcon_channel(pwm->hwpwm);
> > +	u32 tcon;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&samsung_pwm_lock, flags);
> > +
> > +	tcon = readl(chip->base + REG_TCON);
> > +	tcon |= TCON_MANUALUPDATE(tcon_chan);
> > +	writel(tcon, chip->base + REG_TCON);
> > +
> > +	tcon &= ~TCON_MANUALUPDATE(tcon_chan);
> > +	writel(tcon, chip->base + REG_TCON);
> > +
> > +	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
> > +}
> > +
> >  static int pwm_samsung_config(struct pwm_chip *chip, struct
> > pwm_device *pwm, int duty_ns, int period_ns)
> >  {
> >  	struct samsung_pwm_chip *our_chip =
> > to_samsung_pwm_chip(chip); struct samsung_pwm_channel *chan =
> > pwm_get_chip_data(pwm);
> > -	u32 tin_ns = chan->tin_ns, tcnt, tcmp;
> > +	u32 tin_ns = chan->tin_ns, tcnt, tcmp, oldtcmp;
> >  
> >  	/*
> >  	 * We currently avoid using 64bit arithmetic by using the
> > @@ -288,6 +307,7 @@ static int pwm_samsung_config(struct pwm_chip
> > *chip, struct pwm_device *pwm, return 0;
> >  
> >  	tcnt = readl(our_chip->base + REG_TCNTB(pwm->hwpwm));
> > +	oldtcmp = readl(our_chip->base + REG_TCMPB(pwm->hwpwm));
> >  
> >  	/* We need tick count for calculation, not last tick. */
> >  	++tcnt;
> > @@ -335,6 +355,15 @@ static int pwm_samsung_config(struct pwm_chip
> > *chip, struct pwm_device *pwm, writel(tcnt, our_chip->base +
> > REG_TCNTB(pwm->hwpwm)); writel(tcmp, our_chip->base +
> > REG_TCMPB(pwm->hwpwm)); 
> > +	/* In case the PWM is currently at 100% duty, force a
> > manual update
> > +	 * to prevent the signal staying high in the pwm is
> > disabled shortly
> > +	 * afer this update (before it autoreloaded the new
> > values) .
> > +	 */
> > +	if (oldtcmp == (u32) -1) {
> > +		dev_dbg(our_chip->chip.dev, "Forcing manual
> > update");
> > +		pwm_samsung_manual_update(our_chip, pwm);
> > +	}
> > +
> >  	chan->period_ns = period_ns;
> >  	chan->tin_ns = tin_ns;
> >  	chan->duty_ns = duty_ns;
> 
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
