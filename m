From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [RESEND PATCH v14 04/11] pwm: clps711x: Cast period to u32
 before use as divisor
Date: Thu, 21 May 2020 11:19:34 +0100
Message-ID: <20200521101934.j5ivjky4e6byveut@holly.lan>
References: <cover.1589330178.git.gurus@codeaurora.org>
 <1d6918c3fc2976bdbdb687bf54a2ef09fc1558db.1589330178.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgEUKTi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 May 2020 06:19:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7508AC061A0E
        for <linux-pwm@vger.kernel.org>; Thu, 21 May 2020 03:19:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e1so6124198wrt.5
        for <linux-pwm@vger.kernel.org>; Thu, 21 May 2020 03:19:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1d6918c3fc2976bdbdb687bf54a2ef09fc1558db.1589330178.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, David Collins <collinsd@codeaurora.org>, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Guenter Roeck <linux@roeck-us.net>, Dan Carpenter <dan.carpenter@oracle.com>, linux-arm-kernel@lists.infradead.org

On Wed, May 20, 2020 at 03:55:57PM -0700, Guru Das Srinagesh wrote:
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by typecasting it to u32.
> 
> Also, since the dividend is still a 32-bit number, any divisor greater
> than the numerator will cause the quotient to be zero, so return 0 in
> that case to efficiently skip the division.
> 
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/pwm-clps711x.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> index 924d39a..da771b1 100644
> --- a/drivers/pwm/pwm-clps711x.c
> +++ b/drivers/pwm/pwm-clps711x.c
> @@ -43,7 +43,10 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
>  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
>  {
>  	/* Duty cycle 0..15 max */
> -	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> +	if (pwm->args.period > (v * 0xf))
> +		return 0;

This doesn't look right to me.

DIV_ROUND_CLOSEST() does rounded division and the short circuit doesn't
implement that.


Daniel.

> +
> +	return DIV_ROUND_CLOSEST(v * 0xf, (u32)pwm->args.period);
>  }
>  
>  static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
