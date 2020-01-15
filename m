From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Date: Wed, 15 Jan 2020 08:33:36 +0100
Message-ID: <20200115073336.2bhlu22toua3vnuo@pengutronix.de>
References: <1578271620-2159-1-git-send-email-jeff@labundy.com>
 <1578271620-2159-5-git-send-email-jeff@labundy.com>
 <20200114080828.vv7ilksklt27ysh3@pengutronix.de>
 <20200115032945.GA6229@labundy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200115032945.GA6229-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Cc: "lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "knaack.h-Mmb7MZpHnFY@public.gmane.org" <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org" <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hello Jeff,

On Wed, Jan 15, 2020 at 03:29:52AM +0000, Jeff LaBundy wrote:
> Thank you for your kind words and thorough review.

Great my feedback is welcome.

> On Tue, Jan 14, 2020 at 09:08:28AM +0100, Uwe Kleine-König wrote:
> > On Mon, Jan 06, 2020 at 12:48:02AM +0000, Jeff LaBundy wrote:
> > I thought we dicussed having a comment here, saying something like:
> > 
> > 	The device might reset when [...] and as a result looses it's
> > 	configuration. So the registers must be rewritten when this
> > 	happens to restore the expected operation.
> > 
> > Is it worth to issue a warning when this happens?
> 
> The detailed comments and an error message have always been in iqs62x_irq of the
> parent MFD driver. The pwm is only one of up to three sub-devices that subscribe
> to the chain and must update their locally owned registers after the MFD handles
> the interrupt and restores the device's firmware. I opted to keep these comments
> in the common MFD rather than repeating throughout the series.

That's fine then, a comment that the parent driver issues a message
would be great then.
 
> > > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > > +			       unsigned long event_flags, void *context)
> > > +{
> > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > +	int ret;
> > > +
> > > +	iqs620_pwm = container_of(notifier, struct iqs620_pwm_private,
> > > +				  notifier);
> > > +
> > > +	if (!completion_done(&iqs620_pwm->chip_ready) ||
> > > +	    !(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
> > > +		return NOTIFY_DONE;
> > 
> > Is here a (relevant?) race?  Consider the notifier triggers just when
> > pwmchip_add returned, (maybe even a consumer configured the device) and
> > before complete_all() is called. With my limited knowledge about
> > notifiers I'd say waiting for the completion here might be reasonable
> > and safe.
> 
> Great catch; this is theoretically possible. The problem with waiting, however,
> is if the notifier is triggered right away during probe but probe returns early
> due to an error (and completion never happens).

OK, the error path would need to complete .chip_ready then and the
notifier then check for this error. Indeed messy.
 
> At this point, I think the best option is to simply cache the values written to
> IQS620_PWR_SETTINGS_PWM_OUT and IQS620_PWM_DUTY_CYCLE and restore them from the
> notifier, which is essentially what is done for the IIO drivers in this series.

Sounds good.
 
> > > +	ret = blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
> > > +						 &iqs620_pwm->notifier);
> > > +	if (ret)
> > > +		dev_err(iqs620_pwm->chip.dev,
> > > +			"Failed to unregister notifier: %d\n", ret);
> > 
> > 	dev_err(iqs620_pwm->chip.dev,
> > 		"Failed to unregister notifier: %pe\n", ERR_PTR(ret));
> > 
> > gives a nicer output. (Also applies to other error messages of course.)
> > 
> 
> I don't disagree, but this gives me some pause. If I made this change here, I'd
> prefer to do so across the series for consistency. However, I am hesitant to do
> so at this stage in the review since several patches are somewhat stable by now
> (unless there was a compelling reason from a functional perspective).
> 
> Another reason is that there are many dev_err cases throughout this series, and
> adopting this very recently introduced functionality would make the series even
> harder to back port to the present lot of LTS kernels.
> 
> Unless this is a deal breaker, I'd like to pass on this for v4. However, please
> let me know if you feel strongly about it. In the meantime, I'll get started on
> the couple of other changes discussed here.

OK, being able to backport is a valid excuse. Consistency over the whole
series wouldn't be one of my reasons, your mileage obviously varies
(which is OK).

This can also be done later. Conversion to this is on my todo-list (not
at the top though), but if you beat me to it, I won't be angry :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
