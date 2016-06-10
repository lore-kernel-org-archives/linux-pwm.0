From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 08/20] pwm: Add PWM Capture support
Date: Fri, 10 Jun 2016 15:38:54 +0100
Message-ID: <20160610143854.GE1537@dell>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-9-lee.jones@linaro.org>
 <20160610135302.GK27142@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37126 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932102AbcFJOiU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2016 10:38:20 -0400
Received: by mail-wm0-f46.google.com with SMTP id k204so105028488wmk.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Jun 2016 07:38:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160610135302.GK27142@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, robh+dt@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org

On Fri, 10 Jun 2016, Thierry Reding wrote:

> On Wed, Jun 08, 2016 at 10:21:23AM +0100, Lee Jones wrote:
> > Supply a PWM Capture call-back Op in order to pass back
> > information obtained by running analysis on PWM a signal.
> > This would normally (at least during testing) be called from
> > the Sysfs routines with a view to printing out PWM Capture
> > data which has been encoded into a string.
> >=20
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/pwm/core.c  | 27 +++++++++++++++++++++++++++
> >  include/linux/pwm.h | 25 +++++++++++++++++++++++++
> >  2 files changed, 52 insertions(+)

So do you want me to re-spin?

Before you said you'd make adjustments on patches 8 through 10, so I'm
a little confused.

> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index dba3843..4678de6 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -525,6 +525,33 @@ int pwm_apply_state(struct pwm_device *pwm, st=
ruct pwm_state *state)
> >  EXPORT_SYMBOL_GPL(pwm_apply_state);
> > =20
> >  /**
> > + * pwm_capture() - capture and report a PWM signal
> > + * @pwm: PWM device
> > + * @result: struct to fill with capture result
> > + * @timeout_ms: time to wait, in milliseconds, before giving up on=
 capture
> > + *
> > + * Returns: 0 on success or a negative error code on failure.
> > + */
> > +int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result=
,
> > +		unsigned int timeout_ms)
> > +{
> > +	int err;
> > +
> > +	if (!pwm || !pwm->chip->ops)
> > +		return -EINVAL;
> > +
> > +	if (!pwm->chip->ops->capture)
> > +		return -ENOSYS;
> > +
> > +	mutex_lock(&pwm_lock);
> > +	err =3D pwm->chip->ops->capture(pwm->chip, pwm, result, timeout_m=
s);
> > +	mutex_unlock(&pwm_lock);
> > +
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(pwm_capture);
> > +
> > +/**
> >   * pwm_adjust_config() - adjust the current PWM config to the PWM =
arguments
> >   * @pwm: PWM device
> >   *
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index 17018f3..13cac27 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -5,7 +5,9 @@
> >  #include <linux/mutex.h>
> >  #include <linux/of.h>
> > =20
> > +struct pwm_capture;
> >  struct seq_file;
> > +
> >  struct pwm_chip;
> > =20
> >  /**
> > @@ -153,6 +155,7 @@ static inline void pwm_get_args(const struct pw=
m_device *pwm,
> >   * @free: optional hook for freeing a PWM
> >   * @config: configure duty cycles and period length for this PWM
> >   * @set_polarity: configure the polarity of this PWM
> > + * @capture: capture and report PWM signal
> >   * @enable: enable PWM output toggling
> >   * @disable: disable PWM output toggling
> >   * @apply: atomically apply a new PWM config. The state argument
> > @@ -172,6 +175,8 @@ struct pwm_ops {
> >  		      int duty_ns, int period_ns);
> >  	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm=
,
> >  			    enum pwm_polarity polarity);
> > +	int (*capture)(struct pwm_chip *chip, struct pwm_device *pwm,
> > +		       struct pwm_capture *result, unsigned int timeout_ms);
>=20
> Can we please drop the _ms suffix. It's already documented to be in
> milliseconds. Also maybe make that unsigned long for consistency with
> the type of the timeout parameter elsewhere in the kernel.
>=20
> >  	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
> >  	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
> >  	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
> > @@ -212,6 +217,16 @@ struct pwm_chip {
> >  	bool can_sleep;
> >  };
> > =20
> > +/**
> > + * struct pwm_capture - PWM capture data
> > + * @period: period of the PWM signal (in nanoseconds)
> > + * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
> > + */
> > +struct pwm_capture {
> > +	unsigned long long period;
> > +	unsigned long long duty_cycle;
> > +};
>=20
> I'd prefer these to be unsigned int, for symmetry with the PWM output
> part of the framework. With 32 bits you get about 4.2 seconds of peri=
od
> and duty cycle, and I doubt that any reasonable signal would extend
> beyond that.
>=20
> > @@ -322,6 +337,9 @@ static inline void pwm_disable(struct pwm_devic=
e *pwm)
> > =20
> > =20
> >  /* PWM provider APIs */
> > +int pwm_capture(struct pwm_device *pwm,
> > +		struct pwm_capture *result,
> > +		unsigned int timeout_ms);
>=20
> This fits into 2 lines. And same comments on the timeout parameter.
>=20
> >  int pwm_set_chip_data(struct pwm_device *pwm, void *data);
> >  void *pwm_get_chip_data(struct pwm_device *pwm);
> > =20
> > @@ -373,6 +391,13 @@ static inline int pwm_config(struct pwm_device=
 *pwm, int duty_ns,
> >  	return -EINVAL;
> >  }
> > =20
> > +static inline int pwm_capture(struct pwm_device *pwm,
> > +			      struct pwm_capture *result,
> > +			      unsigned int timeout_ms)
>=20
> Same here.
>=20
> Otherwise this looks really nice to me from an API point of view.
>=20
> Thierry



--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
