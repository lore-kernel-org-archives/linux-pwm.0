From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [v4 3/7] drm/mediatek: add dsi reg commit disable control
Date: Mon, 3 Jun 2019 10:19:34 +0800
Message-ID: <1559528374.32185.4.camel@mtksdaap41>
References: <20190601092615.67917-1-jitao.shi@mediatek.com>
         <20190601092615.67917-4-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190601092615.67917-4-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <treding@nvidia.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Inki Dae <inki.dae@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sean Paul <seanpaul@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-media
List-Id: linux-pwm@vger.kernel.org

Hi, Jitao:

On Sat, 2019-06-01 at 17:26 +0800, Jitao Shi wrote:
> New DSI IP has shadow register and working reg. The register
> values are writen to shadow register. And then trigger with
> commit reg, the register values will be moved working register.
> 
> This fucntion is defualt on. But this driver doesn't use this
> function. So add the disable control.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index a48db056df6c..eea47294079e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -131,6 +131,10 @@
>  #define VM_CMD_EN			BIT(0)
>  #define TS_VFP_EN			BIT(5)
>  
> +#define DSI_SHADOW_DEBUG	0x190U
> +#define FORCE_COMMIT			BIT(0)
> +#define BYPASS_SHADOW			BIT(1)
> +
>  #define CONFIG				(0xff << 0)
>  #define SHORT_PACKET			0
>  #define LONG_PACKET			2
> @@ -157,6 +161,7 @@ struct phy;
>  
>  struct mtk_dsi_driver_data {
>  	const u32 reg_cmdq_off;
> +	bool has_shadow_ctl;
>  };
>  
>  struct mtk_dsi {
> @@ -594,6 +599,11 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>  	}
>  
>  	mtk_dsi_enable(dsi);
> +
> +	if (dsi->driver_data->has_shadow_ctl)
> +		writel(FORCE_COMMIT | BYPASS_SHADOW,
> +		       dsi->regs + DSI_SHADOW_DEBUG);
> +
>  	mtk_dsi_reset_engine(dsi);
>  	mtk_dsi_phy_timconfig(dsi);
>  
