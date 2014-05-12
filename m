From: Ajay kumar <ajaynumb@gmail.com>
Subject: Re: [PATCH] pwm: samsung: do not set manual update bit in pwm_samsung_config
Date: Mon, 12 May 2014 20:29:09 +0530
Message-ID: <CAEC9eQNYH5O1gTjh-X+P8ppy=N3F1PMY+ZHd-=TRhs1TajVMWA@mail.gmail.com>
References: <1399906581-29298-1-git-send-email-ajaykumar.rs@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1399906581-29298-1-git-send-email-ajaykumar.rs@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, Andrew Bresticker <abrestic@chromium.org>, Jingoo Han <jg1.han@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, Ajay Kumar <ajaykumar.rs@samsung.com>
List-Id: linux-pwm@vger.kernel.org

This is a simpler version of https://patchwork.kernel.org/patch/3113001/

On Mon, May 12, 2014 at 8:26 PM, Ajay Kumar <ajaykumar.rs@samsung.com> wrote:
> pwm_samsung_config sets manual update bit via call to
> pwm_samsung_enable even when the channel is already running.
> This causes noticable flickers on display if we try to change
> the backlight value from 0 to MAX, continiously.
>
> So, we remove the call to pwm_samsung_enable from
> pwm_samsung_config to avoid the flicker and this change doesn't
> harm normal working since the pwm_bl core already takes care of
> calling pwm_samsung_enable whenever needed.
>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  drivers/pwm/pwm-samsung.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index d66529a..ba6b650 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -335,9 +335,6 @@ static int pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
>         writel(tcnt, our_chip->base + REG_TCNTB(pwm->hwpwm));
>         writel(tcmp, our_chip->base + REG_TCMPB(pwm->hwpwm));
>
> -       if (test_bit(PWMF_ENABLED, &pwm->flags))
> -               pwm_samsung_enable(chip, pwm);
> -
>         chan->period_ns = period_ns;
>         chan->tin_ns = tin_ns;
>         chan->duty_ns = duty_ns;
> --
> 1.8.3.2
>
