From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v11 06/12] pwm: imx27: Use 64-bit division macro and
 function
Date: Fri, 3 Apr 2020 10:37:19 -0700
Message-ID: <20200403173719.GA6169@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com>
 <20200330204359.GB5107@codeaurora.org>
 <CAK8P3a1VC6+0Tydm=BoK2NvHB1ZCPjE1Gfi-sTE5O-xnu3Ya3A@mail.gmail.com>
 <20200331202058.GB25781@codeaurora.org>
 <20200331204929.GC2954599@ulmo>
 <20200402201654.GA9191@codeaurora.org>
 <CAK8P3a3mc_sYczyKiaDoQLTTwDj2odwHJ5LFNAOb4RaRyh0YLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:28928 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728329AbgDCRhU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 13:37:20 -0400
Content-Disposition: inline
In-Reply-To: <CAK8P3a3mc_sYczyKiaDoQLTTwDj2odwHJ5LFNAOb4RaRyh0YLQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, David Collins <collinsd@codeaurora.org>

On Thu, Apr 02, 2020 at 11:16:22PM +0200, Arnd Bergmann wrote:
> This looks correct, but very expensive, and you don't really have to
> go this far, given that c1 is guaranteed to be a 32-bit number, and
> you divide by a constant in the end.
> 
> Why not do something like
> 
> #define SHIFT 41 /* arbitrarily picked, not too big, not too small */
> #define MUL 2199 /* 2^SHIFT / NSEC_PER_SEC */
> period_cycles = clk_get_rate(imx->clk_per) * ((state->period * MUL) >> SHIFT);

I have two concerns with this:

1. This actually results in the division by 1000010575.5125057 instead
   of NSECS_PER_SEC whereas both the existing as well as the proposed logic
   divide exactly by NSECS_PER_SEC.
2. What method shall be used to pick the SHIFT value? How is this to be
   chosen?

Also, this seems sort of similar to my initial attempt at this
problem, where period was being pre-divided prior to the multiplication,
which was (rightly) NACKed.

	c *= div_u64(state->period, 1000000000);

Thank you.

Guru Das.
