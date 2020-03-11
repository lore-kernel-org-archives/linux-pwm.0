From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v8 01/12] clk: pwm: Use 64-bit division function
Date: Wed, 11 Mar 2020 16:58:24 +0000
Message-ID: <7506bc2972324fd286dac6327ec73a3a@AcuMS.aculab.com>
References: <cover.1583889178.git.gurus@codeaurora.org>
 <338966686a673c241905716c90049993e7bb7d6a.1583889178.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:37128 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730031AbgCKQ63 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 12:58:29 -0400
In-Reply-To: <338966686a673c241905716c90049993e7bb7d6a.1583889178.git.gurus@codeaurora.org>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Guru Das Srinagesh' <gurus@codeaurora.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>

From: Guru Das Srinagesh
> Sent: 11 March 2020 01:41
> 
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by using div64_u64 to handle a
> 64-bit divisor.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/clk/clk-pwm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
> index 87fe0b0e..7b1f7a0 100644
> --- a/drivers/clk/clk-pwm.c
> +++ b/drivers/clk/clk-pwm.c
> @@ -89,7 +89,7 @@ static int clk_pwm_probe(struct platform_device *pdev)
>  	}
> 
>  	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
> -		clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
> +		clk_pwm->fixed_rate = div64_u64(NSEC_PER_SEC, pargs.period);

That cannot be needed, a 32 bit division is fine.
More interesting would be whether pargs.period is sane (eg not zero).
I'd assign pargs.period to an 'unsigned int' variable
prior to the division (I hate casts - been bitten by them in the past.).

> 
>  	if (pargs.period != NSEC_PER_SEC / clk_pwm->fixed_rate &&
>  	    pargs.period != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
