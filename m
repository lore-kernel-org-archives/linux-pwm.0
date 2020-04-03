From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 06/12] pwm: imx27: Use 64-bit division macro and function
Date: Fri, 3 Apr 2020 21:13:18 +0200
Message-ID: <CAK8P3a2Ua5v67vLLzQxsLPZfX9z5D7o-sfFpurQVWVykRK8sEQ@mail.gmail.com>
References: <cover.1584667964.git.gurus@codeaurora.org> <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com>
 <20200330204359.GB5107@codeaurora.org> <CAK8P3a1VC6+0Tydm=BoK2NvHB1ZCPjE1Gfi-sTE5O-xnu3Ya3A@mail.gmail.com>
 <20200331202058.GB25781@codeaurora.org> <20200331204929.GC2954599@ulmo>
 <20200402201654.GA9191@codeaurora.org> <CAK8P3a3mc_sYczyKiaDoQLTTwDj2odwHJ5LFNAOb4RaRyh0YLQ@mail.gmail.com>
 <20200403173719.GA6169@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:47575 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgDCTNj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 15:13:39 -0400
In-Reply-To: <20200403173719.GA6169@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, David Collins <collinsd@codeaurora.org>

On Fri, Apr 3, 2020 at 7:37 PM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> On Thu, Apr 02, 2020 at 11:16:22PM +0200, Arnd Bergmann wrote:
> > This looks correct, but very expensive, and you don't really have to
> > go this far, given that c1 is guaranteed to be a 32-bit number, and
> > you divide by a constant in the end.
> >
> > Why not do something like
> >
> > #define SHIFT 41 /* arbitrarily picked, not too big, not too small */
> > #define MUL 2199 /* 2^SHIFT / NSEC_PER_SEC */
> > period_cycles = clk_get_rate(imx->clk_per) * ((state->period * MUL) >> SHIFT);
>
> I have two concerns with this:
>
> 1. This actually results in the division by 1000010575.5125057 instead
>    of NSECS_PER_SEC whereas both the existing as well as the proposed logic
>    divide exactly by NSECS_PER_SEC.
> 2. What method shall be used to pick the SHIFT value? How is this to be
>    chosen?

I picked one that would result in a fairly accurate rounding and did not
seem too likely to overflow.

> Also, this seems sort of similar to my initial attempt at this
> problem, where period was being pre-divided prior to the multiplication,
> which was (rightly) NACKed.
>
>         c *= div_u64(state->period, 1000000000);

Ah, right, I did make the same mistake here. What I actually indended
was to do two separate shifts that add up to 41. I suppose there is also still
the fundamental problem that without bounds checking the calculation can
always overflow for large inputs.

       Arnd
