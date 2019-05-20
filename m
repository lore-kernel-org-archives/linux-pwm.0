From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [v4 4/5] drm/mediatek: control dpi pins dpi or gpio mode in on
 or off
Date: Mon, 20 May 2019 14:48:29 +0800
Message-ID: <1558334909.7311.27.camel@mtksdaap41>
References: <20190518095618.18454-1-jitao.shi@mediatek.com>
 <20190518095618.18454-5-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190518095618.18454-5-jitao.shi@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, stonea168@163.com, dri-devel@lists.freedesktop.org, yingjoe.chen@mediatek.com, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Inki Dae <inki.dae@samsung.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Phi
List-Id: linux-pwm@vger.kernel.org

Hi, Jitao:

On Sat, 2019-05-18 at 17:56 +0800, Jitao Shi wrote:
> Pull dpi pins low when dpi has nothing to display. Aovid leakage
> current from some dpi pins (Hsync Vsync DE ... ).
> 
> Some chips have dpi pins, but there are some chip don't have pins.
> So this function is controlled by chips driver data.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 35 +++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 77e6e0f99188..0c4ba0a2be27 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -17,10 +17,12 @@
>  #include <drm/drm_of.h>
>  #include <linux/kernel.h>
>  #include <linux/component.h>
> -#include <linux/platform_device.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>  #include <linux/of_graph.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/types.h>
>  #include <linux/clk.h>
> @@ -79,6 +81,9 @@ struct mtk_dpi {
>  	enum mtk_dpi_out_yc_map yc_map;
>  	enum mtk_dpi_out_bit_num bit_num;
>  	enum mtk_dpi_out_channel_swap channel_swap;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pins_default;
> +	struct pinctrl_state *pins_dpi;
>  	int refcount;
>  };
>  
> @@ -118,6 +123,7 @@ struct mtk_dpi_conf {
>  	u32 reg_h_fre_con;
>  	bool edge_sel_en;
>  	bool dual_edge;
> +	bool dpi_pin_ctrl;
>  };
>  
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> @@ -392,6 +398,9 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
>  	if (--dpi->refcount != 0)
>  		return;
>  
> +	if (dpi->conf->dpi_pin_ctrl)
> +		pinctrl_select_state(dpi->pinctrl, dpi->pins_default);
> +
>  	mtk_dpi_disable(dpi);
>  	clk_disable_unprepare(dpi->pixel_clk);
>  	clk_disable_unprepare(dpi->engine_clk);
> @@ -416,6 +425,9 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>  		goto err_pixel;
>  	}
>  
> +	if (dpi->conf->dpi_pin_ctrl)
> +		pinctrl_select_state(dpi->pinctrl, dpi->pins_dpi);
> +
>  	mtk_dpi_enable(dpi);
>  	return 0;
>  
> @@ -724,6 +736,27 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  	dpi->dev = dev;
>  	dpi->conf = (struct mtk_dpi_conf *)of_device_get_match_data(dev);
>  
> +	if (dpi->conf->dpi_pin_ctrl) {
> +		dpi->pinctrl = devm_pinctrl_get(&pdev->dev);

Please describe this in binding document.

Regards,
CK

> +		if (IS_ERR(dpi->pinctrl)) {
> +			dev_err(&pdev->dev, "Cannot find pinctrl!\n");
> +			return PTR_ERR(dpi->pinctrl);
> +		}
> +
> +		dpi->pins_default = pinctrl_lookup_state(dpi->pinctrl,
> +							 "default");
> +		if (IS_ERR(dpi->pins_default)) {
> +			dev_err(&pdev->dev, "Cannot find pinctrl default!\n");
> +			return PTR_ERR(dpi->pins_default);
> +		}
> +
> +		dpi->pins_dpi = pinctrl_lookup_state(dpi->pinctrl, "dpimode");
> +		if (IS_ERR(dpi->pins_dpi)) {
> +			dev_err(&pdev->dev, "Cannot find pinctrl dpimode!\n");
> +			return PTR_ERR(dpi->pins_dpi);
> +		}
> +	}
> +
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	dpi->regs = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(dpi->regs)) {
