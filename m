From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 3/7] pwm: rockchip: Remove the dumplicate
 rockchip_pwm_ops ops
Date: Wed, 2 Aug 2017 10:59:02 +0200
Message-ID: <20170802105902.2d137072@bbrezillon>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
        <1499486629-9659-4-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39462 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbdHBI7E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Aug 2017 04:59:04 -0400
In-Reply-To: <1499486629-9659-4-git-send-email-david.wu@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: thierry.reding@gmail.com, heiko@sntech.de, robh+dt@kernel.org, catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat,  8 Jul 2017 12:03:45 +0800
David Wu <david.wu@rock-chips.com> wrote:

> The rockchip_pwm_ops_v1 and rockchip_pwm_ops_v2 ops are the same
> struct members, remove one of them.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index cd45f17..85f9515 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -255,13 +255,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	return ret;
>  }
>  
> -static const struct pwm_ops rockchip_pwm_ops_v1 = {
> -	.get_state = rockchip_pwm_get_state,
> -	.apply = rockchip_pwm_apply,
> -	.owner = THIS_MODULE,
> -};
> -
> -static const struct pwm_ops rockchip_pwm_ops_v2 = {
> +static const struct pwm_ops rockchip_pwm_ops = {
>  	.get_state = rockchip_pwm_get_state,
>  	.apply = rockchip_pwm_apply,
>  	.owner = THIS_MODULE,
> @@ -275,7 +269,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		.ctrl = 0x0c,
>  	},
>  	.prescaler = 2,
> -	.ops = &rockchip_pwm_ops_v1,
> +	.ops = &rockchip_pwm_ops,
>  	.set_enable = rockchip_pwm_set_enable_v1,
>  	.get_state = rockchip_pwm_get_state_v1,
>  };
> @@ -289,7 +283,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	},
>  	.prescaler = 1,
>  	.supports_polarity = true,
> -	.ops = &rockchip_pwm_ops_v2,
> +	.ops = &rockchip_pwm_ops,
>  	.set_enable = rockchip_pwm_set_enable_v2,
>  	.get_state = rockchip_pwm_get_state_v2,
>  };
> @@ -303,7 +297,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	},
>  	.prescaler = 1,
>  	.supports_polarity = true,
> -	.ops = &rockchip_pwm_ops_v2,
> +	.ops = &rockchip_pwm_ops,
>  	.set_enable = rockchip_pwm_set_enable_v2,
>  	.get_state = rockchip_pwm_get_state_v2,
>  };

Actually, when I suggested to just implement ->apply_state() and be
done with all other fields I was thinking that you could get rid of
this rockchip_pwm_data struct entirely and just have 3 different
pwm_ops. You seem to take the other direction here: you're removing
rockchip_pwm_ops_v1 and renaming rockchip_pwm_ops_v2 into
rockchip_pwm_ops.
