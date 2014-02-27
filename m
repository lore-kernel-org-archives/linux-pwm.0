From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pwm: add support for Intel Low Power Subsystem PWM
Date: Thu, 27 Feb 2014 15:13:37 +0200
Message-ID: <20140227131337.GN5018@intel.com>
References: <1390240808-18582-1-git-send-email-chiau.ee.chew@intel.com>
 <20140226143822.GG29779@ulmo.nvidia.com>
 <20140227090152.GH5018@intel.com>
 <604BF5F4C5D71041942BC7E84ED659EA0155B2E7@PGSMSX103.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64895 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbaB0NGE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 27 Feb 2014 08:06:04 -0500
Content-Disposition: inline
In-Reply-To: <604BF5F4C5D71041942BC7E84ED659EA0155B2E7@PGSMSX103.gar.corp.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "Chew, Chiau Ee" <chiau.ee.chew@intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chew, Kean Ho" <kean.ho.chew@intel.com>, "Chang, Rebecca Swee Fun" <rebecca.swee.fun.chang@intel.com>

On Thu, Feb 27, 2014 at 09:03:41AM +0000, Chew, Chiau Ee wrote:
> > > > +static int pwm_lpss_probe(struct platform_device *pdev) {
> > > > +	struct device *dev = &pdev->dev;
> > > > +	struct pwm_lpss_chip *lpwm;
> > > > +	int ret;
> > > > +
> > > > +	lpwm = dev_get_platdata(dev);
> > >
> > > struct pwm_lpss_chip is defined in this source file, how can anybody
> > > else know what to fill platform_data with?
> > 
> > Good point. Chiau Ee, do you recall why that thing is there in the first place?
> 
> This is added because we would eventually want to have PCI enumeration support
> added. I think we shall find a way to better enable both the ACPI enumeration and
> PCI enumeration support.

Agreed. For now, can you please drop the platform data thing from the
driver? Thanks.

> > > > +	if (!lpwm) {
> > > > +		lpwm = pwm_lpss_acpi_get_pdata(pdev);
> > > > +		if (!lpwm)
> > > > +			return -ENODEV;
> > > > +	}
> > > [...]
> > > > +static struct platform_driver pwm_lpss_driver = {
> > > > +	.driver = {
> > > > +		.name = "pwm-lpss",
> > > > +		.acpi_match_table = ACPI_PTR(pwm_lpss_acpi_match),
> > >
> > > ACPI_PTR not needed since the table will always be there.
> > 
> > OK.
> > 
> > >
> > > > +	},
> > > > +	.probe = pwm_lpss_probe,
> > > > +	.remove = pwm_lpss_remove,
> > > > +};
> > > > +module_platform_driver(pwm_lpss_driver);
> > > > +
> > > > +MODULE_DESCRIPTION("PWM driver for Intel LPSS");
> > > > +MODULE_AUTHOR("Mika Westerberg
> > <mika.westerberg@linux.intel.com>");
> > > > +MODULE_LICENSE("GPL");
> > >
> > > The file header says GPL v2, but "GPL" here means "GPL v2 or later".
> > 
> > OK, we will change that to GPLv2.
> > 
> > Thanks a lot for your review! We will do the changes and submit v2.
> 
> Ok. I will make the changes accordingly.

Thanks.
