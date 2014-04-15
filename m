From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pwm_lpss: Add support for PCI devices
Date: Tue, 15 Apr 2014 12:03:32 +0300
Message-ID: <20140415090332.GO19349@intel.com>
References: <1397311131-13371-1-git-send-email-chiau.ee.chew@intel.com>
 <20140414081805.GI19349@intel.com>
 <604BF5F4C5D71041942BC7E84ED659EA01570E28@PGSMSX103.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <604BF5F4C5D71041942BC7E84ED659EA01570E28@PGSMSX103.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chew, Chiau Ee" <chiau.ee.chew@intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Alan Cox <alan@linux.intel.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Apr 15, 2014 at 08:41:02AM +0000, Chew, Chiau Ee wrote:
> 
> 
> > > +static struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev,
> > > +			struct resource *r, struct pwm_lpss_boardinfo *info)
> > >  {
> > >  	struct pwm_lpss_chip *lpwm;
> > > -	struct resource *r;
> > >  	int ret;
> > >
> > > -	lpwm = devm_kzalloc(&pdev->dev, sizeof(*lpwm), GFP_KERNEL);
> > > +	lpwm = devm_kzalloc(dev, sizeof(*lpwm), GFP_KERNEL);
> > >  	if (!lpwm)
> > > -		return -ENOMEM;
> > > -
> > > -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +		return ERR_PTR(-ENOMEM);
> > >
> > > -	lpwm->regs = devm_ioremap_resource(&pdev->dev, r);
> > > +	lpwm->regs = devm_ioremap_resource(dev, r);
> > >  	if (IS_ERR(lpwm->regs))
> > > -		return PTR_ERR(lpwm->regs);
> > > -
> > > -	lpwm->clk = devm_clk_get(&pdev->dev, NULL);
> > > -	if (IS_ERR(lpwm->clk)) {
> > > -		dev_err(&pdev->dev, "failed to get PWM clock\n");
> > > -		return PTR_ERR(lpwm->clk);
> > > +		return lpwm->regs;
> > > +
> > > +	if (info) {
> > > +		lpwm->clk_rate = info->clk_rate;
> > > +	} else {
> > > +		lpwm->clk = devm_clk_get(dev, NULL);
> > > +		if (IS_ERR(lpwm->clk)) {
> > > +			dev_err(dev, "failed to get PWM clock\n");
> > > +			return (void *)lpwm->clk;
> > 
> > Why the cast here?
> 
> Alan, please do correct me if I describe wrongly on the purpose that you add the cast here.
> 
> As you can see, pwm_lpss_probe() is expected to return a pointer of type struct pwm_lpss_chip.  On the other hand,   
> the return of devm_clk_get() would be a pointer of type struct clk. So if were to use lpwm->clk as the return value of pwm_lpss_probe() , 
> a cast would be needed since the pointer type is different from the expected one. The compiler would complain on " warning: return from incompatible pointer type"
> if without the cast.

I think you can use ERR_CAST() here.
