From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v13 04/11] pwm: clps711x: Cast period to u32 before use
 as divisor
Date: Fri, 24 Apr 2020 15:21:29 -0700
Message-ID: <20200424222129.GC31118@codeaurora.org>
References: <cover.1587523702.git.gurus@codeaurora.org>
 <02ba64d8289bf84a8d140f5a3c38ed64a9474d3b.1587523702.git.gurus@codeaurora.org>
 <CAMuHMdVOPKWL9u_4QCvcBZKFrW-7aKZonXjODqUx9HwS=CF09g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVOPKWL9u_4QCvcBZKFrW-7aKZonXjODqUx9HwS=CF09g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexander Shiyan <shc_work@mail.ru>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 23, 2020 at 11:30:19AM +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 22, 2020 at 5:00 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> > Since the PWM framework is switching struct pwm_args.period's datatype
> > to u64, prepare for this transition by typecasting it to u32.
> >
> > Also, since the dividend is still a 32-bit number, any divisor greater
> > than the numerator will cause the quotient to be zero, so return 0 in
> > that case to efficiently skip the division.
> >
> > Cc: Alexander Shiyan <shc_work@mail.ru>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> >
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > ---
> >  drivers/pwm/pwm-clps711x.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> > index 924d39a..0d368ac 100644
> > --- a/drivers/pwm/pwm-clps711x.c
> > +++ b/drivers/pwm/pwm-clps711x.c
> > @@ -43,7 +43,10 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
> >  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
> >  {
> >         /* Duty cycle 0..15 max */
> > -       return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > +       if ((u32)pwm->args.period > (v * 0xf))
> 
> Shouldn't the cast be removed from the expression above?
> Else a period larger than or equal to 2^32 may be accepted, but truncated
> silently.  And even cause a division by zero error.

I agree. Will remove the cast in the next patchset.

Thank you.

Guru Das.
