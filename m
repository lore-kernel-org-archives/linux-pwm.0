From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 13/14] pwm: meson: add support PWM_POLARITY_INVERSED when disabling
Date: Mon, 27 May 2019 19:50:33 +0200
Message-ID: <CAFBinCCPsnX+OqjHgVi+tshE3EdVWS0Bk9qK1V+cg6DALnT1qA@mail.gmail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-14-martin.blumenstingl@googlemail.com> <4de7d436-32b7-e4ed-39b2-e85f75a17c16@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4de7d436-32b7-e4ed-39b2-e85f75a17c16@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Neil,

On Mon, May 27, 2019 at 2:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 25/05/2019 20:11, Martin Blumenstingl wrote:
> > meson_pwm_apply() has to consider the PWM polarity when disabling the
> > output.
> > With enabled=false and polarity=PWM_POLARITY_NORMAL the output needs to
> > be LOW. The driver already supports this.
> > With enabled=false and polarity=PWM_POLARITY_INVERSED the output needs
> > to be HIGH. Implement this in the driver by internally enabling the
> > output with the same settings that we already use for "period == duty".
> >
> > This fixes a PWM API violation which expects that the driver honors the
> > polarity also for enabled=false. Due to the IP block not supporting this
> > natively we only get "an as close as possible" to 100% HIGH signal (in
> > my test setup with input clock of 24MHz and measuring the output with a
> > logic analyzer at 24MHz sampling rate I got a duty cycle of 99.998475%
> > on a Khadas VIM).
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/pwm/pwm-meson.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > index 900d362ec3c9..bb48ba85f756 100644
> > --- a/drivers/pwm/pwm-meson.c
> > +++ b/drivers/pwm/pwm-meson.c
> > @@ -245,6 +245,7 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
> >  static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >                          struct pwm_state *state)
> >  {
> > +     struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
> >       struct meson_pwm *meson = to_meson_pwm(chip);
> >       int err = 0;
> >
> > @@ -252,7 +253,27 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >               return -EINVAL;
> >
> >       if (!state->enabled) {
> > -             meson_pwm_disable(meson, pwm);
> > +             if (state->polarity == PWM_POLARITY_INVERSED) {
> > +                     /*
> > +                      * This IP block revision doesn't have an "always high"
> > +                      * setting which we can use for "inverted disabled".
> > +                      * Instead we achieve this using the same settings
> > +                      * that we use a pre_div of 0 (to get the shortest
> > +                      * possible duration for one "count") and
> > +                      * "period == duty_cycle". This results in a signal
> > +                      * which is LOW for one "count", while being HIGH for
> > +                      * the rest of the (so the signal is HIGH for slightly
> > +                      * less than 100% of the period, but this is the best
> > +                      * we can achieve).
> > +                      */
> > +                     channel->pre_div = 0;
> > +                     channel->hi = ~0;
> > +                     channel->lo = 0;
> > +
> > +                     meson_pwm_enable(meson, pwm);
> > +             } else {
> > +                     meson_pwm_disable(meson, pwm);
> > +             }
> >       } else {
> >               err = meson_pwm_calc(meson, pwm, state);
> >               if (err < 0)
> >
>
> While not perfect, it almost fills the gap.
> Another way would be to use a specific pinctrl state setting the pin
> in GPIO output in high level, but this implementation could stay
> if the pinctrl state isn't available.
I just noticed that Amlogic updated the PWM IP block in G12A:
it now supports "constant enable" (REG_MISC_AB bits 28 and 29) as well
as PWM_POLARITY_INVERSED (REG_MISC_AB bits 26 and 27) natively!

I like your idea of having a specific pinctrl state.
we can implement that for anything older than G12A once we actually need it.
for G12A we can do better thanks to the updated IP block


Martin
