From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [v2 5/5] drm/mediatek: add mt8183 dsi driver support
Date: Wed, 8 May 2019 11:00:34 +0800
Message-ID: <1557284434.31731.10.camel@mtksdaap41>
References: <20190416060501.76276-1-jitao.shi@mediatek.com>
         <20190416060501.76276-6-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416060501.76276-6-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <treding@nvidia.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Inki Dae <inki.dae@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sean Paul <seanpaul@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel
List-Id: linux-pwm@vger.kernel.org

Hi, Jitao:

On Tue, 2019-04-16 at 14:05 +0800, Jitao Shi wrote:
> Add mt8183 dsi driver data. Enable size control and
> reg commit control.
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 458a700ce74c..f0b36ec38e4f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1104,11 +1104,19 @@ static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
>  	.reg_cmdq_off = 0x180,
>  };
>  
> +static const struct mtk_dsi_driver_data mt8183_dsi_driver_data = {
> +	.reg_cmdq_off = 0x200,
> +	.has_shadow_ctl = true,
> +	.has_size_ctl = true,
> +};
> +
>  static const struct of_device_id mtk_dsi_of_match[] = {
>  	{ .compatible = "mediatek,mt2701-dsi",
>  	  .data = &mt2701_dsi_driver_data },
>  	{ .compatible = "mediatek,mt8173-dsi",
>  	  .data = &mt8173_dsi_driver_data },
> +	{ .compatible = "mediatek,mt8183-dsi",
> +	  .data = &mt8183_dsi_driver_data },
>  	{ },
>  };
>  
