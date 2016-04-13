From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND 09/11] pwm: sti: Add PWM Capture call-back
Date: Wed, 13 Apr 2016 11:25:54 +0100
Message-ID: <20160413102554.GQ8094@x1>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-10-git-send-email-lee.jones@linaro.org>
 <20160412105314.GE18882@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38170 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965799AbcDMKZ7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Apr 2016 06:25:59 -0400
Received: by mail-wm0-f42.google.com with SMTP id u206so68895191wme.1
        for <linux-pwm@vger.kernel.org>; Wed, 13 Apr 2016 03:25:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160412105314.GE18882@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com

On Tue, 12 Apr 2016, Thierry Reding wrote:

> On Wed, Mar 02, 2016 at 03:32:07PM +0000, Lee Jones wrote:
> > Once a PWM Capture has been initiated, the capture call
> > enables a rising edge detection IRQ, then waits.  Once each
> > of the 3 phase changes have been recorded the thread then
> > wakes.  The remaining part of the call carries out the
> > relevant calculations and passes back a formatted string to
> > the caller.
> >=20
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/pwm/pwm-sti.c | 72 +++++++++++++++++++++++++++++++++++++++=
++++++++++++
> >  1 file changed, 72 insertions(+)
> >=20
> > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > index 82a69e4..8de9b4a 100644
> > --- a/drivers/pwm/pwm-sti.c
> > +++ b/drivers/pwm/pwm-sti.c
> > @@ -309,7 +309,79 @@ static void sti_pwm_free(struct pwm_chip *chip=
, struct pwm_device *pwm)
> >  	clear_bit(pwm->hwpwm, &pc->configured);
> >  }
> > =20
> > +static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > +			   int channel, char *buf)
> > +{
> > +	struct sti_pwm_chip *pc =3D to_sti_pwmchip(chip);
> > +	struct sti_pwm_compat_data *cdata =3D pc->cdata;
> > +	struct sti_cpt_data *d =3D pc->cpt_data[channel];
> > +	struct device *dev =3D pc->dev;
> > +	unsigned int f, dc;
> > +	unsigned int high, low;
> > +	bool level;
> > +	int ret;
> > +
> > +	if (channel > cdata->cpt_num_chan - 1) {
> > +		dev_err(dev, "Channel %d is not valid\n", channel);
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_lock(&d->lock);
>=20
> Should this perhaps reuse the struct pwm_device's ->lock?
>=20
> > +
> > +	/* Prepare capture measurement */
> > +	d->index =3D 0;
> > +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_RISING);
> > +	regmap_field_write(pc->pwm_cpt_int_en, BIT(channel));
> > +	ret =3D wait_event_interruptible_timeout(d->wait, d->index > 1, H=
Z);
>=20
> The timeout here should make sure callers don't hang forever. But may=
be
> you can still make sure that when the PWM gets disabled the wait queu=
e
> is woken and perhaps return an appropriate error code to let users kn=
ow
> that the operation was interrupted.

Sure.  I'll look into that.

> Also, how about letting callers choose the value of the timeout? In s=
ome
> cases they may be interested in long-running signals. In other cases =
the
> whole second timeout may be much too long.

I'm not opposed to it.  How do you suggest we do that?

> > +	/*
> > +	 * In case we woke up for another reason than completion
> > +	 * make sure to disable the capture.
> > +	 */
> > +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_DISABLED=
);
>=20
> The comment here is slightly confusing because it implies that disabl=
ing
> the capture should be done conditionally, whereas it is always disabl=
ed.

Not really.  We do it unconditionally for reason explained.

It says:

  "disable the capture just in case X happens"

rather than

  "disable the capture if X happens".

Perhaps the language is too subtle.  I can reword for clarity.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
