From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v1 1/2] pwm: bcm-iproc: handle clk_get_rate() return
Date: Mon, 23 Mar 2020 14:35:27 +0530
Message-ID: <CAHO=5PFBcgmnpA8D6prEo4WCu235Mr9jh8=_Y6pdM8R9=ShfXw@mail.gmail.com>
References: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
 <20200323065318.16533-2-rayagonda.kokatanur@broadcom.com> <20200323082540.2gvbbxtwadvzeeos@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40846 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgCWJFl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 05:05:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id 19so13604297ljj.7
        for <linux-pwm@vger.kernel.org>; Mon, 23 Mar 2020 02:05:39 -0700 (PDT)
In-Reply-To: <20200323082540.2gvbbxtwadvzeeos@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Mar 23, 2020 at 1:55 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, Mar 23, 2020 at 12:23:17PM +0530, Rayagonda Kokatanur wrote:
> > Handle clk_get_rate() returning <=3D 0 condition to avoid
> > possible division by zero.
>
> Was this noticed during a review and is more theoretic. Or does this
> (depending on pre-boot state) result in a kernel crash?

This is reported by internal coverity tool.
>
> > Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controlle=
r")
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > ---
> >  drivers/pwm/pwm-bcm-iproc.c | 32 +++++++++++++++++++-------------
> >  1 file changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
> > index 1f829edd8ee7..8bbd2a04fead 100644
> > --- a/drivers/pwm/pwm-bcm-iproc.c
> > +++ b/drivers/pwm/pwm-bcm-iproc.c
> > @@ -99,19 +99,25 @@ static void iproc_pwmc_get_state(struct pwm_chip *c=
hip, struct pwm_device *pwm,
> >       else
> >               state->polarity =3D PWM_POLARITY_INVERSED;
> >
> > -     value =3D readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
> > -     prescale =3D value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
> > -     prescale &=3D IPROC_PWM_PRESCALE_MAX;
> > -
> > -     multi =3D NSEC_PER_SEC * (prescale + 1);
> > -
> > -     value =3D readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
> > -     tmp =3D (value & IPROC_PWM_PERIOD_MAX) * multi;
> > -     state->period =3D div64_u64(tmp, rate);
> > -
> > -     value =3D readl(ip->base + IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm=
));
> > -     tmp =3D (value & IPROC_PWM_PERIOD_MAX) * multi;
> > -     state->duty_cycle =3D div64_u64(tmp, rate);
> > +     if (rate =3D=3D 0) {
> > +             state->period =3D 0;
> > +             state->duty_cycle =3D 0;
> > +     } else {
> > +             value =3D readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
> > +             prescale =3D value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm=
);
> > +             prescale &=3D IPROC_PWM_PRESCALE_MAX;
> > +
> > +             multi =3D NSEC_PER_SEC * (prescale + 1);
> > +
> > +             value =3D readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->h=
wpwm));
> > +             tmp =3D (value & IPROC_PWM_PERIOD_MAX) * multi;
> > +             state->period =3D div64_u64(tmp, rate);
> > +
> > +             value =3D readl(ip->base +
> > +                           IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
> > +             tmp =3D (value & IPROC_PWM_PERIOD_MAX) * multi;
> > +             state->duty_cycle =3D div64_u64(tmp, rate);
> > +     }
>
> The change looks fine.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
