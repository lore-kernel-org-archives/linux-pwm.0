From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] ARM: S3C24XX: rx1950: make use of atomic PWM API
Date: Thu, 15 Nov 2018 22:00:17 +0100
Message-ID: <20181115210017.cvpyicjuw5vjpcwl@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181026184157.16371-2-u.kleine-koenig@pengutronix.de>
 <20181114120814.GD2620@ulmo>
 <20181115085808.ihg4of72forhulzc@pengutronix.de>
 <20181115161516.GC8611@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181115161516.GC8611@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Thierry,

On Thu, Nov 15, 2018 at 05:15:16PM +0100, Thierry Reding wrote:
> On Thu, Nov 15, 2018 at 09:58:08AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Nov 14, 2018 at 01:08:14PM +0100, Thierry Reding wrote:
> > > On Fri, Oct 26, 2018 at 08:41:56PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > +static struct pwm_state lcd_pwm_state;
> > > >  static struct pwm_device *lcd_pwm;
> > > >  =

> > > >  static void rx1950_lcd_power(int enable)
> > > > @@ -428,15 +429,17 @@ static void rx1950_lcd_power(int enable)
> > > >  =

> > > >  		/* GPB1->OUTPUT, GPB1->0 */
> > > >  		gpio_direction_output(S3C2410_GPB(1), 0);
> > > > -		pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
> > > > -		pwm_disable(lcd_pwm);
> > > > +		lcd_pwm_state.duty_cycle =3D 0;
> > > > +		lcd_pwm_state.enabled =3D false;
> > > > +		pwm_apply_state(lcd_pwm, &lcd_pwm_state);
> > > =

> > > The correct way to do this would be:
> > > =

> > > 	struct pwm_state state;
> > > =

> > > 	pwm_get_state(lcd_pwm, &state);
> > > 	state.enabled =3D false;
> > > 	state.duty_cycle =3D 0;
> > > 	pwm_apply_state(lcd_pwm, &state);
> > =

> > The difference here is that with my approach the rx1950 driver caches
> > the intended pwm_state saving a few cycles for repeatedly copying the
> > pwm cache to a stack variable at the cost of some memory. I like my
> > approach a little better but I'm not willing to argue about that one and
> > can give in.
> =

> It's a redundant copy of the PWM's internal state

That the pwm keeps a copy of this is an implementation detail of the pwm
framework that shouldn't matter to its consumers.

> and not guaranteed to remain in sync with the PWM hardware state.

What should happen that the driver's pwm_state and the hardware state
diverge?

> You also require a global variable, which is usually a bad idea.

Right, but that's attributable to the fact, that the struct pwm_device
is a global variable, too.

> And we're not repeatedly copying data. We occasionally do. These
> operations are typically only executed once or twice per boot, so
> hardly anything that needs to be optimized for speed.
> =

> > > >  		gpio_direction_output(S3C2410_GPC(0), 1);
> > > >  		gpio_direction_output(S3C2410_GPC(5), 1);
> > > > @@ -491,11 +494,8 @@ static int rx1950_backlight_init(struct device=
 *dev)
> > > >  		return PTR_ERR(lcd_pwm);
> > > >  	}
> > > >  =

> > > > -	/*
> > > > -	 * FIXME: pwm_apply_args() should be removed when switching to
> > > > -	 * the atomic PWM API.
> > > > -	 */
> > > > -	pwm_apply_args(lcd_pwm);
> > > > +	pwm_get_state_default(lcd_pwm, &lcd_pwm_state);
> > > > +	lcd_pwm_state.period =3D LCD_PWM_PERIOD;
> > > =

> > > This is wrong, though it's probably because the comment is also
> > > confusing. There should be nothing wrong with using pwm_apply_args() =
in
> > > this case.
> > =

> > In my eyes it is wrong because it results in a call to the backend
> > driver's apply callback to get the default setting just to fix the
> > configuration and apply that in the code to follow.
> =

> Okay, I see. But there's already pwm_init_state() which pretty much does
> what you do here, right?
> =

> Thinking about it some more, I wonder if we shouldn't be more consistent
> about state handling here. So the reason why pwm_apply_args() exists is
> to program the PWM with a known state if the PWM doesn't support
> hardware readout. Since most drivers don't support hardware readout, we
> need this to at some specific point synchronize the hardware and
> internal states.
> =

> In retrospect I'm not sure that's necessary, because there's more and
> more evidence that we don't want to touch a PWM configuration until a
> consumer explicitly says so. There's also the slight problem that the
> pwm_apply_args() is really only necessary if the PWM driver doesn't
> support hardware readout, but that's not something that consumers are
> aware of or should worry about.

I consider your words as a light in the tunnel. Maybe we will reach a
conclusion eventually.

> In light of that I think perhaps a better solution would be to basically
> apply the PWM arguments to the internal state at request time. We can't
> do it earlier because we don't know the arguments before the PWM is
> requested. So I think at request time we could do something like this:
> =

> 	if (chip->ops->get_state)
> 		chip->ops->get_state(chip, pwm, &pwm->state);
> 	else
> 		pwm_init_state(pwm, &pwm->state);
> =

> That way drivers always get either the current state or the "default"
> state that was configured via platform-specific means (DT or lookup).

I think a gap in this reasoning is that if the DT dictates a period of
say 1 ms and the hardware is configured to something else, the consumer
should still work with the 1 ms value.

> > > While at it, I think the conversion should also be include replacing =
the
> > > call to pwm_request() by pwm_get(). There's already a PWM lookup table
> > > in the RX1950 board code, so pwm_get() would be able to use that. Note
> > > that for some reason that table contains a period that is different f=
rom
> > > LCD_PWM_PERIOD, so I think that should also be addressed. Basically a=
ll
> > > the information other than duty cycle should be coming from either DT=
 or
> > > a lookup table.
> > =

> > Yeah, I noticed that, too. It's not entirely clear to me how to do that
> > yet. So I thought to care about getting rid of the legacy usage of
> > pwm_config and pwm_apply_args first.
> =

> So I think I got the backlight PWM confused with the LCD PWM. The former
> is what we have in the PWM lookup table and which controls the backlight
> brightness. The latter is what we don't have in the table and which is
> requested using the legacy pwm_request() function. That also explains
> why there's a difference between the period in the PWM lookup table for
> the backlight PWM and the LCD_PWM_PERIOD macro.
> =

> Adding support for pwm_get() should be as simple ad adding an entry to
> rx1950_pwm_lookup[], such as this:
> =

> 	PWM_LOOKUP("samsung-pwm", 1, "pwm-backlight.0", "lcd", 192960,
> 		   PWM_POLARITY_NORMAL),
> =

> Then in rx1950_backlight_init(), which is passed the device structure
> that represents the backlight (i.e. "pwm-backlight.0"), pwm_get() can
> be called like this:
> =

> 	lcd_pwm =3D pwm_get(dev, "lcd");
> =

> The matching code should then be able to find the second entry as the
> best match and return the correct one.

Does this lookup belong to the board file or to a more general place
near the provider of the "samsung-pwm" devices?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
