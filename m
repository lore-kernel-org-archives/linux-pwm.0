From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] pwm: pwm-mediatek: Add MT8516 SoC support
Date: Thu, 22 Aug 2019 10:52:11 +0200
Message-ID: <d9b1f0a3-bd10-9fe8-af9f-17dafd7a509c@gmail.com>
References: <20190805125848.15751-1-fparent@baylibre.com>
 <20190805125848.15751-2-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805125848.15751-2-fparent@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>, thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org



On 05/08/2019 14:58, Fabien Parent wrote:
> Add the compatible and the platform data to support PWM on the MT8516
> SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/pwm/pwm-mediatek.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index eb6674ce995f..6697e30811e7 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -302,11 +302,18 @@ static const struct mtk_pwm_platform_data mt7628_pwm_data = {
>  	.has_clks = false,
>  };
>  
> +static const struct mtk_pwm_platform_data mt8516_pwm_data = {
> +	.num_pwms = 5,
> +	.pwm45_fixup = false,
> +	.has_clks = true,
> +};
> +
>  static const struct of_device_id mtk_pwm_of_match[] = {
>  	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
>  	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
>  	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
>  	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
> +	{ .compatible = "mediatek,mt8516-pwm", .data = &mt8516_pwm_data },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
> 
