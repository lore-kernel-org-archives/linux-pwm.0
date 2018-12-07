Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36356 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLGJ6B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Dec 2018 04:58:01 -0500
MIME-Version: 1.0
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1544171373-29618-3-git-send-email-yoshihiro.shimoda.uh@renesas.com> <20181207090717.qht2q6r3xzo2mzu4@pengutronix.de>
In-Reply-To: <20181207090717.qht2q6r3xzo2mzu4@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Dec 2018 10:57:48 +0100
Message-ID: <CAMuHMdUfrQ0u3eJ2Dmgmbb2Dt_DRmFNXXDzS=W0MmsoemU61ag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 2/5] pwm: rcar: Add support "atomic" API
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Uwe,

On Fri, Dec 7, 2018 at 10:08 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Fri, Dec 07, 2018 at 05:29:30PM +0900, Yoshihiro Shimoda wrote:
> > This patch adds support for "atomic" API. Behavior is the same as
> > when using legacy APIs.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pwm/pwm-rcar.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> > index 9cf4567..a5ea0f3 100644
> > --- a/drivers/pwm/pwm-rcar.c
> > +++ b/drivers/pwm/pwm-rcar.c
> > @@ -200,12 +200,44 @@ static void rcar_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> >       rcar_pwm_update(rp, RCAR_PWMCR_EN0, 0, RCAR_PWMCR);
> >  }
> >
> > +static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                       struct pwm_state *state)
> > +{
> > +     struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> > +     int div, ret;
> > +
> > +     div = rcar_pwm_get_clock_division(rp, state->period);
> > +     if (div < 0)
> > +             return div;
> > +
> > +     rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
> > +
> > +     rcar_pwm_calc_counter(rp, div, state->duty_cycle, state->period);
> > +     ret = rcar_pwm_set_counter(rp);
> > +     if (!ret)
> > +             rcar_pwm_set_clock_control(rp, div);
> > +
> > +     /* The SYNC should be set to 0 even if rcar_pwm_set_counter failed */
> > +     rcar_pwm_update(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
> > +
> > +     if (!ret && state->enabled)
> > +             ret = rcar_pwm_enable(chip, pwm);
> > +
> > +     if (!state->enabled) {
> > +             rcar_pwm_disable(chip, pwm);
> > +             ret = 0;
> > +     }
> > +
> > +     return ret;
>
> state->polarity isn't used here which is a bug I think.
>
> Is the documentation for this hardware publically available?

Please check Section 59 of the "User's Manual: Hardware" at
https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rzg/rzg1m.html

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
