From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] pwm: meson: consider 128 a valid pre-divider
Date: Tue, 2 Apr 2019 21:55:54 +0200
Message-ID: <20190402195554.5efbtjr6bswoigzt@pengutronix.de>
References: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
 <20190401181817.11999-2-martin.blumenstingl@googlemail.com>
 <20190401183847.7xhlgff63cvlzz2h@pengutronix.de>
 <CAFBinCDac9189=+UVLPLqdmJsJvudys_L0GE=Zf0FRkOWsruuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFBinCDac9189=+UVLPLqdmJsJvudys_L0GE=Zf0FRkOWsruuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bichao.zheng@amlogic.com
List-Id: linux-pwm@vger.kernel.org

On Tue, Apr 02, 2019 at 09:22:55PM +0200, Martin Blumenstingl wrote:
> Hello Uwe,
> 
> On Mon, Apr 1, 2019 at 8:38 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello Martin,
> >
> > On Mon, Apr 01, 2019 at 08:18:16PM +0200, Martin Blumenstingl wrote:
> > > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > > index f6e738ad7bd9..4b708c1fcb1d 100644
> > > --- a/drivers/pwm/pwm-meson.c
> > > +++ b/drivers/pwm/pwm-meson.c
> > > @@ -188,7 +188,7 @@ static int meson_pwm_calc(struct meson_pwm *meson,
> > >       do_div(fin_ps, fin_freq);
> > >
> > >       /* Calc pre_div with the period */
> > > -     for (pre_div = 0; pre_div < MISC_CLK_DIV_MASK; pre_div++) {
> > > +     for (pre_div = 0; pre_div <= MISC_CLK_DIV_MASK; pre_div++) {
> > >               cnt = DIV_ROUND_CLOSEST_ULL((u64)period * 1000,
> > >                                           fin_ps * (pre_div + 1));
> > >               dev_dbg(meson->chip.dev, "fin_ps=%llu pre_div=%u cnt=%u\n",
> >
> > You could even calculate pre_div without the loop.
> >
> > Something like:
> >
> >         u64 pre_div = (u64)period * rate;
> >         do_div_round_up(pre_div, NSEC_PER_SEC * 0xffff);
> >         pre_div--;
> >
> > (I didn't check rounding and maybe its off by one and ...) This would
> > also get rid of the strange 1000 that is currently used in the
> > calculation without a real benefit (unless I missed something).
> personally I prefer using this simple patch applied first as it is
> easy to review and (due to the Fixes tag) may get backported to stable
> kernels.
> I'm not saying I don't like your suggestion, I propose to postpone
> implementing this cleanup. I need to have a closer look at the
> calculation because three values are derived from the input clock rate
> (pre_div, cnt, duty_cnt) and I don't want to mess up the cases that
> are already working as of today.
> 
> Please let me know what you think.

That's also ok for me. In this case take my

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
