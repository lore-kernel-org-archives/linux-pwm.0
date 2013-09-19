Return-Path: <mikedunn@newsguy.com>
Message-ID: <523B2C0B.4050204@newsguy.com>
Date: Thu, 19 Sep 2013 09:53:31 -0700
From: Mike Dunn <mikedunn@newsguy.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4] PWM: PXA: add device tree support to PWM driver
References: <1379519982-7618-1-git-send-email-mikedunn@newsguy.com> <20130919122807.GH10852@ulmo>
In-Reply-To: <20130919122807.GH10852@ulmo>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>

On 09/19/2013 05:28 AM, Thierry Reding wrote:
> On Wed, Sep 18, 2013 at 08:59:42AM -0700, Mike Dunn wrote:
> [...]
>> Only an OF match table is added;
> [...]
> 
> That's no longer true. You also add a custom .of_xlate() function.


Is it acceptable to re-word the commit message in susbequent versions?


> 
>> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> [...]
>> +Required properties:
>> +- compatible: should be one or more of:
>> +  - "marvell,pxa250-pwm"
>> +  - "marvell,pxa270-pwm"
>> +  - "marvell,pxa168-pwm"
>> +  - "marvell,pxa910-pwm"
>> +- reg: physical base address and length of the registers used by the PWM channel
>> +  NB: One device instance must be created for each PWM that is used, so the
> 
> Nit: "NB:" looks like it starts a new property. Perhaps something like:
> 
> 	"Note that one device node must be present for each PWM ..."
> 
> would be less confusing to the eye.


Yes, good point.  I like clarity myself.


> 
>> +  length covers only the register window for one PWM output, not that of the
>> +  entire PWM controller.  Currently length is 0x10 for all supported devices.
> 
> So that again confuses me. If the controller really is one or two PWM
> channels, and four PWM channels, as given in the pxa27x.dtsi, are in
> fact two controllers (not four) then I wonder if this really is the
> correct binding for it.
> 
> That said, Stephen seems to be okay with it, and I'll yield to his
> authority on the matter.
> 
>> +- #pwm-cells: should be 1.  This cell is used to specify the period in
> 
> Nit: "Should be 1." It's a sentence and therefore should start with a
> capital letter.


OK


> 
>> +  nanoseconds.  (Because one device instance is created for each PWM output,
>> +  the per-chip index is superflous and not used.)
> 
> I'd omit the parentheses (and their content). The description of the
> cell is plenty specific about what it should contain. No need to list
> what it shouldn't contain.


OK.


> 
>> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
> 
> I think this belongs in a separate patch so it can go through the
> arm-soc tree.


Is there anyone else or another list that should be CC'd in this case?  Thanks.


> 
>> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
> [...]
>> +#ifdef CONFIG_OF
>> +/*
>> + * Device tree users must create one device instance for each pwm channel.
>> + * Hence we dispense with the HAS_SECONDARY_PWM and "tell" the original driver
>> + * code that this is a single channel pxa25x-pwm.  Currently all devices are
>> + * supported identically.
>> + */
>> +static struct of_device_id pwm_of_match[] = {
>> +	{ .compatible = "marvell,pxa250-pwm", .data = &pwm_id_table[0]},
>> +	{ .compatible = "marvell,pxa270-pwm", .data = &pwm_id_table[0]},
>> +	{ .compatible = "marvell,pxa168-pwm", .data = &pwm_id_table[0]},
>> +	{ .compatible = "marvell,pxa910-pwm", .data = &pwm_id_table[0]},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, pwm_of_match);
>> +
>> +static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
>> +{
>> +	const struct of_device_id *id = of_match_device(pwm_of_match, dev);
>> +	if (id)
>> +		return (const struct platform_device_id *)id->data;
> 
> Is that cast really necessary? id->data is const void *, so shouldn't
> need a cast.


You're right.


> 
>> +	else
>> +		return NULL;
> 
> Perhaps "return id ? id->data : NULL;"?


OK


> 
>> +struct pwm_device *
>> +pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
> 
> Should be static.


Oops, yes.


> 
>> +{
>> +	struct pwm_device *pwm;
>> +
> 
> You probably want to check that pc->of_pwm_n_cells at least 1 here.


Well OK, but I didn't bother because it's explicitly set to one elsewhere in
this source file.


> 
>> +	pwm = pwm_request_from_chip(pc, 0, NULL);
>> +	if (IS_ERR(pwm))
>> +		return pwm;
>> +
>> +	pwm_set_period(pwm, args->args[0]);
>> +
>> +	return pwm;
>> +}
>> +
>> +#else  /* !CONFIG_OF */
>> +static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
>> +{
>> +	dev_err(dev, "missing platform data\n");
>> +	return NULL;
>> +}
>> +
>> +struct pwm_device *
>> +pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
>> +{
>> +	return NULL;
>> +}
>> +#endif
> 
> I prefer not to have these dummy implementations for static functions.
> See below...
> 
>>  static int pwm_probe(struct platform_device *pdev)
>>  {
>>  	const struct platform_device_id *id = platform_get_device_id(pdev);
>> @@ -131,6 +185,11 @@ static int pwm_probe(struct platform_device *pdev)
>>  	struct resource *r;
>>  	int ret = 0;
>>  
>> +	if (id == NULL)		/* using device tree */
>> +		id = pxa_pwm_get_id_dt(&pdev->dev);
> 
> This could be replaced with:
> 
> 	if (IS_ENABLED(CONFIG_OF) && id == NULL)
> 		id = pxa_pwm_get_id_dt(&pdev->dev);
> 
> And pxa_pwm_get_id_dt() can be unconditionally defined. The compiler
> will automatically remove it for !OF because it is never used. Also the
> comment can then be dropped since the code is already explicit.
> 
>>  	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
>>  	if (pwm == NULL) {
>>  		dev_err(&pdev->dev, "failed to allocate memory\n");
>> @@ -145,6 +204,8 @@ static int pwm_probe(struct platform_device *pdev)
>>  	pwm->chip.ops = &pxa_pwm_ops;
>>  	pwm->chip.base = -1;
>>  	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
>> +	pwm->chip.of_xlate = pxa_pwm_of_xlate;
>> +	pwm->chip.of_pwm_n_cells = 1;
> 
> Similarly if you write this as:
> 
> 	if (IS_ENABLED(CONFIG_OF)) {
> 		pwm->chip.of_xlate = pxa_pwm_of_xlate;
> 		pwm->chip.of_pwm_n_cells = 1;
> 	}
> 
> Then the only thing that needs #ifdef CONFIG_OF protection will be the
> OF match table.


Yes, much better.  Thanks again Thierry.

Mike
