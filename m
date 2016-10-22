From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 3/6] pwm: imx: support output polarity inversion
Date: Sat, 22 Oct 2016 12:33:37 +0200
Message-ID: <20161022123337.57eaa34f@bbrezillon>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
        <20161007151129.6043-4-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161007151129.6043-4-bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Cc: shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lothar Wassmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, 7 Oct 2016 20:41:26 +0530
Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org> wrote:

> From: Lothar Wassmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
> 
> The i.MX pwm unit on i.MX27 and newer SoCs provides a configurable output
> polarity. This patch adds support to utilize this feature where available.
> 
> Signed-off-by: Lothar Waßmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
> Signed-off-by: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Reviewed-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--
>  drivers/pwm/pwm-imx.c                             | 51 +++++++++++++++++++++--
>  2 files changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> index e00c2e9..c61bdf8 100644
> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> @@ -6,8 +6,8 @@ Required properties:
>    - "fsl,imx1-pwm" for PWM compatible with the one integrated on i.MX1
>    - "fsl,imx27-pwm" for PWM compatible with the one integrated on i.MX27
>  - reg: physical base address and length of the controller's registers
> -- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
> -  the cells format.
> +- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.txt
> +  in this directory for a description of the cells format.
>  - clocks : Clock specifiers for both ipg and per clocks.
>  - clock-names : Clock names should include both "ipg" and "per"
>  See the clock consumer binding,
> @@ -17,7 +17,7 @@ See the clock consumer binding,
>  Example:
>  
>  pwm1: pwm@53fb4000 {
> -	#pwm-cells = <2>;
> +	#pwm-cells = <3>;
>  	compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
>  	reg = <0x53fb4000 0x4000>;
>  	clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index d600fd5..c37d223 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -38,6 +38,7 @@
>  #define MX3_PWMCR_DOZEEN		(1 << 24)
>  #define MX3_PWMCR_WAITEN		(1 << 23)
>  #define MX3_PWMCR_DBGEN			(1 << 22)
> +#define MX3_PWMCR_POUTC			(1 << 18)
>  #define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
>  #define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
>  #define MX3_PWMCR_SWR			(1 << 3)
> @@ -180,6 +181,9 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>  	if (enable)
>  		cr |= MX3_PWMCR_EN;
>  
> +	if (pwm->args.polarity == PWM_POLARITY_INVERSED)
> +		cr |= MX3_PWMCR_POUTC;
> +
>  	writel(cr, imx->mmio_base + MX3_PWMCR);
>  
>  	return 0;
> @@ -240,27 +244,62 @@ static void imx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	clk_disable_unprepare(imx->clk_per);
>  }
>  
> -static struct pwm_ops imx_pwm_ops = {
> +static int imx_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
> +				enum pwm_polarity polarity)
> +{
> +	struct imx_chip *imx = to_imx_chip(chip);
> +	u32 val;
> +
> +	if (polarity == pwm->args.polarity)
> +		return 0;
> +
> +	val = readl(imx->mmio_base + MX3_PWMCR);
> +
> +	if (polarity == PWM_POLARITY_INVERSED)
> +		val |= MX3_PWMCR_POUTC;
> +	else
> +		val &= ~MX3_PWMCR_POUTC;
> +
> +	writel(val, imx->mmio_base + MX3_PWMCR);
> +
> +	dev_dbg(imx->chip.dev, "%s: polarity set to %s\n", __func__,
> +		polarity == PWM_POLARITY_INVERSED ? "inverted" : "normal");
> +
> +	return 0;
> +}

I'll read the discussion Lukasz and Stefan had before reviewing this
part ;-).

> +
> +static struct pwm_ops imx_pwm_ops_v1 = {
>  	.enable = imx_pwm_enable,
>  	.disable = imx_pwm_disable,
>  	.config = imx_pwm_config,
>  	.owner = THIS_MODULE,
>  };
>  
> +static struct pwm_ops imx_pwm_ops_v2 = {
> +	.enable = imx_pwm_enable,
> +	.disable = imx_pwm_disable,
> +	.set_polarity = imx_pwm_set_polarity,
> +	.config = imx_pwm_config,
> +	.owner = THIS_MODULE,
> +};
> +
>  struct imx_pwm_data {
>  	int (*config)(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns);
>  	void (*set_enable)(struct pwm_chip *chip, bool enable);
> +	struct pwm_ops *pwm_ops;

Probably better to make that consistent: drop the ->config() and
->set_enable() hooks, and make both v1 and v2 define their own pwm_ops.
If you have common logic that is shared between v1 and v2, you can just
create helper functions implementing this common logic and call them
from your version-specific implementation.

>  };
>  
>  static struct imx_pwm_data imx_pwm_data_v1 = {
>  	.config = imx_pwm_config_v1,
>  	.set_enable = imx_pwm_set_enable_v1,
> +	.pwm_ops = &imx_pwm_ops_v1,
>  };
>  
>  static struct imx_pwm_data imx_pwm_data_v2 = {
>  	.config = imx_pwm_config_v2,
>  	.set_enable = imx_pwm_set_enable_v2,
> +	.pwm_ops = &imx_pwm_ops_v2,
>  };
>  
>  static const struct of_device_id imx_pwm_dt_ids[] = {
> @@ -282,6 +321,8 @@ static int imx_pwm_probe(struct platform_device *pdev)
>  	if (!of_id)
>  		return -ENODEV;
>  
> +	data = of_id->data;
> +
>  	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
>  	if (imx == NULL)
>  		return -ENOMEM;
> @@ -300,18 +341,22 @@ static int imx_pwm_probe(struct platform_device *pdev)
>  		return PTR_ERR(imx->clk_ipg);
>  	}
>  
> -	imx->chip.ops = &imx_pwm_ops;
> +	imx->chip.ops = data->pwm_ops;
>  	imx->chip.dev = &pdev->dev;
>  	imx->chip.base = -1;
>  	imx->chip.npwm = 1;
>  	imx->chip.can_sleep = true;
> +	if (data->pwm_ops->set_polarity) {
> +		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
> +		imx->chip.of_xlate = of_pwm_xlate_with_flags;
> +		imx->chip.of_pwm_n_cells = 3;
> +	}

Not that I really care, but you are breaking the DT ABI here. One
solution to avoid that would be to retrieve #pwm-cells here and
decide which ->of_xlate should be used based on this information.

>  
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
>  	if (IS_ERR(imx->mmio_base))
>  		return PTR_ERR(imx->mmio_base);
>  
> -	data = of_id->data;
>  	imx->config = data->config;
>  	imx->set_enable = data->set_enable;
>  

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
