From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v9 12/27] pwm: jz4740: Use regmap from TCU driver
Date: Sat, 5 Jan 2019 22:18:20 +0100
Message-ID: <20190105211820.lax3opgdhyn662tw@pengutronix.de>
References: <20181227181319.31095-1-paul@crapouillou.net>
 <20181227181319.31095-13-paul@crapouillou.net>
 <20190105194226.pe4huzynz4civ3lm@pengutronix.de>
 <1546721178.28727.0@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546721178.28727.0@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello Paul,

On Sat, Jan 05, 2019 at 05:46:18PM -0300, Paul Cercueil wrote:
> On Sat, Jan 5, 2019 at 4:42 PM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Thu, Dec 27, 2018 at 07:13:04PM +0100, Paul Cercueil wrote:
> > >  The ingenic-timer "TCU" driver provides us with a regmap, that we
> > > can
> > >  use to safely access the TCU registers.
> > > 
> > >  While this driver is devicetree-compatible, it is never (as of now)
> > >  probed from devicetree, so this change does not introduce a ABI
> > > problem
> > >  with current devicetree files.
> > 
> > Does it change behaviour? If so, how?
> 
> No, it does not change the behaviour.

Then this paragraph in the commit log can better be dropped.

> > >  @@ -113,26 +117,37 @@ static int jz4740_pwm_apply(struct pwm_chip
> > > *chip, struct pwm_device *pwm,
> > > 
> > >   	jz4740_pwm_disable(chip, pwm);
> > > 
> > >  -	jz4740_timer_set_count(pwm->hwpwm, 0);
> > >  -	jz4740_timer_set_duty(pwm->hwpwm, duty);
> > >  -	jz4740_timer_set_period(pwm->hwpwm, period);
> > >  +	/* Set abrupt shutdown */
> > >  +	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
> > >  +			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
> > 
> > I think I already pointed that out before: abrupt mode is wrong. If
> > .apply is called with a new set of parameters the currently running
> > period with the old values is expected to complete before the new values
> > take effect.
> 
> You pointed it, indeed; but I won't change it until I can verify that the
> behaviour is correct (which does not seem to be the case even if I leave
> this bit cleared). Besides, this is the TCU patchset, fixes and patches
> unrelated to the TCU don't belong here.

So abrupt mode was already used before? Then maybe note in a comment
that this is wrong but kept for now as this change is only refactoring
without changing behaviour.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
