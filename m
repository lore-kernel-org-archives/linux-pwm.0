From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 2/6] pwm: mediatek: fix pwm source clock selection
Date: Wed, 5 Jul 2017 13:09:44 +0200
Message-ID: <d009712e-f0a2-2dc7-2f64-ad8cfa21f98d@gmail.com>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
 <1498802721-32455-3-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34409 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752058AbdGELJz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Jul 2017 07:09:55 -0400
In-Reply-To: <1498802721-32455-3-git-send-email-zhi.mao@mediatek.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Zhi Mao <zhi.mao@mediatek.com>, john@phrozen.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com



On 06/30/2017 08:05 AM, Zhi Mao wrote:
> In original code, the pwm output frequency is not correct
> when set bit<3>=1 to PWMCON register.
> 
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>   drivers/pwm/pwm-mediatek.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 5c11bc7..d08b5b3 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -91,7 +91,7 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (clkdiv > 7)
>   		return -EINVAL;
>   
> -	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | BIT(3) | clkdiv);
> +	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);

Just for clarification, BIT(15) enables old PWM mode, which ignores 
CLKSEL (BIT(3)). Therefore setting BIT(3) does not have any effect and 
can be discarded.

Am I correct? I took mt7623n datasheet for reference.

Regards,
Matthias

>   	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
>   	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
>   
> 
