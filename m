From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [v3 4/4] drm/panel: support for auo, kd101n80-45na wuxga dsi
 video mode panel
Date: Wed, 26 Jun 2019 09:26:28 +0200
Message-ID: <20190626072628.GC14541@ravnborg.org>
References: <20190626025400.109567-1-jitao.shi@mediatek.com>
 <20190626025400.109567-5-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190626025400.109567-5-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>, stonea168@163.com, dri-devel@lists.freedesktop.org, Andy Yan <andy.yan@rock-chips.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vge
List-Id: linux-pwm@vger.kernel.org

On Wed, Jun 26, 2019 at 10:54:00AM +0800, Jitao Shi wrote:
> Auo,kd101n80-45na's connector is same as boe,tv101wum-nl6.
> The most codes can be reuse.
> So auo,kd101n80-45na and boe,tv101wum-nl6 use one driver file.
> Add the different parts in driver data.

Very nice consolidation.
Have you considered another filename that better tell this is a driver
for different types of displays?

And the Kconfig text needs some adjustment to tell this driver now
supports an extra type of display.

	Sam
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 30d1f53dcbaf..6ff49f900cd2 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -372,6 +372,15 @@ static const struct panel_init_cmd boe_init_cmd[] = {
>  	{},
>  };
>  
> +static const struct panel_init_cmd auo_init_cmd[] = {
> +	_INIT_DELAY_CMD(24),
> +	_INIT_DCS_CMD(0x11),
> +	_INIT_DELAY_CMD(120),
> +	_INIT_DCS_CMD(0x29),
> +	_INIT_DELAY_CMD(120),
> +	{},
> +};
> +
>  static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)
>  {
>  	return container_of(panel, struct boe_panel, base);
> @@ -571,6 +580,33 @@ static const struct panel_desc boe_tv101wum_nl6_desc = {
>  	.init_cmds = boe_init_cmd,
>  };
>  
> +static const struct drm_display_mode auo_default_mode = {
> +	.clock = 157000,
> +	.hdisplay = 1200,
> +	.hsync_start = 1200 + 80,
> +	.hsync_end = 1200 + 80 + 24,
> +	.htotal = 1200 + 80 + 24 + 36,
> +	.vdisplay = 1920,
> +	.vsync_start = 1920 + 16,
> +	.vsync_end = 1920 + 16 + 4,
> +	.vtotal = 1920 + 16 + 4 + 16,
> +	.vrefresh = 60,
> +};
> +
> +static const struct panel_desc auo_kd101n80_45na_desc = {
> +	.modes = &auo_default_mode,
> +	.bpc = 8,
> +	.size = {
> +		.width = 135,
> +		.height = 216,
> +	},
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +		      MIPI_DSI_MODE_LPM,
> +	.init_cmds = auo_init_cmd,
> +};
> +
>  static int boe_panel_get_modes(struct drm_panel *panel)
>  {
>  	struct boe_panel *boe = to_boe_panel(panel);
> @@ -694,6 +730,9 @@ static const struct of_device_id boe_of_match[] = {
>  	{ .compatible = "boe,tv101wum-nl6",
>  	  .data = &boe_tv101wum_nl6_desc
>  	},
> +	{ .compatible = "auo,kd101n80-45na",
> +	  .data = &auo_kd101n80_45na_desc
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, boe_of_match);
> -- 
> 2.21.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
