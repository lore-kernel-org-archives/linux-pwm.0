From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [v3 2/4] drm/panel: support for BOE tv101wum-nl6 wuxga dsi video
 mode panel
Date: Wed, 26 Jun 2019 09:20:21 +0200
Message-ID: <20190626072021.GA14541@ravnborg.org>
References: <20190626025400.109567-1-jitao.shi@mediatek.com>
 <20190626025400.109567-3-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190626025400.109567-3-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>, stonea168@163.com, dri-devel@lists.freedesktop.org, Andy Yan <andy.yan@rock-chips.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vge
List-Id: linux-pwm@vger.kernel.org

Hi Jitao.

Driver looks good, one detail.

> +
> +struct panel_desc {
> +	const struct drm_display_mode *modes;
> +	unsigned int bpc;
> +
> +	/**
> +	 * @width: width (in millimeters) of the panel's active display area
> +	 * @height: height (in millimeters) of the panel's active display area
> +	 */
> +	struct {
> +		unsigned int width;
> +		unsigned int height;
> +	} size;
Maybe name these width_mm and height_mm.
Then they have the same name as where they are copied to,
and it is explicit documented that it is in mm.

The extra indirection with a struct is not needed in display_mode,
maybe drop it here too?
> +
> +	unsigned long mode_flags;
> +	enum mipi_dsi_pixel_format format;
> +	const struct panel_init_cmd *init_cmds;
> +	unsigned int lanes;
> +};
> +
...
> +static int boe_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct boe_panel *boe = to_boe_panel(panel);
> +	int ret;
> +
> +	if (!boe->prepared)
> +		return 0;
> +
> +	ret = boe_panel_off(boe);
> +	if (ret < 0) {
> +		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
> +		return ret;
> +	}
> +
> +	msleep(150);
> +	if (boe->enable_gpio)
> +		gpiod_set_value(boe->enable_gpio, 0);
Everywhere boe->enable_gpio is used it is checked like above.
Bot boe->enable_gpio in a mandatory property so it must be present.
The driver error out in probe if not present, so this check seems
redundandt?

Everything else looks really good.

With the above fixed / considered:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
