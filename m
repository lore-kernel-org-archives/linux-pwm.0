From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 06/12] pwm: imx27: Use 64-bit division macro and function
Date: Thu, 2 Apr 2020 23:16:22 +0200
Message-ID: <CAK8P3a3mc_sYczyKiaDoQLTTwDj2odwHJ5LFNAOb4RaRyh0YLQ@mail.gmail.com>
References: <cover.1584667964.git.gurus@codeaurora.org> <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com>
 <20200330204359.GB5107@codeaurora.org> <CAK8P3a1VC6+0Tydm=BoK2NvHB1ZCPjE1Gfi-sTE5O-xnu3Ya3A@mail.gmail.com>
 <20200331202058.GB25781@codeaurora.org> <20200331204929.GC2954599@ulmo> <20200402201654.GA9191@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:52329 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBVQl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Apr 2020 17:16:41 -0400
In-Reply-To: <20200402201654.GA9191@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, David Collins <collinsd@codeaurora.org>

On Thu, Apr 2, 2020 at 10:16 PM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> On Tue, Mar 31, 2020 at 10:49:29PM +0200, Thierry Reding wrote:
> > Doesn't that mean that anything below a 1 second period will be clamped
> > to just 0?
>
> True. How about this then?
>
> int pwm_imx27_calc_period_cycles(struct pwm_state state,
>                                  unsigned long clk_rate,
>                                  unsigned long *period_cycles)
> {
>         u64 c1, c2;
>
>         c1 = clk_rate;
>         c2 = state->period;
>         if (c2 > c1) {
>                 c2 = c1;
>                 c1 = state->period;
>         }
>
>         if (!c1 || !c2) {
>                 pr_err("clk rate and period should be nonzero\n");
>                 return -EINVAL;
>         }
>
>         if (c2 <= div64_u64(U64_MAX, c1)) {
>                 c = c1 * c2;
>                 do_div(c, 1000000000);
>         } else if (c2 <= div64_u64(U64_MAX, div64_u64(c1, 1000))) {
>                 do_div(c1, 1000);
>                 c = c1 * c2;
>                 do_div(c, 1000000);
>         } else if (c2 <= div64_u64(U64_MAX, div64_u64(c1, 1000000))) {
>                 do_div(c1, 1000000);
>                 c = c1 * c2;
>                 do_div(c, 1000);
>         } else if (c2 <= div64_u64(U64_MAX, div64_u64(c1, 1000000000))) {
>                 do_div(c1, 1000000000);
>                 c = c1 * c2;
>         }
>
>         *period_cycles = c;
>
>         return 0;
> }
>
> ...
>
> ret = pwm_imx27_calc_period_cycles(state, clk_get_rate(imx->clk_per),
>                                    &period_cycles);
> if (ret)
>         return ret;
>
> I unit tested this logic out by calculating period_cycles using both the
> existing logic and the proposed one, and the results are as below.
>
> --------------------------------------------------------------------------------
>  clk_rate               period            existing            proposed
> --------------------------------------------------------------------------------
> 1000000000      18446744073709551615     18446744072    18446744073000000000
>                       (U64_MAX)
> --------------------------------------------------------------------------------
> 1000000000           4294967291          4294967291         4294967291
> --------------------------------------------------------------------------------
>
> Overflow occurs in the first case with the existing logic, whereas the
> proposed logic handles it correctly. As for the second case where there are
> more typical values of period, the proposed logic handles that correctly
> too.

This looks correct, but very expensive, and you don't really have to
go this far, given that c1 is guaranteed to be a 32-bit number, and
you divide by a constant in the end.

Why not do something like

#define SHIFT 41 /* arbitrarily picked, not too big, not too small */
#define MUL 2199 /* 2^SHIFT / NSEC_PER_SEC */
period_cycles = clk_get_rate(imx->clk_per) * ((state->period * MUL) >> SHIFT);

        Arnd
