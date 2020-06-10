From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Date: Wed, 10 Jun 2020 19:02:41 +0100
Message-ID: <20200610180241.GU4106@dell>
References: <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
 <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609151941.GM4106@dell>
 <95e6ec9bbdf6af7a9ff9c31786f743f2@walle.cc>
 <20200609194505.GQ4106@dell>
 <3a6931248f0efcaf8efbb5425a9bd833@walle.cc>
 <20200610071940.GS4106@dell>
 <CAL_JsqKr1aDVzgAMjwwK8E8O_f29vSrx1HXk81FF+rd3sEe==w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgFJSCq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Jun 2020 14:02:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C276C03E96F
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jun 2020 11:02:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u13so2674754wml.1
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jun 2020 11:02:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL_JsqKr1aDVzgAMjwwK8E8O_f29vSrx1HXk81FF+rd3sEe==w@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Michael Walle <michael@walle.cc>, Andy Shevchenko <andy.shevchenko@gmail.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, david.m.ertman@intel.com, shiraz.saleem@intel.com, Mark Brown <broonie@kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux HWMON List <linux-hwmon@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.redin>

On Wed, 10 Jun 2020, Rob Herring wrote:

> On Wed, Jun 10, 2020 at 1:19 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Wed, 10 Jun 2020, Michael Walle wrote:
> > > Am 2020-06-09 21:45, schrieb Lee Jones:
> > > > On Tue, 09 Jun 2020, Michael Walle wrote:
> > > > > > We do not need a 'simple-regmap' solution for your use-case.
> > > > > >
> > > > > > Since your device's registers are segregated, just split up the
> > > > > > register map and allocate each sub-device with it's own slice.
> > > > >
> > > > > I don't get it, could you make a device tree example for my
> > > > > use-case? (see also above)
> > > >
> > > >     &i2cbus {
> > > >         mfd-device@10 {
> > > >             compatible = "simple-mfd";
> > > >             reg = <10>;
> > > >
> > > >             sub-device@10 {
> > > >                 compatible = "vendor,sub-device";
> > > >                 reg = <10>;
> > > >             };
> > > >    };
> > > >
> > > > The Regmap config would be present in each of the child devices.
> > > >
> > > > Each child device would call devm_regmap_init_i2c() in .probe().
> > >
> > > Ah, I see. If I'm not wrong, this still means to create an i2c
> > > device driver with the name "simple-mfd".
> >
> > Yes, it does.
> 
> TBC, while fine for a driver to bind on 'simple-mfd', a DT compatible
> with that alone is not fine.

'simple-mfd' essentially means:

  "This device doesn't do anything useful, but the children do."

When used with 'syscon' it means:

  "Memory for this device is shared between all children"

Adding more specific/descriptive compatible strings is conceptually
fine, but they should not be forced to bind to a real driver using
them.  Else we're creating drivers for the sake of creating drivers.

This is especially true with 'simple-mfd' is used without 'syscon'.

> > > Besides that, I don't like this, because:
> > >  - Rob already expressed its concerns with "simple-mfd" and so on.
> >
> > Where did this take place?  I'd like to read up on this.
> >
> > >  - you need to duplicate the config in each sub device
> >
> > You can have a share a single config.
> >
> > >  - which also means you are restricting the sub devices to be
> > >    i2c only (unless you implement and duplicate other regmap configs,
> > >    too). For this driver, SPI and MMIO may be viable options.
> >
> > You could also have a shared implementation to choose between different
> > busses.
> 
> I think it is really the syscon mfd driver you want to generalize to
> other buses. Though with a quick look at it, there's not really a
> whole lot to share. The regmap lookup would be the main thing. You are
> going to need a driver instance for each bus type.

On it.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
