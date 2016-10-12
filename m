From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v3 3/6] pwm: imx: support output polarity inversion
Date: Wed, 12 Oct 2016 16:18:20 -0700
Message-ID: <ff9ba34df2729204c617685dd26ea625@agner.ch>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
 <20161007151129.6043-4-bhuvanchandra.dv@toradex.com>
 <5325a332099473a2d8382530f79c5a8e@agner.ch> <20161013001540.7f759158@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:56797 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933214AbcJLXYJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Oct 2016 19:24:09 -0400
In-Reply-To: <20161013001540.7f759158@jawa>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, shawnguo@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, kernel@pengutronix.de, fabio.estevam@nxp.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lothar Wassmann <LW@karo-electronics.de>, boris.brezillon@free-electrons.com

On 2016-10-12 15:15, Lukasz Majewski wrote:
> Hi Stefan,
> 
>> On 2016-10-07 08:11, Bhuvanchandra DV wrote:
>> > From: Lothar Wassmann <LW@KARO-electronics.de>
>> >
>> > The i.MX pwm unit on i.MX27 and newer SoCs provides a configurable
>> > output polarity. This patch adds support to utilize this feature
>> > where available.
>> >
>> > Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
>> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>> > Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
>> > Acked-by: Shawn Guo <shawn.guo@linaro.org>
>> > Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
>> > ---
>> >  Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--
>> >  drivers/pwm/pwm-imx.c                             | 51
>> > +++++++++++++++++++++-- 2 files changed, 51 insertions(+), 6
>> > deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>> > b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>> > index e00c2e9..c61bdf8 100644
>> > --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>> > +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>> > @@ -6,8 +6,8 @@ Required properties:
>> >    - "fsl,imx1-pwm" for PWM compatible with the one integrated on
>> > i.MX1
>> >    - "fsl,imx27-pwm" for PWM compatible with the one integrated on
>> > i.MX27
>> >  - reg: physical base address and length of the controller's
>> > registers -- #pwm-cells: should be 2. See pwm.txt in this directory
>> > for a description of
>> > -  the cells format.
>> > +- #pwm-cells: 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See
>> > pwm.txt
>> > +  in this directory for a description of the cells format.
>> >  - clocks : Clock specifiers for both ipg and per clocks.
>> >  - clock-names : Clock names should include both "ipg" and "per"
>> >  See the clock consumer binding,
>> > @@ -17,7 +17,7 @@ See the clock consumer binding,
>> >  Example:
>> >
>> >  pwm1: pwm@53fb4000 {
>> > -	#pwm-cells = <2>;
>> > +	#pwm-cells = <3>;
>> >  	compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
>> >  	reg = <0x53fb4000 0x4000>;
>> >  	clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
>> > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
>> > index d600fd5..c37d223 100644
>> > --- a/drivers/pwm/pwm-imx.c
>> > +++ b/drivers/pwm/pwm-imx.c
>> > @@ -38,6 +38,7 @@
>> >  #define MX3_PWMCR_DOZEEN		(1 << 24)
>> >  #define MX3_PWMCR_WAITEN		(1 << 23)
>> >  #define MX3_PWMCR_DBGEN			(1 << 22)
>> > +#define MX3_PWMCR_POUTC			(1 << 18)
>> >  #define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
>> >  #define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
>> >  #define MX3_PWMCR_SWR			(1 << 3)
>> > @@ -180,6 +181,9 @@ static int imx_pwm_config_v2(struct pwm_chip
>> > *chip, if (enable)
>> >  		cr |= MX3_PWMCR_EN;
>> >
>> > +	if (pwm->args.polarity == PWM_POLARITY_INVERSED)
>> > +		cr |= MX3_PWMCR_POUTC;
>> > +
>>
>> This seems wrong to me, the config callback is meant for period/duty
>> cycle only.
> 
> If it is meant only for that, then the polarity should be removed from
> it.
> 
> However after very quick testing, at least on my setup, it turns out
> that removing this lines causes polarity to _not_ being set (and the
> polarity is not inverted).
> 
> I will investigate this further on my setup and hopefully sent proper
> patch.
> 
>> The set_polarity callback should get called in case a
>> different polarity is requested.
> 
> On my setup the pwm2 is set from DT and pwm_backlight_probe() calls
> pwm_apply_args(), so everything should work. However, as I mentioned
> above there still is some problem with inversion setting.
> 
>>
>>
>> >  	writel(cr, imx->mmio_base + MX3_PWMCR);
>> >
>> >  	return 0;
>> > @@ -240,27 +244,62 @@ static void imx_pwm_disable(struct pwm_chip
>> > *chip, struct pwm_device *pwm)
>> >  	clk_disable_unprepare(imx->clk_per);
>> >  }
>> >
>> > -static struct pwm_ops imx_pwm_ops = {
>> > +static int imx_pwm_set_polarity(struct pwm_chip *chip, struct
>> > pwm_device *pwm,
>> > +				enum pwm_polarity polarity)
>> > +{
>> > +	struct imx_chip *imx = to_imx_chip(chip);
>> > +	u32 val;
>> > +
>> > +	if (polarity == pwm->args.polarity)
>> > +		return 0;
>>
>> I don't think that this is right. Today, pwm_apply_args (in
>> include/linux/pwm.h) copies the polarity from args to state.polarity,
>> which is then passed as polarity argument to this function. So this
>> will always return 0 afaict.
> 
> Yes, I've overlooked it (that the state is copied).
> 
> It can be dropped.

Did you do the above test with that line dropped?

> 
>>
>> I would just drop that.
>>
>> There is probably one little problem in the current state of affairs:
>> If the bootloader makes use of a PWM channel with inverted state,
>> then the kernel would not know about that and currently assume a
>> wrong initial state... I guess at one point in time we should
>> implement the state retrieval callback and move to the new atomic PWM
>> API, which would mean to implement apply callback.
> 
> Are there any patches on the horizon?
> 

Not that I know of...

--
Stefan

>>
>> --
>> Stefan
>>
>>
>> > +
>> > +	val = readl(imx->mmio_base + MX3_PWMCR);
>> > +
>> > +	if (polarity == PWM_POLARITY_INVERSED)
>> > +		val |= MX3_PWMCR_POUTC;
>> > +	else
>> > +		val &= ~MX3_PWMCR_POUTC;
>> > +
>> > +	writel(val, imx->mmio_base + MX3_PWMCR);
>> > +
>> > +	dev_dbg(imx->chip.dev, "%s: polarity set to %s\n",
>> > __func__,
>> > +		polarity == PWM_POLARITY_INVERSED ? "inverted" :
>> > "normal"); +
>> > +	return 0;
>> > +}
>> > +
>> > +static struct pwm_ops imx_pwm_ops_v1 = {
>> >  	.enable = imx_pwm_enable,
>> >  	.disable = imx_pwm_disable,
>> >  	.config = imx_pwm_config,
>> >  	.owner = THIS_MODULE,
>> >  };
>> >
>> > +static struct pwm_ops imx_pwm_ops_v2 = {
>> > +	.enable = imx_pwm_enable,
>> > +	.disable = imx_pwm_disable,
>> > +	.set_polarity = imx_pwm_set_polarity,
>> > +	.config = imx_pwm_config,
>> > +	.owner = THIS_MODULE,
>> > +};
>> > +
>> >  struct imx_pwm_data {
>> >  	int (*config)(struct pwm_chip *chip,
>> >  		struct pwm_device *pwm, int duty_ns, int
>> > period_ns); void (*set_enable)(struct pwm_chip *chip, bool enable);
>> > +	struct pwm_ops *pwm_ops;
>> >  };
>> >
>> >  static struct imx_pwm_data imx_pwm_data_v1 = {
>> >  	.config = imx_pwm_config_v1,
>> >  	.set_enable = imx_pwm_set_enable_v1,
>> > +	.pwm_ops = &imx_pwm_ops_v1,
>> >  };
>> >
>> >  static struct imx_pwm_data imx_pwm_data_v2 = {
>> >  	.config = imx_pwm_config_v2,
>> >  	.set_enable = imx_pwm_set_enable_v2,
>> > +	.pwm_ops = &imx_pwm_ops_v2,
>> >  };
>> >
>> >  static const struct of_device_id imx_pwm_dt_ids[] = {
>> > @@ -282,6 +321,8 @@ static int imx_pwm_probe(struct platform_device
>> > *pdev) if (!of_id)
>> >  		return -ENODEV;
>> >
>> > +	data = of_id->data;
>> > +
>> >  	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
>> >  	if (imx == NULL)
>> >  		return -ENOMEM;
>> > @@ -300,18 +341,22 @@ static int imx_pwm_probe(struct
>> > platform_device *pdev) return PTR_ERR(imx->clk_ipg);
>> >  	}
>> >
>> > -	imx->chip.ops = &imx_pwm_ops;
>> > +	imx->chip.ops = data->pwm_ops;
>> >  	imx->chip.dev = &pdev->dev;
>> >  	imx->chip.base = -1;
>> >  	imx->chip.npwm = 1;
>> >  	imx->chip.can_sleep = true;
>> > +	if (data->pwm_ops->set_polarity) {
>> > +		dev_dbg(&pdev->dev, "PWM supports output
>> > inversion\n");
>> > +		imx->chip.of_xlate = of_pwm_xlate_with_flags;
>> > +		imx->chip.of_pwm_n_cells = 3;
>> > +	}
>> >
>> >  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> >  	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
>> >  	if (IS_ERR(imx->mmio_base))
>> >  		return PTR_ERR(imx->mmio_base);
>> >
>> > -	data = of_id->data;
>> >  	imx->config = data->config;
>> >  	imx->set_enable = data->set_enable;
>>
> 
> Best regards,
> 
> Łukasz Majewski
