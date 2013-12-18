From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv7 1/4] pwm: Add Freescale FTM PWM driver support
Date: Wed, 18 Dec 2013 03:34:45 +0000
Message-ID: <f63d1e4711ad4643972590c3ceb63fd4@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
 <1386925027-16288-2-git-send-email-Li.Xiubo@freescale.com>
 <20131217111020.GF13823@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131217111020.GF13823@ulmo.nvidia.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Huan Wang <Huan.Wang@freescale.com>, "rob@landley.net" <rob@landley.net>, "galak@codeaurora.org" <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "matt.porter@linaro.org" <matt.porter@linaro.org>, Jingchang Lu <jingchang>
List-Id: linux-pwm@vger.kernel.org

> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -5,6 +5,7 @@ obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
> >  obj-$(CONFIG_PWM_BFIN)		+= pwm-bfin.o
> >  obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
> >  obj-$(CONFIG_PWM_IMX)		+= pwm-imx.o
> > +obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
> 
> This needs to move up one line to preserve the alphabetical ordering.
> 

Yes, it had been. It caused by the rebase operation and after that I
haven't aware about this. I will revise this.


> > diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> [...]
> > +struct fsl_pwm_chip {
> [...]
> > +	int big_endian;
> 
> This should be of type bool.

I'll revise it.

> 
> > +};
> > +
> > +static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
> > +		const void __iomem *addr)
> > +{
> > +	u32 val;
> > +
> > +	val = __raw_readl(addr);
> > +
> > +	if (likely(fpc->big_endian))
> 
> The likely() probably isn't very useful in this case. But if you want to
> keep it, it should at least be reversed, since little-endian is actually
> the default (you have to specify the big-endian property to activate the
> big endian mode).
> 

So why added the likely() for bit endian mode is that this driver maybe used
for ARM and like PowerPC architectures, and in PowerPC platforms and LS-1 series
the big endian mode will be used almostly. Now only VF610-twr is the little
endian mode devices, and this is also why I added the big endian mode support.


> > +		val = be32_to_cpu(val);
> > +	else
> > +		val = le32_to_cpu(val);
> > +	rmb();
> 
> I'd prefer the rmb() to follow the __raw_readl() immediately to make the
> relationship more explicit.
> 

The fsl_pwm_readl() and fsl_pwm_writel() are almost copied the readl() and
writel().

For instance:
+ static inline u32 fsl_pwm_readl(struct fsl_pwm_chip *fpc,
+                 const void __iomem *addr)
+ {
+         u32 val;
+
+         val = __raw_readl(addr);
+ 
+         if (likely(fpc->big_endian))
+                 val = be32_to_cpu(val);
+         else
+                 val = le32_to_cpu(val);
+         rmb();
+
+         return val;
+ }
As we can see, this is one inline function, if locating the rmb() just follow
__raw_readl() immediately, I'm not very sure the compiler will do the following
reorders ?

In some function calls the fsl_pwm_readl(Address1) and little-endain mode is used:

The original code is:
tmp = fsl_pwm_readl(Address1)
<Do calculating about the tmp value returned from fsl_pwm_readl here>

Maybe reordered to :
tmp = raw_readl(addr);
rmb(); 
<Do calculating about the tmp value returned from fsl_pwm_readl here>
tmp = le32_to_cpu(tmp);
...

As we have known that in the fsl_pwm_readl(), the 'val' used by le32_to_cpu() has
a dependency on __raw_readl(), so the compiler will grantee the right orders, and
also the Arch will grantee the right orders too.

This is why I located the rmb() just before 'return val'.

> > +static inline int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
> > +		int index)
> 
> Please align arguments on subsequent lines with the first argument on the
> first line. There are a few more of those in this file, please check all
> other functions as well.
> 
> Also I think it's better to turn the FSL_PWM_CLK_* enum into a named enum
> and reuse the type here. That way you get proper type-checking.
> 
> > +	switch (index) {
> [...]
> > +	default:
> > +		return -EINVAL;
> 
> And with proper type checking you don't need this default case anymore.
>

I'll revise this.


 
> > +static unsigned long fsl_pwm_calculate_period_cycles(struct fsl_pwm_chip
> *fpc,
> > +		unsigned long period_ns, int index) {
> > +	int ret;
> > +	unsigned long cycles;
> > +
> > +	fpc->counter_clk_select = FTM_SC_CLK(index);
> > +
> > +	ret = fsl_pwm_calculate_default_ps(fpc, index);
> > +	if (ret) {
> > +		dev_err(fpc->chip.dev, "failed to calculate default ps.\n");
> 
> No need for the terminating fullstop (.) here, but perhaps you could write
> out what "ps" actually stands for. Also including the error code in the
> error message would be good since you're not propagating the error to the
> caller.
> 

Yes, I will.

> > +	cycles = fsl_pwm_calculate_cycles(fpc, period_ns);
> > +
> > +	return cycles;
> 
> This can simply be "return fsl_pwm_calculate_cycles(fpc, period_ns);", in
> which case you can get rid of the cycles variable.
> 

That's better.

> > +static unsigned long fsl_pwm_calculate_period(struct fsl_pwm_chip *fpc,
> > +		unsigned long period_ns)
> > +{
> [...]
> > +	if (fix_rate > ext_rate) {
> > +		m0 = FSL_PWM_CLK_FIX;
> > +		m1 = FSL_PWM_CLK_EXT;
> > +	} else {
> > +		m0 = FSL_PWM_CLK_EXT;
> > +		m1 = FSL_PWM_CLK_FIX;
> > +
> > +	}
> 
> There's a gratuitous blank line above this one.
> 
I'll remove it.

> > +		dev_err(fpc->chip.dev, "fail to config pwm%d, the period "
> > +				"time should be the same with the current "
> > +				"running pwm(s).\n", pwm->hwpwm);
> 
> I think I'd make this error message more terse and put more information
> into a comment. Perhaps something like this:
> 
> 	/*
> 	 * The FSL FTM controller supports only a single period for all PWM
> 	 * channels, therefore incompatible changes need to be refused.
> 	 */
> 	if (fpc->period_ns && fpc->period_ns != period_ns) {
> 		dev_err(fpc->chip.dev,
> 			"conflicting period requested for PWM %u\n",
> 			pwm->hwpwm);
> 		...
> 	}
> 
> > +		mutex_unlock(&fpc->lock);
> > +		return -EINVAL;
> 
> I think something like -EBUSY would be more appropriate here.
> 

Agree, I will use this.

> > +	if (!fpc->period_ns && duty_ns) {
> > +		period = fsl_pwm_calculate_period(fpc, period_ns);
> > +		if (!period) {
> > +			dev_err(fpc->chip.dev, "fail to calculate the "
> 
> "failed"
> 
> > +					"period cycles.\n");
> 
> And no fullstop either. Also I don't think you need "cycles" here. In fact
> something equally accurate like this:
> 
> 			dev_err(fpc->chip.dev, "failed to calculate period\n");
> 
> Still fits within 80 characters.
> 

Yes, I will.

> > +		fpc->period_ns = period_ns;
> > +	}
> > +	mutex_unlock(&fpc->lock);
> 
> This could use a blank line as well.
> 

I'll add it.

> > +static int fsl_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device
> *pwm,
> > +				enum pwm_polarity polarity)
> > +{
> > +	u32 val;
> > +	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
> > +
> > +	val = fsl_pwm_readl(fpc, fpc->base + FTM_POL);
> > +	if (polarity == PWM_POLARITY_INVERSED)
> 
> Blank line between the above.
>
I will.

 
> > +static int fsl_pwm_probe(struct platform_device *pdev) {
> > +	int ret;
> > +	struct fsl_pwm_chip *fpc;
> > +	struct resource *res;
> > +	struct device_node *np = pdev->dev.of_node;
> > +
> > +	fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
> > +	if (!fpc)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&fpc->lock);
> > +
> > +	fpc->chip.dev = &pdev->dev;
> > +
> > +	fpc->big_endian = of_property_read_bool(np, "big-endian");
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	fpc->base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(fpc->base))
> > +		return PTR_ERR(fpc->base);
> > +
> > +	fpc->sys_clk = devm_clk_get(fpc->chip.dev, "ftm_sys");
> 
> For consistency I'd use &pdev->dev here...
> 
> > +	if (IS_ERR(fpc->sys_clk)) {
> > +		dev_err(fpc->chip.dev,
> 
> ... and here.
> 

I will.

> > +	ret = pwmchip_add(&fpc->chip);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
> 
> Perhaps "failed to add PWM chip: %d\n", so that %d isn't confused to mean
> the PWM chip number?
> 
Yes, that's better.

> > +static int fsl_pwm_remove(struct platform_device *pdev) {
> > +	struct fsl_pwm_chip *fpc = platform_get_drvdata(pdev);
> > +
> > +	mutex_destroy(&fpc->lock);
> 
> I think you can drop this. Once fsl_pwm_remove() exists, the memory pointed
> to by fpc will be freed, so you won't be able to access the mutex anyway.
> 

Yes, actually it is.
Well I think this can make the code more robust and uniform.



Thanks,

--
Xiubo
