From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 11/12] clk: pwm: Assign u64 divisor to unsigned int
 before use
Date: Fri, 20 Mar 2020 18:00:51 +0100
Message-ID: <CAK8P3a0XrYGYBQ_hTKF4fVBr7DDZsLnR+8o=09cig_gAje=v3w@mail.gmail.com>
References: <cover.1584667964.git.gurus@codeaurora.org> <ab7b568b1d287949276b3b1c9efdb1cad1f92004.1584667964.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:56023 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgCTRBK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Mar 2020 13:01:10 -0400
In-Reply-To: <ab7b568b1d287949276b3b1c9efdb1cad1f92004.1584667964.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk <linux-clk@vger.kernel.org>, David Laight <David.Laight@aculab.com>

On Fri, Mar 20, 2020 at 2:42 AM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by assigning the 64-bit divisor to
> an unsigned int variable to use as the divisor. This is being done
> because the divisor is a 32-bit constant and the quotient will be zero
> if the divisor exceeds 2^32.
>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: David Laight <David.Laight@ACULAB.COM>
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/clk/clk-pwm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> index 87fe0b0e..c0b5da3 100644
> --- a/drivers/clk/clk-pwm.c
> +++ b/drivers/clk/clk-pwm.c
> @@ -72,6 +72,7 @@ static int clk_pwm_probe(struct platform_device *pdev)
>         struct pwm_device *pwm;
>         struct pwm_args pargs;
>         const char *clk_name;
> +       unsigned int period;
>         int ret;
>
>         clk_pwm = devm_kzalloc(&pdev->dev, sizeof(*clk_pwm), GFP_KERNEL);
> @@ -88,8 +89,9 @@ static int clk_pwm_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> +       period = pargs.period;
>         if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
> -               clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
> +               clk_pwm->fixed_rate = NSEC_PER_SEC / period;
>
>         if (pargs.period != NSEC_PER_SEC / clk_pwm->fixed_rate &&
>             pargs.period != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {

Doesn't this one need a check for "pargs.period>UINT_MAX" or
"pargs.period > NSEC_PER_SEC"?

It looks like truncating the 64-bit value to a 32-bit type can result in
unexpected behavior.

       Arnd
