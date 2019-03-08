From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] pwm: img: Turn final 'else if' into 'else' in img_pwm_config
Date: Fri, 8 Mar 2019 10:38:11 -0800
Message-ID: <CAKwvOdmA6=_-_uC8PAC8i+-mLA8FN6GOeY544139N2AsA8RbsQ@mail.gmail.com>
References: <20190307223628.21270-1-natechancellor@gmail.com> <20190308085316.7eaynrb746o6xsz7@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308085316.7eaynrb746o6xsz7@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Nathan Chancellor <natechancellor@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, Mar 8, 2019 at 12:53 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Mar 07, 2019 at 03:36:28PM -0700, Nathan Chancellor wrote:
> > When building with -Wsometimes-uninitialized, Clang warns:
> >
> > drivers/pwm/pwm-img.c:126:13: error: variable 'timebase' is used
> > uninitialized whenever 'if' condition is false
> > [-Werror,-Wsometimes-uninitialized]
> >
> > The final else if functions as an else; make that explicit so that Clan=
g
> > understands that timebase cannot be used uninitialized.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/400
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/pwm/pwm-img.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> > index 815f5333bb8f..1cc5fbe1e1d3 100644
> > --- a/drivers/pwm/pwm-img.c
> > +++ b/drivers/pwm/pwm-img.c
> > @@ -123,7 +123,7 @@ static int img_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> >       } else if (mul <=3D max_timebase * 512) {
> >               div =3D PWM_CTRL_CFG_SUB_DIV0_DIV1;
> >               timebase =3D DIV_ROUND_UP(mul, 512);
> > -     } else if (mul > max_timebase * 512) {
> > +     } else {
> >               dev_err(chip->dev,
> >                       "failed to configure timebase steps/divider value=
\n");
> >               return -EINVAL;
>
> This can even be simplified further.
>
> From the probe function we have:
>
>         pwm_chip->max_period_ns =3D NSEC_PER_SEC * 512 * max_timebase / i=
nput_clk_hz

I had trouble verifying `input_clk_hz` in the above.  The divisor is
`clk_get_rate(pwm->pwm_clk)`, but is it guaranteed to always be
`input_clk_hz`? If so, where?

>
> Then in img_pwm_config there is:
>
>         mul =3D =E2=8E=A1 input_clk_hz / =E2=8E=A1 NSEC_PER_SEC / period_=
ns=E2=8E=A4=E2=8E=A4
>
> (Not sure this term is the best we can come up with. The rounding
> strategy looks strange because the first DIV_ROUND_UP makes mul smaller
> while the second makes it bigger. This is similar to
>
>         =E2=8E=A1 input_clk_hz * period_ns / NSEC_PER_SEC =E2=8E=A4
>
> which is probably more exact and cheaper to calculate.)
>
> If we now had
>
>         mul > max_timebase * 512
>
> this results in (apart from rounding errors):
>
>         input_clk_hz * period_ns / NSEC_PER_SEC > max_timebase * 512
>  <=3D>    period_ns > max_timebase * 512 * NSEC_PER_SEC / input_clk_hz
>  <=3D>    period_ns > pwm_chip->max_period_ns
>
> This however is already ruled out by the first check in
> img_pwm_config().
>
> So if the rounding would be fixed, the else is a dead branch and could
> be dropped completely.

--=20
Thanks,
~Nick Desaulniers
