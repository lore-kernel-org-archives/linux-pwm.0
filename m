From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v12 10/11] clk: pwm: Use 64-bit division function
Date: Fri, 10 Apr 2020 12:15:03 -0700
Message-ID: <20200410191503.GA21571@codeaurora.org>
References: <cover.1586414867.git.gurus@codeaurora.org>
 <d5127aa19a128edf7c3dd437291b366b77be4ac5.1586414867.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d5127aa19a128edf7c3dd437291b366b77be4ac5.1586414867.git.gurus@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, David Laight <David.Laight@ACULAB.COM>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pwm@vger.kernel.org

+ Arnd, David

On Wed, Apr 08, 2020 at 11:52:39PM -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by using div64_u64 to handle a
> 64-bit divisor.
> 
> Also ensure that divide-by-zero (with fixed_rate as denominator) does
> not happen with an explicit check with probe failure as a consequence.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/clk/clk-pwm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> index 87fe0b0e..86f2e2d 100644
> --- a/drivers/clk/clk-pwm.c
> +++ b/drivers/clk/clk-pwm.c
> @@ -89,7 +89,12 @@ static int clk_pwm_probe(struct platform_device *pdev)
>  	}
>  
>  	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
> -		clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
> +		clk_pwm->fixed_rate = div64_u64(NSEC_PER_SEC, pargs.period);
> +
> +	if (!clk_pwm->fixed_rate) {
> +		dev_err(&pdev->dev, "fixed_rate cannot be zero\n");
> +		return -EINVAL;
> +	}
>  
>  	if (pargs.period != NSEC_PER_SEC / clk_pwm->fixed_rate &&
>  	    pargs.period != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
> -- 

Hello Arnd, David:

Sorry, missed cc-ing you both to this patch while sending it out. Could
you please review it when you get a chance to?

Thank you.

Guru Das.
