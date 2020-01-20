From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v4 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Date: Mon, 20 Jan 2020 08:27:39 +0100
Message-ID: <20200120072739.sixr5e76uckrugvu@pengutronix.de>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-5-git-send-email-jeff@labundy.com>
 <20200117073427.ufrduwagvppeasgr@pengutronix.de>
 <20200119233234.GB28865@labundy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200119233234.GB28865-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Cc: "lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "knaack.h-Mmb7MZpHnFY@public.gmane.org" <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org" <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hello Jeff,

On Sun, Jan 19, 2020 at 11:32:39PM +0000, Jeff LaBundy wrote:
> On Fri, Jan 17, 2020 at 08:34:27AM +0100, Uwe Kleine-König wrote:
> > On Fri, Jan 17, 2020 at 02:35:57AM +0000, Jeff LaBundy wrote:
> > > +static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +				 struct pwm_state *state)
> > > +{
> > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > +
> > > +	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
> > > +
> > > +	mutex_lock(&iqs620_pwm->lock);
> > > +
> > > +	/*
> > > +	 * Since the device cannot generate a 0% duty cycle, requests to do so
> > > +	 * cause subsequent calls to iqs620_pwm_get_state to report the output
> > > +	 * as disabled with duty cycle equal to that which was in use prior to
> > > +	 * the request. This is not ideal, but is the best compromise based on
> > > +	 * the capabilities of the device.
> > > +	 */
> > > +	state->enabled = iqs620_pwm->out_en;
> > 
> > Hmm, when .get_state is called first (before the first invokation of
> > .apply) .out_en doesn't represent the hardware's state but is false
> > unconditionally. This makes it hard to take over a running PWM setup by
> > the bootloader.
> 
> This was intentional, albeit poorly documented on my part. When the parent
> MFD driver probes the device, it issues a soft reset (which returns all of
> its registers to their default state). It then loads firmware (essentially
> tuning/calibration register settings) and then triggers the device's self-
> calibration sequence.
> 
> Both IQS620_PWR_SETTINGS_PWM_OUT and IQS620_PWM_DUTY_CYCLE default to zero,
> and the firmware does not modify these. Therefore out_en and duty_val match
> the hardware even before iqs620_pwm_apply is called, as they're initialized
> to zero as well.
> 
> I would be happy to add a comment in iqs620_pwm_get_state describing this
> behavior; I should have described it there rather than the review history
> (sorry about that).

I didn't saw that mentioned in the review history, just skimmed through
the driver.

> However, you bring up a really interesting point about preserving what may
> have been done by the bootloader. The device holds itself in POR until its
> supply reaches a sufficient level, so there isn't necessarily a functional
> reason to manually issue a soft reset from the parent MFD driver.
> 
> I could get rid of the manual soft reset, and then simply sync both out_en
> and duty_val in iqs620_pwm_probe which would allow iqs620_pwm_get_state to
> pick up any changes made by the bootloader prior to the kernel coming up.

That sounds good. This way the PWM driver is independent of the MFD
driver and does the right thing no matter if parent resets the chip or
not.
 
> The only problem is that leds-pwm disables the pwm at start-up, so the end
> result is the same anyway. Regardless of the behavior of any one consumer,
> however, I'm slightly inclined to go with the second option as it seems to
> be less restrictive and more maintainable. Let me know if you disagree.

With

	default-state = "keep";

in your dt the LED shouldn't get disabled.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
