From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 04/11] pwm: clps711x: Use 64-bit division macro
Date: Wed, 18 Mar 2020 20:38:29 +0100
Message-ID: <CAK8P3a2A3RuRu3bOSvq58Unb=vpnYnkxKsxJdLqkS=hPFDgM2Q@mail.gmail.com>
References: <cover.1584473399.git.gurus@codeaurora.org> <587f9ccae68ad7e1ce97fa8da6037292af1a5095.1584473399.git.gurus@codeaurora.org>
 <CAK8P3a2Hi_AoRC3g7qKth4e_Y1jZrbBDhWUb3YPZm10FWMu-ig@mail.gmail.com>
 <20200317233003.GA11350@codeaurora.org> <CAK8P3a2a-QEwFfDE5FbFCVdDS+t9jirgbHWJQQv0i5_OMCYXJg@mail.gmail.com>
 <20200318170010.GA26509@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:55301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRTis (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Mar 2020 15:38:48 -0400
In-Reply-To: <20200318170010.GA26509@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Shiyan <shc_work@mail.ru>

On Wed, Mar 18, 2020 at 6:00 PM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> On Wed, Mar 18, 2020 at 10:49:34AM +0100, Arnd Bergmann wrote:
> > On Wed, Mar 18, 2020 at 12:30 AM Guru Das Srinagesh
> > <gurus@codeaurora.org> wrote:
> > >
> > > On Tue, Mar 17, 2020 at 11:22:06PM +0100, Arnd Bergmann wrote:
> > > > > diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> > > > > index 924d39a..ba9500a 100644
> > > > > --- a/drivers/pwm/pwm-clps711x.c
> > > > > +++ b/drivers/pwm/pwm-clps711x.c
> > > > > @@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
> > > > >  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
> > > > >  {
> > > > >         /* Duty cycle 0..15 max */
> > > > > -       return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > > > > +       return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> > > > >  }
> > > >
> > > > Is it actually going to exceed U32_MAX? If not, a type cast may be
> > > > more appropriate here than the expensive 64-bit division.
> > >
> > > With the final change in this patch series, the framework will support
> > > periods that exceed U32_MAX. My concern is that using a typecast would
> > > mean that in those cases, this driver will not support > U32_MAX values.
> > > Using DIV64_U64_ROUND_CLOSEST makes the driver future proof and able to
> > > handle > U32_MAX values correctly. What do you think?
> >
> > Ah, so if the period can actually be larger than U32_MAX, you need to
> > handle that case. However, I see that the divident in this code (v * 0xf)
> > is still a 32-bit number, so a correct and efficient implementation could be
> >
> >    if (pwm->args.period > (UINT_MAX / 0xf))
>
> Shouldn't the if condition be the following? Or am I missing
> something here?
>
>      if (pwm->args.period > (UINT_MAX / (v * 0xf)))
>                                         ^^^^^^^^^

That would require performing a division, which is an external function
call on ARMv4. My version just checks for an upper bound and completely
avoids the division. You could also just check for ">UINT_MAX" if you
find that clearer.

      Arnd
