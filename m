Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F32521218
	for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2026 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167698; cv=none; b=IdkjEEpDfOADaWeX2qN1yOfiHqC1Ip3gLVm/njt4rVZZAAYUueuzzG1x8qMIJVwB1T71AQtH42T+sPrFHCTjSuqhSsjT+AlBZjPhGnRRKuqKWHDmp5IpvnciUpzG42rgobxZZIu0qLKRdXIzDYbRK/IstQ8xMiIDc9RS4f9Nlh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167698; c=relaxed/simple;
	bh=jPNtavFMI4q+FGbI7qJEzIBWSIDqEWdTuyso7m6gikQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMYluJRPKCYb5aKlRj3ryeXY0/vIgMtHnQfohknoP/a6m8keLuVlK/xEMr/BQiwsHui52s1lHMIUbbeLPOH8Bki7pAoBhfgJ+L9zh4uj8LhF/xstIFMU0w2BJNSWRaXVzy8L/jWvyDawkoneTb+hYR5oiNhMPFdf2JxuuE2h43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aP/REoU+; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aP/REoU+"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-482f6351831so585961f8f.1
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2026 05:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790167695; x=1790772495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ODeygWUoyfZFfVTkmoKD2nbDJdrzVQ9HvoPK8jlMnfI=;
        b=aP/REoU+pbqj1Po5qdX43wyIII9rzCDorXWUCTz76wM00v/+d4SF+b/0wGeQ0eCilK
         nrha7jo9IyTIKp3AF6E6B5WWr7N5fl/cv0YSO5gc7mYxKFy69fEQ4DDKgIxqMeIuPG9w
         c3OW9bRhoPy6Tf2YJxdJUtXQafgNCY7rNIcySc0Pg9jhjkSg+xi1r1cbJbUHGglASqy4
         8Og31XH4nEiLViQC4EUxaS9IblninMKhZ6bRdjtpiDmi8wfaBBY56N12cfmIQyvUqJJF
         hCzKOjCjaiLl3gRsv25koO+lgPSrxD2YvUE86I6EaR3W0iZ+JetEKx79xLTALou8mGCf
         1Xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790167695; x=1790772495;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ODeygWUoyfZFfVTkmoKD2nbDJdrzVQ9HvoPK8jlMnfI=;
        b=oER8xV8hhgqEo3XjBUZ2KIo/UDmrSWXnhpD2bk+kUTPGNui4ebwk1iqStHQVRDARWx
         yThECOdXizryF4XWwVrRwj7SIeJ1L2rVSlAKCEBDWpMTzZX0c9ay2Z9JgCxCh+5MT6s1
         Jn9YewiDVF/JRxCK33pplvvjXyYHTS6qjiNOTsgmMh+TD24j3rDy4cI9SjTSIlinYr3c
         sDhBIzA1RXDFje00VVaWyI49h6iXZU7vSMzV912Isgf2lW+cdW06qKZ6/nqnFQiurypp
         zuBl3ko7WnOYlUbr4ETeoe3h/3bJHRrVZeisb0wW+uoZRKgQMgYjEcyI7hIEPu/tMhs5
         IOKA==
X-Forwarded-Encrypted: i=1; AKwUvBxrXi2lO3MhdsQyQJHdSj1AAsawwBcsl6neY/MY0KYTXWwDzauI3dsvJ974UPgWPSqauXR0omphPe0=@vger.kernel.org
X-Gm-Message-State: AFuF++mrNssZfIDdJaO0k1uK5WEuglj/9xgx9i6iC83LSGMuyea23Htc
	i3j4G5GRVw1QWe6EJvtWM4qTRkxQc1ZlCK07BtcwcuEs2xQVv1NDVm5JCVLlxo2JMcA=
X-Gm-Gg: AYBFou0FcKPfKTEOqve6yVu3/5SaI1LW9taum6oaL34zKbcy0UfqRc05bPOR49KCZGn
	WuQlxlEaRHJOXO2l81wdiLjcrTXufyVvkdITGJ78VpeXtd5hh+Xw8avshRWPUmF3HqdOMFsuOfk
	n/JPjDB0SVt6g80qFLp+TWeLuNV2D63/J8GBFLDdEfHStLRSs8X/IGzx5PbkxjJ3GLMxGYZP3Ki
	IzPVQyPHkwiv7h36xVlJyb3IrH/I8uA0MBrtED9rt7R+bn/34kugDEFbJttU9xD8eE3iOnidc+b
	mex6k3fAnNCI53hp1r2xTQ6zihYm9NdzVCn4ZNIOhz0zzV1rspPMAh8pWWkRwtfMpfrWShmINzI
	xjt7RqEXh39laNODNBXyzv9eullz3Nlq8UsWr05Igkw6zIqqRG8nqHlIZ/WGfpo+jttVqiN99Vm
	WdohV1NvIMxldh++3MgnQ3FgjIGDs0T3+Ixh1t/kubHj73d9bKrutNbtwWaq/A41XKpx8g2w==
X-Received: by 2002:a05:6000:240d:b0:484:39b4:5bc9 with SMTP id ffacd0b85a97d-48867093ba7mr4171210f8f.26.1790167694853;
        Wed, 23 Sep 2026 05:48:14 -0700 (PDT)
Received: from localhost ([195.94.147.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c267sm6932595f8f.16.2026.09.23.05.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:48:14 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 23 Sep 2026 14:51:55 +0200
To: Gary Guo <gary@garyguo.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com,
	Sean Young <sean@mess.org>, Julian Braha <julianbraha@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <arPLa_g4mAg1t2rq@apocalypse>
References: <cover.1789724999.git.andrea.porta@suse.com>
 <22f454003902173a7230d0aee5fbd7261fcc163e.1789724999.git.andrea.porta@suse.com>
 <DLM3VDAEVVEO.1STV7HI3M3YXK@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLM3VDAEVVEO.1STV7HI3M3YXK@garyguo.net>

Hi Gary,
thanks for your feedback!

On 20:51 Tue 22 Sep     , Gary Guo wrote:
> On Fri Sep 18, 2026 at 10:59 AM BST, Andrea della Porta wrote:
> > From: Naushir Patuck <naush@raspberrypi.com>
> >
> > The Raspberry Pi RP1 southbridge features an embedded PWM
> > controller with 4 output channels, alongside an RPM interface
> > to read the fan speed on the Raspberry Pi 5.
> >
> > Add the supporting driver.
> >
> > Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> > Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
> > Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> 
> Put yourself a Co-developed-by perhaps? You made significant changes.

Ack.

> 
> I've tested the device on my Pi 5, and the fan is indeed spinning now :)

Nice! Thanks for testing it :)

> 
> > ---
> >  drivers/pwm/Kconfig                       |   8 +
> >  drivers/pwm/Makefile                      |   1 +
> >  drivers/pwm/pwm-rp1.c                     | 499 ++++++++++++++++++++++
> >  include/soc/bcm2835/raspberrypi-pwm-rp1.h |  10 +
> >  4 files changed, 518 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-rp1.c
> >  create mode 100644 include/soc/bcm2835/raspberrypi-pwm-rp1.h
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 7297760868790..e1baec8d294d1 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -637,6 +637,14 @@ config PWM_ROCKCHIP
> >  	  Generic PWM framework driver for the PWM controller found on
> >  	  Rockchip SoCs.
> >  
> > +config PWM_RASPBERRYPI_RP1
> > +	tristate "RP1 PWM support"
> > +	depends on MISC_RP1 || COMPILE_TEST
> > +	depends on HAS_IOMEM
> > +	select REGMAP_MMIO
> > +	help
> > +	  PWM framework driver for Raspberry Pi RP1 controller.
> > +
> >  config PWM_SAMSUNG
> >  	tristate "Samsung PWM support"
> >  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 5630a521a7cff..c07fd24f69f39 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -57,6 +57,7 @@ obj-$(CONFIG_PWM_RENESAS_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
> >  obj-$(CONFIG_PWM_RENESAS_RZ_MTU3)	+= pwm-rz-mtu3.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
> > +obj-$(CONFIG_PWM_RASPBERRYPI_RP1)	+= pwm-rp1.o
> >  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
> >  obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
> >  obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
> > diff --git a/drivers/pwm/pwm-rp1.c b/drivers/pwm/pwm-rp1.c
> > new file mode 100644
> > index 0000000000000..cfd38e46cc589
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-rp1.c
> > +
> > +int rp1_pwm_read_tachometer(struct device *dev)
> > +{
> > +	struct pwm_chip *chip;
> > +	struct rp1_pwm *rp1;
> > +	u32 tach_val;
> > +	int ret;
> > +
> > +	if (!dev)
> > +		return -EINVAL;
> > +
> > +	device_lock(dev);
> 
> You should use the device link mechanism for synchronizing unbind / runtime PM.
> That can be done in your RP1 fan driver, and it doesn't need locking on this
> driver.

This does not enforce the locking though. Is it enough to just rely on
caller to create the device link in advance? IOW, just add a documentation
comment to the exported function prologue stating that the consumer is
responsible to sync via a device link is acceptable?
Otherwise the only way I see to protect it in any scenario is via the mutex
I've already implemented and a second flag for the removing path (device_lock
will be dropped, of course).

> 
> So Sashiko is kinda reporting a false positive here.
> 
> > +
> > +	chip = dev_get_drvdata(dev);
> > +	if (!chip) {
> > +		ret = -ENODEV;
> > +		goto err_dev_unlock;
> > +	}
> > +
> > +	rp1 = pwmchip_get_drvdata(chip);
> > +	if (!rp1) {
> > +		ret = -ENODEV;
> > +		goto err_dev_unlock;
> > +	}
> > +
> > +	mutex_lock(&rp1->lock);
> > +	if (!rp1->clk_enabled) {
> > +		ret = -EBUSY;
> > +		goto err_clk_unlock;
> > +	}
> > +
> > +	ret = regmap_read(rp1->regmap, RP1_PWM_PHASE(2), &tach_val);
> > +	if (ret)
> > +		goto err_clk_unlock;
> > +
> > +	ret = (int)tach_val;
> > +
> > +err_clk_unlock:
> > +	mutex_unlock(&rp1->lock);
> > +err_dev_unlock:
> > +	device_unlock(dev);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(rp1_pwm_read_tachometer, "RP1_PWM_FAN");
> > +
> > +static int rp1_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	unsigned long clk_rate;
> > +	struct pwm_chip *chip;
> > +	void __iomem	*base;
> > +	struct rp1_pwm *rp1;
> > +	int ret;
> > +
> > +	chip = devm_pwmchip_alloc(dev, RP1_PWM_NUM_PWMS, sizeof(*rp1));
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> > +
> > +	rp1 = pwmchip_get_drvdata(chip);
> > +	ret = devm_mutex_init(dev, &rp1->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	rp1->regmap = devm_regmap_init_mmio(dev, base, &rp1_pwm_regmap_config);
> > +	if (IS_ERR(rp1->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(rp1->regmap), "Cannot initialize regmap\n");
> 
> You mentioned "rework regmap error paths" in cover letter.
> 
> But the issue is that regmap doesn't need be used here at all. RP1 is on PCIe
> so there is no need for bus abstraction, direct use of MMIO is sufficient.
> MMIO accessors have no error paths, so you're saying yourself from having to
> handle that, and also reduce the overhead by not having to go through an
> abstraction w/ indirect funicton calls.
>
> I suppose regmap was used when syscon was there; but it's not needed anymore.

True, and I don't have any issue in converting back to MMIO call and drop the conditional for
error checking, but please consider the following, since the driver may be extended in the
future to support more features:

- regmap gives you free debugfs view on the registers, which may be useful to test
  the new features.
- regmap_write/read may still return an error in case the passed register is not in range.
  This will be trapped at runtime only, but could still be useful during development
- I expect the PWM driver to be a access with very low frequency, so I guess the overhead 
  imposed by regmap is negligible.

Since we already have it, I'd prefer to leave regmap if possible for the aforementioned reasons,
but I'm obviously open to drop it in favor of direct MMIO calls in case you or anyone else are
not seeing those as real benefits.

Many thanks,
Andrea

> 
> Best,
> Gary
> 
> > +
> > +	rp1->clk = devm_clk_get(dev, NULL);
> > +	if (IS_ERR(rp1->clk))
> > +		return dev_err_probe(dev, PTR_ERR(rp1->clk), "Clock not found\n");
> > +
> 
