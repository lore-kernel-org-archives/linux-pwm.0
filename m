From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH] pwm: stm32-lp: Remove pwm_is_enabled check before calling
 pwm_disable
Date: Tue, 7 Nov 2017 09:26:35 +0100
Message-ID: <65d06ff9-e421-17a1-42c3-70c34f55f3c5@st.com>
References: <20171107033041.10905-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34694 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933049AbdKGI0o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Nov 2017 03:26:44 -0500
In-Reply-To: <20171107033041.10905-1-axel.lin@ingics.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>

On 11/07/2017 04:30 AM, Axel Lin wrote:
> The same checking is done by the implementation of pwm_disable().
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index 9793b296108f..1ac9e4384142 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -219,8 +219,7 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
>  	unsigned int i;
>  
>  	for (i = 0; i < priv->chip.npwm; i++)
> -		if (pwm_is_enabled(&priv->chip.pwms[i]))
> -			pwm_disable(&priv->chip.pwms[i]);
> +		pwm_disable(&priv->chip.pwms[i]);
>  
>  	return pwmchip_remove(&priv->chip);
>  }
> 

Hi Axel,

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Fabrice
