From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Date: Wed, 10 Jun 2020 19:30:53 +0100
Message-ID: <20200610183053.GV4106@dell>
References: <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609151941.GM4106@dell>
 <95e6ec9bbdf6af7a9ff9c31786f743f2@walle.cc>
 <20200609194505.GQ4106@dell>
 <3a6931248f0efcaf8efbb5425a9bd833@walle.cc>
 <20200610071940.GS4106@dell>
 <f7b2b690750edd022000ab56d2f58154@walle.cc>
 <20200610075615.GT4106@dell>
 <b06a79c845e0ab251235d30f7dc94dd5@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgFJSa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Jun 2020 14:30:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77826C08C5C1
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jun 2020 11:30:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so3443078wru.0
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jun 2020 11:30:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b06a79c845e0ab251235d30f7dc94dd5@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, david.m.ertman@intel.com, shiraz.saleem@intel.com, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Uwe

On Wed, 10 Jun 2020, Michael Walle wrote:

> Am 2020-06-10 09:56, schrieb Lee Jones:
> > On Wed, 10 Jun 2020, Michael Walle wrote:
> > 
> > > Am 2020-06-10 09:19, schrieb Lee Jones:
> > > > On Wed, 10 Jun 2020, Michael Walle wrote:
> > > > > Am 2020-06-09 21:45, schrieb Lee Jones:
> > > > > > On Tue, 09 Jun 2020, Michael Walle wrote:
> > > > > > > > We do not need a 'simple-regmap' solution for your use-case.
> > > > > > > >
> > > > > > > > Since your device's registers are segregated, just split up the
> > > > > > > > register map and allocate each sub-device with it's own slice.
> > > > > > >
> > > > > > > I don't get it, could you make a device tree example for my
> > > > > > > use-case? (see also above)
> > > > > >
> > > > > >     &i2cbus {
> > > > > >         mfd-device@10 {
> > > > > >             compatible = "simple-mfd";
> > > > > >             reg = <10>;
> > > > > >
> > > > > >             sub-device@10 {
> > > > > >                 compatible = "vendor,sub-device";
> > > > > >                 reg = <10>;
> > > > > >             };
> > > > > >    };
> > > > > >
> > > > > > The Regmap config would be present in each of the child devices.
> > > > > >
> > > > > > Each child device would call devm_regmap_init_i2c() in .probe().
> > > > >
> > > > > Ah, I see. If I'm not wrong, this still means to create an i2c
> > > > > device driver with the name "simple-mfd".
> > > >
> > > > Yes, it does.
> > > >
> > > > > Besides that, I don't like this, because:
> > > > >  - Rob already expressed its concerns with "simple-mfd" and so on.
> > > >
> > > > Where did this take place?  I'd like to read up on this.
> > > 
> > > In this thread:
> > > https://lore.kernel.org/linux-devicetree/20200604211039.12689-1-michael@walle.cc/T/#m16fdba5962069e7cd4aa817582ee358c9fe2ecbf
> > > 
> > > >
> > > > >  - you need to duplicate the config in each sub device
> > > >
> > > > You can have a share a single config.
> > > >
> > > > >  - which also means you are restricting the sub devices to be
> > > > >    i2c only (unless you implement and duplicate other regmap configs,
> > > > >    too). For this driver, SPI and MMIO may be viable options.
> > > >
> > > > You could also have a shared implementation to choose between different
> > > > busses.
> > > 
> > > Then what is the difference between to have this shared config in the
> > > parent driver only and use the functions which are already there, i.e.
> > > dev_get_regmap(parent). But see, below, I'll wait with what you're
> > > coming up.
> > 
> > The difference is the omission of an otherwise pointless/superfluous
> > driver.  Actually, it's the difference between the omission of 10
> > pointless drivers!
> 
> If you want to omit anything generic in the device tree - and as far as
> I understand it - that should be the way to go, the specific compatible
> string of the parent device has to go somewhere. Thus I'd appreciate
> a consolidated (MFD) driver which holds all these, as you say it
> pointless drivers.
> Because IMHO they are not pointless, rather they are
> the actual drivers for the MFD. Its sub nodes are just an implementation
> detail to be able to use the OF bindings
> (like your clock example or
> a phandle to a PWM controller). Just because it is almost nothing there
> except the regmap instantiation doesn't mean it is not a valid MFD driver.

A valid MFD driver is whatever we (the Linux community at large)
define it to be.  An MFD is not a real thing.  We made it up.  It's
MFD which is the implementation detail, not the child devices.  If a
driver a) does very little, and b) the very little it does do can be
resolved in a different way, is not a valid driver.  It's a waste of
disk space.

> And there is also additional stuff, like clock enable, version checks, etc.

As more functionality is added *then* we can justify a driver.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
