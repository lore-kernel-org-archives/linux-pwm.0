From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND 01/11] pwm: Add PWM Capture support
Date: Wed, 13 Apr 2016 10:36:05 +0100
Message-ID: <20160413093605.GN8094@x1>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-2-git-send-email-lee.jones@linaro.org>
 <20160412100845.GA18882@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38452 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965146AbcDMJgK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Apr 2016 05:36:10 -0400
Received: by mail-wm0-f43.google.com with SMTP id u206so66473202wme.1
        for <linux-pwm@vger.kernel.org>; Wed, 13 Apr 2016 02:36:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160412100845.GA18882@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com

On Tue, 12 Apr 2016, Thierry Reding wrote:

> On Wed, Mar 02, 2016 at 03:31:59PM +0000, Lee Jones wrote:
> > Supply a PWM Capture call-back Op in order to pass back
> > information obtained by running analysis on PWM a signal.
> > This would normally (at least during testing) be called from
> > the Sysfs routines with a view to printing out PWM Capture
> > data which has been encoded into a string.
> >=20
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/pwm/core.c  | 26 ++++++++++++++++++++++++++
> >  include/linux/pwm.h | 13 +++++++++++++
> >  2 files changed, 39 insertions(+)
>=20
> Overall I like the concept of introducing this capture functionality.
>=20
> However I have a couple of questions, see below.
>=20
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index d24ca5f..8f4a8a9 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -494,6 +494,32 @@ unlock:
> >  EXPORT_SYMBOL_GPL(pwm_set_polarity);
> > =20
> >  /**
> > + * pwm_capture() - capture and report a PWM signal
> > + * @pwm: PWM device
> > + * @channel: PWM capture channel to use
> > + * @buf: buffer to place output message into
> > + *
> > + * Returns: 0 on success or a negative error code on failure.
> > + */
> > +int pwm_capture(struct pwm_device *pwm, int channel, char *buf)
>=20
> This public interface seems to be targetted specifically at sysfs. As
> such I'm not sure if there is reason to make it public, since the cod=
e
> is unlikely to ever be called by other users in the kernel.
>=20
> Do you think it would be possible to make the interface more generic =
by
> passing back some form of structure containing the capture result? Th=
at
> way users within the kernel could use the result without having to go
> and parse a string filled in by the driver. It would also be easy to
> implement sysfs support on top of that. Another advantage is that the=
re
> would be a standard result structure rather than a free-form string
> filled by drivers that can't be controlled.
>=20
> What kind of result does the STi hardware return? Looking at the driv=
er
> later in the series it seems to support triggering interrupts on risi=
ng
> and falling edges and capture some running counter at these events. I=
f
> the frequency of the counter increment is known, these numbers should
> allow us to determine both the period and duty cycle of the PWM signa=
l
> in nanoseconds. Would it be possible to rewrite this function and the
> driver patch to something like this:
>=20
> 	int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result);
>=20
> Where
>=20
> 	struct pwm_capture {
> 		unsigned int period;
> 		unsigned int duty_cycle;
> 	};
>=20
> ?

Yes, I think that sounds feasible.

> Another thing I noticed is that the code here seems to be confusing
> channels and devices. In the PWM subsystem a struct pwm_device
> represents a single channel. Allowing the channel to be specified is
> redundant at best, and confusing at worst.

On the STi platform I'm working on, we have 2 devices PWM{0,1} and
each device has 4 separate channels [0..3].  Not all of them support
PWM capture, but the channels are 'a thing'.  I'd need to look into it
further, but I guess you'd like the driver to pretend we have 8
devices?  If that's the case, what's the point in the core 'npwm'
parameter?  Surely that's "channels per device"?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
