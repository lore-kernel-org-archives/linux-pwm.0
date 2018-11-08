From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] pwm: bcm-kona: apply pwm settings on enable
Date: Thu, 8 Nov 2018 11:59:22 +0100
Message-ID: <20181108105922.p557jxrebjlhnsho@pengutronix.de>
References: <20181107093613.26734-1-peron.clem@gmail.com>
 <20181107093613.26734-2-peron.clem@gmail.com>
 <20181107162908.tejzekhc35pbknut@pengutronix.de>
 <CAJiuCccMtBsCVHeqxQhXRj_Ltdv91Qk-6WDKAhb5S7whZOWsAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJiuCccMtBsCVHeqxQhXRj_Ltdv91Qk-6WDKAhb5S7whZOWsAw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Suji Velupillai <suji.velupillai@broadcom.com>, Tim Kryger <tim.kryger@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Hello,

adding Tim Kryger as the initial author of the bcm-kona driver to Cc:.
Maybe he can shed some light to the questions below?

On Thu, Nov 08, 2018 at 11:47:17AM +0100, Clément Péron wrote:
> On Wed, 7 Nov 2018 at 17:29, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Nov 07, 2018 at 10:36:13AM +0100, Clément Péron wrote:
> > > From: Suji Velupillai <suji.velupillai@broadcom.com>
> > >
> > > When pwm_bl framework calls enable, a call to pwm_is_enabled(pwm) still
> > > return false, this prevents the backlight being turn on at boot time.
> > >
> > > Signed-off-by: Suji Velupillai <suji.velupillai@broadcom.com>
> > > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > > ---
> > >  drivers/pwm/pwm-bcm-kona.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> > > index 09a95aeb3a70..d991d53c4b38 100644
> > > --- a/drivers/pwm/pwm-bcm-kona.c
> > > +++ b/drivers/pwm/pwm-bcm-kona.c
> > > @@ -108,8 +108,8 @@ static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
> > >       ndelay(400);
> > >  }
> > >
> > > -static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > > -                         int duty_ns, int period_ns)
> > > +static int __pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +                      int duty_ns, int period_ns, bool pwmc_enabled)
> > >  {
> > >       struct kona_pwmc *kp = to_kona_pwmc(chip);
> > >       u64 val, div, rate;
> > > @@ -155,7 +155,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > >        * always calculated above to ensure the new values are
> > >        * validated immediately instead of on enable.
> > >        */
> > > -     if (pwm_is_enabled(pwm)) {
> > > +     if (pwm_is_enabled(pwm) || pwmc_enabled) {
> >
> > Having pwm-API-calls in hw-drivers is ugly. Apart from not giving the
> > intended return code this function should IMHO be reserved to pwm
> > consumers. The underlaying problem is that pwm-bl does:
> >
> >         pwm_config(pwm, duty_cycle, period);
> >         pwm_enable(pwm);
> >
> > and expects that the duty_cycle and period is used then. Doesn't
> > everything works just fine if the if-block is always executed?
> 
> Tested and works fine for me. But I only have a Cygnus proc.
> Maybe there is some issue with Kona as explained by the comment (even
> if I don't understand it well).
> 
>  * Don't apply settings if disabled. The period and duty cycle are
>  * always calculated above to ensure the new values are
>  * validated immediately instead of on enable.

I wouldn't understand that as "If you apply settings on a disabled PWM a
kitten dies". I think it only means: At the current point in time
duty_cycle and period are not important as the hardware is off. So don't
bother to write these values to the hardware.

@Tim: Do you think (or can test if) there is a problem when doing

-       if (pwm_is_enabled(pwm)) {
+       if (1) {

in kona_pwmc_config? (For sure the comment needs adaption and the if (1)
shouldn't make it into the driver, just used that as shorthand for the
change I want to suggest.)

But still better than dropping the check is to convert the driver to the
atomic API. With that this problem would simply not occur.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
