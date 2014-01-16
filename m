From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCHv2 2/2] pwm: imx: support polarity inversion
Date: Thu, 16 Jan 2014 17:03:57 +0100
Message-ID: <20140116160356.GY16215@pengutronix.de>
References: <1389859585-14006-1-git-send-email-LW@KARO-electronics.de>
 <1389859585-14006-3-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1389859585-14006-3-git-send-email-LW@KARO-electronics.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Rob Landley <rob@landley.net>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Jan 16, 2014 at 09:06:25AM +0100, Lothar Wa=DFmann wrote:
> The i.MX PWM controller supports inverting the polarity of the PWM
> output. Make this feature available in the pxm-imx driver.
> =

> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt |    5 +-
>  drivers/pwm/pwm-imx.c                             |   42 +++++++++++++++=
++++++
>  2 files changed, 45 insertions(+), 2 deletions(-)
> =

> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Document=
ation/devicetree/bindings/pwm/imx-pwm.txt
> index b50d7a6d..d0b04b5 100644
> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> @@ -3,8 +3,9 @@ Freescale i.MX PWM controller
>  Required properties:
>  - compatible: should be "fsl,<soc>-pwm"
>  - reg: physical base address and length of the controller's registers
> -- #pwm-cells: should be 2. See pwm.txt in this directory for a descripti=
on of
> -  the cells format.
> +- #pwm-cells: may be 2 for backwards compatibility or 3 to support
> +  switching the output polarity. See pwm.txt in this directory for a
> +  description of the cells format.
>  - interrupts: The interrupt for the pwm controller
>  =

>  Example:
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 3b00a82..05461bb 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -36,6 +36,7 @@
>  #define MX3_PWMCR_DOZEEN		(1 << 24)
>  #define MX3_PWMCR_WAITEN		(1 << 23)
>  #define MX3_PWMCR_DBGEN			(1 << 22)
> +#define MX3_PWMCR_POUTC			(1 << 18)
>  #define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
>  #define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
>  #define MX3_PWMCR_EN			(1 << 0)
> @@ -138,6 +139,9 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
>  	if (test_bit(PWMF_ENABLED, &pwm->flags))
>  		cr |=3D MX3_PWMCR_EN;
>  =

> +	if (pwm->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		cr |=3D MX3_PWMCR_POUTC;
> +
>  	writel(cr, imx->mmio_base + MX3_PWMCR);
>  =

>  	return 0;
> @@ -155,6 +159,11 @@ static void imx_pwm_set_enable_v2(struct pwm_chip *c=
hip, bool enable)
>  	else
>  		val &=3D ~MX3_PWMCR_EN;
>  =

> +	if (chip->pwms[0].polarity =3D=3D PWM_POLARITY_INVERSED)
> +		val |=3D MX3_PWMCR_POUTC;
> +	else
> +		val &=3D ~MX3_PWMCR_POUTC;
> +
>  	writel(val, imx->mmio_base + MX3_PWMCR);
>  }
>  =

> @@ -198,6 +207,17 @@ static void imx_pwm_disable(struct pwm_chip *chip, s=
truct pwm_device *pwm)
>  	clk_disable_unprepare(imx->clk_per);
>  }
>  =

> +static int imx_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				enum pwm_polarity polarity)
> +{
> +	struct imx_chip *imx =3D to_imx_chip(chip);
> +
> +	dev_dbg(imx->chip.dev, "%s: polarity set to %s\n", __func__,
> +		polarity =3D=3D PWM_POLARITY_INVERSED ? "inverted" : "normal");
> +
> +	return 0;
> +}
> +
>  static struct pwm_ops imx_pwm_ops =3D {
>  	.enable =3D imx_pwm_enable,
>  	.disable =3D imx_pwm_disable,
> @@ -209,6 +229,7 @@ struct imx_pwm_data {
>  	int (*config)(struct pwm_chip *chip,
>  		struct pwm_device *pwm, int duty_ns, int period_ns);
>  	void (*set_enable)(struct pwm_chip *chip, bool enable);
> +	unsigned output_polarity:1;
>  };
>  =

>  static struct imx_pwm_data imx_pwm_data_v1 =3D {
> @@ -219,6 +240,7 @@ static struct imx_pwm_data imx_pwm_data_v1 =3D {
>  static struct imx_pwm_data imx_pwm_data_v2 =3D {
>  	.config =3D imx_pwm_config_v2,
>  	.set_enable =3D imx_pwm_set_enable_v2,
> +	.output_polarity =3D 1,
>  };
>  =

>  static const struct of_device_id imx_pwm_dt_ids[] =3D {
> @@ -271,6 +293,26 @@ static int imx_pwm_probe(struct platform_device *pde=
v)
>  		return PTR_ERR(imx->mmio_base);
>  =

>  	data =3D of_id->data;
> +	if (data->output_polarity) {
> +		const struct device_node *np =3D pdev->dev.of_node;
> +		u32 num_cells;
> +
> +		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
> +		ret =3D of_property_read_u32(np, "#pwm-cells", &num_cells);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "missing property '#pwm-cells'\n");
> +			return ret;
> +		}
> +		if (num_cells =3D=3D 3) {
> +			imx_pwm_ops.set_polarity =3D imx_pwm_set_polarity;
> +			imx->chip.of_xlate =3D of_pwm_xlate_with_flags;
> +		} else if (num_cells !=3D 2) {
> +			dev_err(&pdev->dev, "'#pwm-cells' must be <2> or <3>\n");
> +			return -EINVAL;
> +		}
> +		imx->chip.of_pwm_n_cells =3D num_cells;
> +	}

Can't this be done in the PWM core? Right now the PWM core checks for
of_pwm_n_cells before calling ->of_xlate. IMO this check should be done
in the of_xlate hook. Then of_pwm_simple_xlate and
of_pwm_xlate_with_flags can be merged into something like:

static struct pwm_device *
of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args
*args)
{
	struct pwm_device *pwm;
	int ret;

	if (pc->of_pwm_n_cells < 2)
		return ERR_PTR(-EINVAL);

	if (args->args[0] >=3D pc->npwm)
		return ERR_PTR(-EINVAL);

	pwm =3D pwm_request_from_chip(pc, args->args[0], NULL);
	if (IS_ERR(pwm))
		return pwm;

	if (pc->of_pwm_n_cells >=3D 3) {
		if (args->args[2] & PWM_POLARITY_INVERTED)
			ret =3D pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
		else
			ret =3D pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
		if (ret)
			return ret;
	}

	pwm_set_period(pwm, args->args[1]);

	return pwm;
}

Sascha

-- =

Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
