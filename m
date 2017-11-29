From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] pwm: meson: fix harware duty calculation
Date: Wed, 29 Nov 2017 08:34:31 +0100
Message-ID: <1511940871.27425.4.camel@baylibre.com>
References: <20171129030308.22036-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33291 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbdK2Heg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Nov 2017 02:34:36 -0500
Received: by mail-wr0-f196.google.com with SMTP id v22so2473333wrb.0
        for <linux-pwm@vger.kernel.org>; Tue, 28 Nov 2017 23:34:35 -0800 (PST)
In-Reply-To: <20171129030308.22036-1-yixun.lan@amlogic.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yixun Lan <yixun.lan@amlogic.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>

On Wed, 2017-11-29 at 11:03 +0800, Yixun Lan wrote:
> From: Jian Hu <jian.hu@amlogic.com>
> 
> The actual HIGH/LOW signal output from the PWM is equal to
> the value programed to HW register plus one, this is designed by HW.
> 
> This fix should apply to all Meson SoC(include GX/GXL/GXBB, Meson6,8)
> 
> Fixes: 211ed630753d ("pwm: Add support for Meson PWM Controller")
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/pwm/pwm-meson.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index d589331d1884..78d9b8c1a4bc 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -193,6 +193,11 @@ static int meson_pwm_calc(struct meson_pwm *meson,
>  			break;
>  	}
>  
> +	if (cnt < 2) {
> +		dev_err(meson->chip.dev, "invalid period\n");
> +		return -EINVAL;
> +	}
> +
>  	if (pre_div == MISC_CLK_DIV_MASK) {
>  		dev_err(meson->chip.dev, "unable to get period pre_div\n");
>  		return -EINVAL;
> @@ -201,19 +206,23 @@ static int meson_pwm_calc(struct meson_pwm *meson,
>  	dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
>  		pre_div, cnt);
>  
> +	/*
> +	 * Due to the design of hardware, values of 'hi', 'lo' are 1 based
> +	 * which mean the actual output from hardware is 'hi' + 1, 'lo' + 1
> +	 */
>  	if (duty == period) {
>  		channel->pre_div = pre_div;
> -		channel->hi = cnt;
> +		channel->hi = cnt - 1;
>  		channel->lo = 0;
>  	} else if (duty == 0) {
>  		channel->pre_div = pre_div;
>  		channel->hi = 0;
> -		channel->lo = cnt;
> +		channel->lo = cnt - 1;
>  	} else {
>  		/* Then check is we can have the duty with the same pre_div
> */
>  		duty_cnt = DIV_ROUND_CLOSEST_ULL((u64)duty * 1000,
>  						 fin_ps * (pre_div + 1));
> -		if (duty_cnt > 0xffff) {
> +		if (duty_cnt > 0xffff || !duty_cnt) {

duty_cnt = 0 is a valid value here. It will be the case for duty != 0 but low
enough for the HW (calculation) to approximate the duty cycle to zero.

>  			dev_err(meson->chip.dev, "unable to get duty
> cycle\n");
>  			return -EINVAL;
>  		}
> @@ -222,8 +231,8 @@ static int meson_pwm_calc(struct meson_pwm *meson,
>  			duty, pre_div, duty_cnt);
>  
>  		channel->pre_div = pre_div;
> -		channel->hi = duty_cnt;
> -		channel->lo = cnt - duty_cnt;
> +		channel->hi = duty_cnt - 1;

As explained above, duty_cnt could be zero, you need to take care of this here

> +		channel->lo = cnt - duty_cnt - 1;

Same here, it is possible duty_cnt to be egual to cnt so you also need to be
careful here

>  	}
>  
>  	return 0;
