From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] pwm: fix undefined behavior in stm32_pwm_apply
Date: Thu, 26 Jan 2017 12:16:18 +0000
Message-ID: <20170126121618.s66oob576faozd6z@dell>
References: <20170125223155.1388582-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34906 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbdAZMQW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 26 Jan 2017 07:16:22 -0500
Received: by mail-wm0-f54.google.com with SMTP id r126so69317034wmr.0
        for <linux-pwm@vger.kernel.org>; Thu, 26 Jan 2017 04:16:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170125223155.1388582-1-arnd@arndb.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, 25 Jan 2017, Arnd Bergmann wrote:

> The stm32_pwm_apply randomly sets the polarity or doesn't,
> as pointed out by this gcc warning:
> 
> drivers/pwm/pwm-stm32.c: In function 'stm32_pwm_apply':
> drivers/pwm/pwm-stm32.c:204:33: error: 'curstate.polarity' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> I assume it was meant to compare the new state to the current
> state rather than an uninitialized stack variable, so let's
> do that instead.
> 
> Fixes: bafffb6e7bd1 ("pwm: Add driver for STM32 plaftorm")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/pwm-stm32.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Fix from the author already applied.

> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index ce6232ebefe1..6139512aab7b 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -189,7 +189,6 @@ static void stm32_pwm_disable(struct stm32_pwm *priv, int ch)
>  static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			   struct pwm_state *state)
>  {
> -	struct pwm_state curstate;
>  	bool enabled;
>  	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
>  	int ret;
> @@ -201,7 +200,7 @@ static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return 0;
>  	}
>  
> -	if (state->polarity != curstate.polarity)
> +	if (state->polarity != pwm->state.polarity)
>  		stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
>  
>  	ret = stm32_pwm_config(priv, pwm->hwpwm,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
