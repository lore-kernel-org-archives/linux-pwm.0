From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] pwm: mxs: fix period divider computation
Date: Mon, 2 Mar 2015 20:32:09 +0800
Message-ID: <20150302123206.GD3040@dragon>
References: <1424264794-12167-1-git-send-email-ghug@induct.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34487 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbCBMcY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Mar 2015 07:32:24 -0500
Received: by paceu11 with SMTP id eu11so3664pac.1
        for <linux-pwm@vger.kernel.org>; Mon, 02 Mar 2015 04:32:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1424264794-12167-1-git-send-email-ghug@induct.be>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Gaetan Hug <ghug@induct.be>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, fabio.estevam@freescale.com

On Wed, Feb 18, 2015 at 02:06:34PM +0100, Gaetan Hug wrote:
> The driver computes which clock divider it sould be using from the
> requested period. This computation assumes that the link between the
> register value and the actual divider value is raising 2 to the power of
> the registry value.
> 
>     div = 1 << regvalue
> 
> This is true only for the first 5 values out of 8. Next values are 64,
> 256 and, 1024 - instead of 32, 64, 128.

Just checked i.MX28 Reference Manual, and yes, this is the case.

> This affects only the users requesting a period > 0.04369s.
> 
> Replace the computation with a look-up table.

Your SoB is missing here.  Otherwise,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/pwm/pwm-mxs.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index f75ecb0..c65e183 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -35,6 +35,8 @@
>  #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
>  #define  PERIOD_CDIV_MAX	8
>  
> +static unsigned const int cdiv[PERIOD_CDIV_MAX] = {1, 2, 4, 8, 16, 64, 256, 1024};
> +
>  struct mxs_pwm_chip {
>  	struct pwm_chip chip;
>  	struct clk *clk;
> @@ -54,13 +56,13 @@ static int mxs_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	rate = clk_get_rate(mxs->clk);
>  	while (1) {
> -		c = rate / (1 << div);
> +		c = rate / cdiv[div];
>  		c = c * period_ns;
>  		do_div(c, 1000000000);
>  		if (c < PERIOD_PERIOD_MAX)
>  			break;
>  		div++;
> -		if (div > PERIOD_CDIV_MAX)
> +		if (div >= PERIOD_CDIV_MAX)
>  			return -EINVAL;
>  	}
>  
> -- 
> 1.7.10.4
> 
