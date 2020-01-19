From: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Date: Sun, 19 Jan 2020 23:32:39 +0000
Message-ID: <20200119233234.GB28865@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-5-git-send-email-jeff@labundy.com>
 <20200117073427.ufrduwagvppeasgr@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200117073427.ufrduwagvppeasgr-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Content-ID: <27FE836ED0F0A9438BA43F2D866F9921-UmvZKMv7CrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "knaack.h-Mmb7MZpHnFY@public.gmane.org" <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org" <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

Thank you for prompt review.

On Fri, Jan 17, 2020 at 08:34:27AM +0100, Uwe Kleine-K=F6nig wrote:
> On Fri, Jan 17, 2020 at 02:35:57AM +0000, Jeff LaBundy wrote:
> > +static void iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> > +				 struct pwm_state *state)
> > +{
> > +	struct iqs620_pwm_private *iqs620_pwm;
> > +
> > +	iqs620_pwm =3D container_of(chip, struct iqs620_pwm_private, chip);
> > +
> > +	mutex_lock(&iqs620_pwm->lock);
> > +
> > +	/*
> > +	 * Since the device cannot generate a 0% duty cycle, requests to do s=
o
> > +	 * cause subsequent calls to iqs620_pwm_get_state to report the outpu=
t
> > +	 * as disabled with duty cycle equal to that which was in use prior t=
o
> > +	 * the request. This is not ideal, but is the best compromise based o=
n
> > +	 * the capabilities of the device.
> > +	 */
> > +	state->enabled =3D iqs620_pwm->out_en;
>=20
> Hmm, when .get_state is called first (before the first invokation of
> .apply) .out_en doesn't represent the hardware's state but is false
> unconditionally. This makes it hard to take over a running PWM setup by
> the bootloader.

This was intentional, albeit poorly documented on my part. When the parent
MFD driver probes the device, it issues a soft reset (which returns all of
its registers to their default state). It then loads firmware (essentially
tuning/calibration register settings) and then triggers the device's self-
calibration sequence.

Both IQS620_PWR_SETTINGS_PWM_OUT and IQS620_PWM_DUTY_CYCLE default to zero,
and the firmware does not modify these. Therefore out_en and duty_val match
the hardware even before iqs620_pwm_apply is called, as they're initialized
to zero as well.

I would be happy to add a comment in iqs620_pwm_get_state describing this
behavior; I should have described it there rather than the review history
(sorry about that).

However, you bring up a really interesting point about preserving what may
have been done by the bootloader. The device holds itself in POR until its
supply reaches a sufficient level, so there isn't necessarily a functional
reason to manually issue a soft reset from the parent MFD driver.

I could get rid of the manual soft reset, and then simply sync both out_en
and duty_val in iqs620_pwm_probe which would allow iqs620_pwm_get_state to
pick up any changes made by the bootloader prior to the kernel coming up.

The only problem is that leds-pwm disables the pwm at start-up, so the end
result is the same anyway. Regardless of the behavior of any one consumer,
however, I'm slightly inclined to go with the second option as it seems to
be less restrictive and more maintainable. Let me know if you disagree.

>=20
> Best regards
> Uwe
>=20
> > +	state->duty_cycle =3D DIV_ROUND_UP((iqs620_pwm->duty_val + 1) *
> > +					 IQS620_PWM_PERIOD_NS, 256);
> > +
> > +	mutex_unlock(&iqs620_pwm->lock);
> > +
> > +	state->period =3D IQS620_PWM_PERIOD_NS;
> > +}
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

Kind regards,
Jeff LaBundy
