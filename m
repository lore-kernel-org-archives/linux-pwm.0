From: John Crispin <john@phrozen.org>
Subject: Re: [PATCH RESEND 4/4] pwm: mediatek: add MT2712/MT7622 support
Date: Wed, 21 Jun 2017 14:22:31 +0200
Message-ID: <4600cf23-5e59-df02-37dc-056cb4a9744c@phrozen.org>
References: <1498032672-7172-1-git-send-email-zhi.mao@mediatek.com>
 <1498032672-7172-5-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:44438 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750823AbdFUMWf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 21 Jun 2017 08:22:35 -0400
In-Reply-To: <1498032672-7172-5-git-send-email-zhi.mao@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Zhi Mao <zhi.mao@mediatek.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: zhenbao.liu@mediatek.com, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, sean.wang@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, yt.shen@mediatek.com, yingjoe.chen@mediatek.com, linux-arm-kernel@lists.infradead.org



On 21/06/17 10:11, Zhi Mao wrote:
> support multiple chip(MT2712, MT7622, MT7623)
This patch does more than add extra SoC support. It also
* adds PWM_CLK_DIV_MAX which really should go into its own patch
* adds mtk_pwm_com_reg which should also go into its own patch

more comments inline

>
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>   drivers/pwm/pwm-mediatek.c |   63 +++++++++++++++++++++++++++++++++++---------
>   1 file changed, 51 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index c803ff6..d520356 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -16,6 +16,7 @@
>   #include <linux/module.h>
>   #include <linux/clk.h>
>   #include <linux/of.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/pwm.h>
>   #include <linux/slab.h>
[...]
> @@ -215,9 +238,25 @@ static int mtk_pwm_remove(struct platform_device *pdev)
>   	return pwmchip_remove(&pc->chip);
>   }
>   
> +/*==========================================*/

please remove these comment lines

     John
> +static const struct mtk_com_pwm_data mt2712_pwm_data = {
> +	.pwm_nums = 8,
> +};
> +
> +static const struct mtk_com_pwm_data mt7622_pwm_data = {
> +	.pwm_nums = 6,
> +};
> +
> +static const struct mtk_com_pwm_data mt7623_pwm_data = {
> +	.pwm_nums = 5,
> +};
> +/*==========================================*/
> +
>   static const struct of_device_id mtk_pwm_of_match[] = {
> -	{ .compatible = "mediatek,mt7623-pwm" },
> -	{ }
> +	{.compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data},
> +	{.compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data},
> +	{.compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data},
> +	{},
>   };
>   MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
>   
