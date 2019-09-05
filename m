From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [PATCH v6 0/7] Support dsi for mt8183
Date: Thu, 5 Sep 2019 10:41:39 +0800
Message-ID: <1567651299.13330.4.camel@mtksdaap41>
References: <20190811104008.53372-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190811104008.53372-1-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <treding@nvidia.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Inki Dae <inki.dae@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sean Paul <seanpaul@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-media
List-Id: linux-pwm@vger.kernel.org

Hi, Jitao:

For this series, applied to mediatek-drm-next-5.5 [1], and I break
"[v6,2/7] drm/mediatek: fixes CMDQ reg address of mt8173 is different
with mt2701" into two patches, thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-next-5.5

Regards,
CK


On Sun, 2019-08-11 at 18:40 +0800, Jitao Shi wrote:
> Change since v5:
>  - fine tune dphy timing.
> 
> Change since v4:
>  - move mipi_dsi_host_unregiter() to .remove()
>  - fine tune add frame size control coding style
>  - change the data type of data_rate as u32, and add DIV_ROUND_UP_ULL
>  - use div_u64 when 8000000000ULL / dsi->data_rate.
> 
> Changes since v3
>  - add one more 'tab' for bitwise define.
>  - add Tested-by: Ryan Case <ryandcase@chromium.org>
> 	and Reviewed-by: CK Hu <ck.hu@mediatek.com>.
>  - remove compare da_hs_zero to da_hs_prepare.
> 
> Changes since v2:
>  - change the video timing calc method
>  - fine the dsi and mipitx init sequence
>  - fine tune commit msg
> 
> Changes since v1:
>  - separate frame size and reg commit control independent patches.
>  - fix some return values in probe
>  - remove DSI_CMDW0 in "CMDQ reg address of mt8173 is different with mt2701" 
> 
> Jitao Shi (7):
>   drm/mediatek: move mipi_dsi_host_register to probe
>   drm/mediatek: fixes CMDQ reg address of mt8173 is different with
>     mt2701
>   drm/mediatek: add dsi reg commit disable control
>   drm/mediatek: add frame size control
>   drm/mediatek: add mt8183 dsi driver support
>   drm/mediatek: change the dsi phytiming calculate method
>   drm: mediatek: adjust dsi and mipi_tx probe sequence
> 
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c |   2 +-
>  drivers/gpu/drm/mediatek/mtk_dsi.c     | 224 ++++++++++++++++++-------
>  2 files changed, 161 insertions(+), 65 deletions(-)
> 
