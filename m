From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 04/11] pwm: clps711x: Use 64-bit division macro
Date: Tue, 17 Mar 2020 23:22:06 +0100
Message-ID: <CAK8P3a2Hi_AoRC3g7qKth4e_Y1jZrbBDhWUb3YPZm10FWMu-ig@mail.gmail.com>
References: <cover.1584473399.git.gurus@codeaurora.org> <587f9ccae68ad7e1ce97fa8da6037292af1a5095.1584473399.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:37297 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCQWWZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 18:22:25 -0400
In-Reply-To: <587f9ccae68ad7e1ce97fa8da6037292af1a5095.1584473399.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Shiyan <shc_work@mail.ru>

On Tue, Mar 17, 2020 at 9:05 PM Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>
> Since the PWM framework is switching struct pwm_args.period's datatype
> to u64, prepare for this transition by using DIV64_U64_ROUND_CLOSEST to
> handle a 64-bit divisor.
>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Arnd Bergmann <arnd@arndb.de>
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/pwm-clps711x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
> index 924d39a..ba9500a 100644
> --- a/drivers/pwm/pwm-clps711x.c
> +++ b/drivers/pwm/pwm-clps711x.c
> @@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
>  static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
>  {
>         /* Duty cycle 0..15 max */
> -       return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
> +       return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
>  }

Is it actually going to exceed U32_MAX? If not, a type cast may be
more appropriate here than the expensive 64-bit division.

       Arnd
