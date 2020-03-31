From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 06/12] pwm: imx27: Use 64-bit division macro and function
Date: Tue, 31 Mar 2020 17:24:52 +0200
Message-ID: <CAK8P3a1VC6+0Tydm=BoK2NvHB1ZCPjE1Gfi-sTE5O-xnu3Ya3A@mail.gmail.com>
References: <cover.1584667964.git.gurus@codeaurora.org> <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com> <20200330204359.GB5107@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:52749 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbgCaPZM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Mar 2020 11:25:12 -0400
In-Reply-To: <20200330204359.GB5107@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>

On Mon, Mar 30, 2020 at 10:44 PM Guru Das Srinagesh
<gurus@codeaurora.org> wrote:
>
> On Fri, Mar 20, 2020 at 06:09:39PM +0100, Arnd Bergmann wrote:
> > On Fri, Mar 20, 2020 at 2:42 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> >
> > > @@ -240,8 +240,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > >
> > >         period_cycles /= prescale;
> > >         c = (unsigned long long)period_cycles * state->duty_cycle;
> > > -       do_div(c, state->period);
> > > -       duty_cycles = c;
> > > +       duty_cycles = div64_u64(c, state->period);
> > >
> >
> > This change looks fine, but I wonder if the code directly above it
> >
> >         c = clk_get_rate(imx->clk_per);
> >         c *= state->period;
> >         do_div(c, 1000000000);
> >         period_cycles = c;
> >
> > might run into an overflow when both the clock rate and the period
> > are large numbers.
>
> Hmm. Seems to me like addressing this would be outside the scope of this
> patch series.

I think it should be part of the same series, addressing bugs that
were introduced
by the change to 64-bit period. If it's not getting fixed along with
the other regressions,
I fear nobody is going to go back and fix it later.

      Arnd
