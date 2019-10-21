Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from uho.ysoft.cz ([81.19.3.130]:49608 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbfJUNez (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 21 Oct 2019 09:34:55 -0400
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <85480416-635e-3f88-d0d4-38bb0f1755da@ysoft.com>
Date: Mon, 21 Oct 2019 15:34:52 +0200
MIME-Version: 1.0
In-Reply-To: <20191021105739.1357629-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 1/4] pwm: Read initial hardware state at request time
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pwm@vger.kernel.org

On 21. 10. 19 12:57, Thierry Reding wrote:
> The PWM core doesn't need to know about the hardware state of a PWM
> unless there is a user for it. Defer initial hardware readout until
> a PWM is requested.
> 
> As a side-effect, this allows the ->get_state() callback to rely on
> per-PWM data.

I tried this on top of v5.4-rc3 on imx6dl-yapp4-draco with pwm-backlight
consumer and on imx6dl-yapp4-hydra with PWM from sysfs and I do not see
any obvious problems.

Tested-by: Michal Vokáč <michal.vokac@ysoft.com>

> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>   drivers/pwm/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index f877e77d9184..e067873c6cc5 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -114,6 +114,9 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>   		}
>   	}
>   
> +	if (pwm->chip->ops->get_state)
> +		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
> +
>   	set_bit(PWMF_REQUESTED, &pwm->flags);
>   	pwm->label = label;
>   
> @@ -283,9 +286,6 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>   		pwm->hwpwm = i;
>   		pwm->state.polarity = polarity;
>   
> -		if (chip->ops->get_state)
> -			chip->ops->get_state(chip, pwm, &pwm->state);
> -
>   		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
>   	}
>   
> 
