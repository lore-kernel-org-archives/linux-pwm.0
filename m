From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] pwm: img: Turn final 'else if' into 'else' in img_pwm_config
Date: Fri, 8 Mar 2019 13:23:41 -0800
Message-ID: <CAKwvOd=W0MKF_bYtgCOz2hH+RvpZPJawcaBnR2YkcBTP_NZHuA@mail.gmail.com>
References: <20190307223628.21270-1-natechancellor@gmail.com>
 <20190308085316.7eaynrb746o6xsz7@pengutronix.de> <CAKwvOdmA6=_-_uC8PAC8i+-mLA8FN6GOeY544139N2AsA8RbsQ@mail.gmail.com>
 <20190308211852.wnhivsnlwhr4kqn3@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308211852.wnhivsnlwhr4kqn3@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Nathan Chancellor <natechancellor@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, Mar 8, 2019 at 1:18 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Fri, Mar 08, 2019 at 10:38:11AM -0800, Nick Desaulniers wrote:
> > On Fri, Mar 8, 2019 at 12:53 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Thu, Mar 07, 2019 at 03:36:28PM -0700, Nathan Chancellor wrote:
> > > > When building with -Wsometimes-uninitialized, Clang warns:
> > > >
> > > > drivers/pwm/pwm-img.c:126:13: error: variable 'timebase' is used
> > > > uninitialized whenever 'if' condition is false
> > > > [-Werror,-Wsometimes-uninitialized]
> > > >
> > > > The final else if functions as an else; make that explicit so that =
Clang
> > > > understands that timebase cannot be used uninitialized.
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/400
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  drivers/pwm/pwm-img.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> > > > index 815f5333bb8f..1cc5fbe1e1d3 100644
> > > > --- a/drivers/pwm/pwm-img.c
> > > > +++ b/drivers/pwm/pwm-img.c
> > > > @@ -123,7 +123,7 @@ static int img_pwm_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > > >       } else if (mul <=3D max_timebase * 512) {
> > > >               div =3D PWM_CTRL_CFG_SUB_DIV0_DIV1;
> > > >               timebase =3D DIV_ROUND_UP(mul, 512);
> > > > -     } else if (mul > max_timebase * 512) {
> > > > +     } else {
> > > >               dev_err(chip->dev,
> > > >                       "failed to configure timebase steps/divider v=
alue\n");
> > > >               return -EINVAL;
> > >
> > > This can even be simplified further.
> > >
> > > From the probe function we have:
> > >
> > >         pwm_chip->max_period_ns =3D NSEC_PER_SEC * 512 * max_timebase=
 / input_clk_hz
> >
> > I had trouble verifying `input_clk_hz` in the above.  The divisor is
> > `clk_get_rate(pwm->pwm_clk)`, but is it guaranteed to always be
> > `input_clk_hz`? If so, where?
>
> In the probe function it's called "clk_rate". We have:
>
>         clk_rate =3D clk_get_rate(pwm->pwm_clk);
>         ...
>         val =3D (u64)NSEC_PER_SEC * 512 * pwm->data->max_timebase;
>         do_div(val, clk_rate);
>         pwm->max_period_ns =3D val;
>
> and in img_pwm_config we have:
>
>         input_clk_hz =3D clk_get_rate(pwm_chip->pwm_clk);
>
> I used the name used in img_pwm_config with the intention that my
> reasoning is easier to understand, but obviously I failed.
>
> This by the way highlights another patch opportunity: Unify the names
> that the same thing gets the same name in the different functions. This
> doesn't only affect "clk_rate" vs "input_clk_hz", but also "pwm_chip"
> vs. "pwm".

Sure, those seem like nice little cleanups that will help with
maintainability.  Would you mind sending a patch for those, and I'll
review? Otherwise Nathan's patch exists and is ready to go.
--=20
Thanks,
~Nick Desaulniers
