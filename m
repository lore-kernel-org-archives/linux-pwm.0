From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 04/11] pwm: clps711x: Use 64-bit division macro
Date: Wed, 18 Mar 2020 10:49:34 +0100
Message-ID: <CAK8P3a2a-QEwFfDE5FbFCVdDS+t9jirgbHWJQQv0i5_OMCYXJg@mail.gmail.com>
References: <cover.1584473399.git.gurus@codeaurora.org> <587f9ccae68ad7e1ce97fa8da6037292af1a5095.1584473399.git.gurus@codeaurora.org>
 <CAK8P3a2Hi_AoRC3g7qKth4e_Y1jZrbBDhWUb3YPZm10FWMu-ig@mail.gmail.com> <20200317233003.GA11350@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317233003.GA11350@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Shiyan <shc_work@mail.ru>
List-Id: linux-pwm@vger.kernel.org

On Wed, Mar 18, 2020 at 12:30 AM Guru Das Srinagesh
<gurus@codeaurora.org> wrote:
>
> On Tue, Mar 17, 2020 at 11:22:06PM +0100, Arnd Bergmann wrote:
> > > diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> > > index 924d39a..ba9500a 100644
> > > --- a/drivers/pwm/pwm-clps711x.c
> > > +++ b/drivers/pwm/pwm-clps711x.c
> > > @@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
> > >  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
> > >  {
> > >         /* Duty cycle 0..15 max */
> > > -       return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > > +       return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > >  }
> >
> > Is it actually going to exceed U32_MAX? If not, a type cast may be
> > more appropriate here than the expensive 64-bit division.
>
> With the final change in this patch series, the framework will support
> periods that exceed U32_MAX. My concern is that using a typecast would
> mean that in those cases, this driver will not support > U32_MAX values.
> Using DIV64_U64_ROUND_CLOSEST makes the driver future proof and able to
> handle > U32_MAX values correctly. What do you think?

Ah, so if the period can actually be larger than U32_MAX, you need to
handle that case. However, I see that the divident in this code (v * 0xf)
is still a 32-bit number, so a correct and efficient implementation could be

   if (pwm->args.period > (UINT_MAX / 0xf))
          return 0;
   return DIV_ROUND_CLOSEST(v * 0xf, (u32)pwm->args.period);

        Arnd
