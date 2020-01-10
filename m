From: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 4/7] pwm: Add support for Azoteq IQS620A PWM generator
Date: Fri, 10 Jan 2020 04:29:08 +0000
Message-ID: <20200110042851.GA23906@labundy.com>
References: <20191210000252.GA6361@labundy.com>
 <20191210072227.434hyv5wl3rwztqx@pengutronix.de>
 <20191215203607.GA31390@labundy.com>
 <20191216091912.r4onikojbkbmguag@pengutronix.de>
 <20191220031924.GA2658@labundy.com>
 <20191220085948.iagsdpjqd6ixdo7j@pengutronix.de>
 <20191221032755.GA3051@labundy.com>
 <20191222214851.kapsro6b6qylke43@pengutronix.de>
 <20200101223933.GB14339@labundy.com>
 <20200107111940.ymiey7npx6rrppqz@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200107111940.ymiey7npx6rrppqz-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Content-ID: <0BD0E6A2A1A1C145924E6F804C26EE79-UmvZKMv7CrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org" <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "knaack.h-Mmb7MZpHnFY@public.gmane.org" <knaack.h-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, Jan 07, 2020 at 12:19:40PM +0100, Uwe Kleine-K=F6nig wrote:
> Hi Jeff,
>=20
> On Wed, Jan 01, 2020 at 10:39:36PM +0000, Jeff LaBundy wrote:
> > On Sun, Dec 22, 2019 at 10:48:51PM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Sat, Dec 21, 2019 at 03:28:01AM +0000, Jeff LaBundy wrote:
> > > > Based on your other feedback, I'm moving forward under the impressi=
on that
> > > > you'll still accept option (2); please let me know if I have misund=
erstood
> > > > (thank you for being flexible).
> > >=20
> > > Yeah, that's fine. If in the end it shows that this is a bad idea we =
can
> > > still change to (3).
> >=20
> > Sounds great. As soon as 5.5-rc5 lands this weekend, I'll rebase v3 and
> > send it out.
> >=20
> > I failed to catch this in my previous reply, but the comment I've added
> > to iqs620_pwm_get_state actually reads as follows:
> >=20
> > /*
> >  * Since the device cannot generate a 0% duty cycle, requests to do so
> >  * force subsequent calls to iqs620_pwm_get_state to report the output
> >  * as disabled with duty cycle equal to that which was in use prior to
> >  * the request. This is not ideal, but is the best compromise based on
> >  * the capabilities of the device.
> >  */
> >=20
> > This matches the present implementation, not your proposed comment that
> > claims duty cycle is clamped to 1 / 256 ms following a request for a 0%
> > duty cycle.
>=20
> Yeah, if that's the mechanism that is actually implemented, that's fine
> of course.
>=20
> > This seems OK since the concept of a duty cycle or period aren't really
> > relevant if the output is disabled in my opinion. However if you prefer
> > I update iqs620_pwm_apply to clamp duty cycle to 1 / 256 ms (instead of
> > leaving it untouched) in this case, please let me know.
>=20
> For a disabled PWM the duty_cycle and period are not relevant, for an
> enabled PWM running with 0% the period matters (at least in theory)
> however.
>=20

Agreed in full. We should be covered here since we report the (fixed)
period in all cases.

> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

I managed to send out v3 this past weekend; please let me know if you
have any further feedback or you find it to be satisfactory.

Kind regards,
Jeff LaBundy
