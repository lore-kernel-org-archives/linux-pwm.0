From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH 2/2] pwm: bcm-kona: apply pwm settings on enable
Date: Thu, 8 Nov 2018 11:47:17 +0100
Message-ID: <CAJiuCccMtBsCVHeqxQhXRj_Ltdv91Qk-6WDKAhb5S7whZOWsAw@mail.gmail.com>
References: <20181107093613.26734-1-peron.clem@gmail.com> <20181107093613.26734-2-peron.clem@gmail.com>
 <20181107162908.tejzekhc35pbknut@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107162908.tejzekhc35pbknut@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: u.kleine-koenig@pengutronix.de
Cc: Thierry Reding <thierry.reding@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Suji Velupillai <suji.velupillai@broadcom.com>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Wed, 7 Nov 2018 at 17:29, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Wed, Nov 07, 2018 at 10:36:13AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Suji Velupillai <suji.velupillai@broadcom.com>
> >
> > When pwm_bl framework calls enable, a call to pwm_is_enabled(pwm) still
> > return false, this prevents the backlight being turn on at boot time.
> >
> > Signed-off-by: Suji Velupillai <suji.velupillai@broadcom.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-bcm-kona.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
> > index 09a95aeb3a70..d991d53c4b38 100644
> > --- a/drivers/pwm/pwm-bcm-kona.c
> > +++ b/drivers/pwm/pwm-bcm-kona.c
> > @@ -108,8 +108,8 @@ static void kona_pwmc_apply_settings(struct kona_pw=
mc *kp, unsigned int chan)
> >       ndelay(400);
> >  }
> >
> > -static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > -                         int duty_ns, int period_ns)
> > +static int __pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm=
,
> > +                      int duty_ns, int period_ns, bool pwmc_enabled)
> >  {
> >       struct kona_pwmc *kp =3D to_kona_pwmc(chip);
> >       u64 val, div, rate;
> > @@ -155,7 +155,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >        * always calculated above to ensure the new values are
> >        * validated immediately instead of on enable.
> >        */
> > -     if (pwm_is_enabled(pwm)) {
> > +     if (pwm_is_enabled(pwm) || pwmc_enabled) {
>
> Having pwm-API-calls in hw-drivers is ugly. Apart from not giving the
> intended return code this function should IMHO be reserved to pwm
> consumers. The underlaying problem is that pwm-bl does:
>
>         pwm_config(pwm, duty_cycle, period);
>         pwm_enable(pwm);
>
> and expects that the duty_cycle and period is used then. Doesn't
> everything works just fine if the if-block is always executed?

Tested and works fine for me. But I only have a Cygnus proc.
Maybe there is some issue with Kona as explained by the comment (even
if I don't understand it well).

 * Don't apply settings if disabled. The period and duty cycle are
 * always calculated above to ensure the new values are
 * validated immediately instead of on enable.

Regards,
Clement

>
> The better fix here would be to convert the driver to the atomic API
> (i.e. implement .apply instead of .config, .set_polarity, .enable and
> .disable).
>
> Alternatively in .enable ensure that the hardware is programmed with the
> parameters from pwm->state. (But converting to the atomic API is the
> better approach.)
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
