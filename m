From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v11 06/12] pwm: imx27: Use 64-bit division macro and
 function
Date: Mon, 30 Mar 2020 13:43:59 -0700
Message-ID: <20200330204359.GB5107@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:4960 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728123AbgC3UoU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 16:44:20 -0400
Content-Disposition: inline
In-Reply-To: <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>

On Fri, Mar 20, 2020 at 06:09:39PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 20, 2020 at 2:42 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> 
> > @@ -240,8 +240,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >
> >         period_cycles /= prescale;
> >         c = (unsigned long long)period_cycles * state->duty_cycle;
> > -       do_div(c, state->period);
> > -       duty_cycles = c;
> > +       duty_cycles = div64_u64(c, state->period);
> >
> 
> This change looks fine, but I wonder if the code directly above it
> 
>         c = clk_get_rate(imx->clk_per);
>         c *= state->period;
>         do_div(c, 1000000000);
>         period_cycles = c;
> 
> might run into an overflow when both the clock rate and the period
> are large numbers.

Hmm. Seems to me like addressing this would be outside the scope of this
patch series.

Thank you.

Guru Das.
