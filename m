From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 03/16] mfd: mfd-core: match device tree node against
 reg property
Date: Tue, 26 May 2020 08:24:27 +0100
Message-ID: <20200526072427.GC3628@dell>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-4-michael@walle.cc>
 <67e90dafd67c285158c2c6f67f92edb7@walle.cc>
 <20200515102848.GH271301@dell>
 <159e68b4ce53630ef906b2fcbca925bd@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEZHYb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 May 2020 03:24:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E09C03E97E
        for <linux-pwm@vger.kernel.org>; Tue, 26 May 2020 00:24:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u13so2147453wml.1
        for <linux-pwm@vger.kernel.org>; Tue, 26 May 2020 00:24:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <159e68b4ce53630ef906b2fcbca925bd@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.or

On Mon, 25 May 2020, Michael Walle wrote:

> Am 2020-05-15 12:28, schrieb Lee Jones:
> > On Thu, 30 Apr 2020, Michael Walle wrote:
> > 
> > > Hi Lee,
> > > 
> > > Am 2020-04-23 19:45, schrieb Michael Walle:
> > > > There might be multiple children with the device tree compatible, for
> > > > example if a MFD has multiple instances of the same function. In this
> > > > case only the first is matched and the other children get a wrong
> > > > of_node reference.
> > > > Add a new option to match also against the unit address of the child
> > > > node. Additonally, a new helper OF_MFD_CELL_REG is added.
> > > 
> > > 
> > > Do you think this is feasible? I guess this is the biggest uncertainty
> > > for me at the moment in this patch series.
> > 
> > I think it sounds fine in principle.  So long as it doesn't change the
> > existing behaviour when of_reg isn't set.
> > 
> > > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > > ---
> > > >  drivers/mfd/mfd-core.c   | 29 ++++++++++++++++++++---------
> > > >  include/linux/mfd/core.h | 26 ++++++++++++++++++++------
> > > >  2 files changed, 40 insertions(+), 15 deletions(-)

[...]

> > > > diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> > > > index d01d1299e49d..c2c0ad6b14f3 100644
> > > > --- a/include/linux/mfd/core.h
> > > > +++ b/include/linux/mfd/core.h
> > > > @@ -13,8 +13,11 @@
> > > >  #include <linux/platform_device.h>
> > > >
> > > >  #define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
> > > > +#define MFD_OF_REG_VALID	BIT(31)
> > 
> > What about 64bit platforms?
> 
> The idea was to have this as a logical number. I.e. for now you may only
> have one subdevice per unique compatible string. In fact, if you have a
> look at the ab8500.c, there are multiple "stericsson,ab8500-pwm"
> subdevices. But there is only one DT node for all three of it. I guess
> this works as long as you don't use phandles to reference the pwm node
> in the device tree. Or you don't want to use device tree properties
> per subdevice (for example the "timeout-sec" of a watchdog device).
> 
> So to circumvent this, I thought of having the unit-address (and thus
> the "reg" property) to differentiate between multiple subdevices. Now
> there is one special case for me: this board management controller
> might be upgradable and it might change internally. Thus I came up
> with that logical numbering of subdevices. Rob doesn't seem to be a
> fan of that, though. Therefore, having bit 31 as a valid indicator
> leaves you with 2^31 logical devices, which should be enough ;)
> 
> Rob proposed to have the internal offset as the unit-address. But
> in that case I can also use devm_of_platform_populate() and don't
> need the OF_MFD_CELL_REG; I'd just parse the reg offset in each
> individual subdevice driver. But like I said, I wanted to keep the
> internal offsets out of the device tree.

Oh, I see what you're doing.

So you're adding an arbitrary ID to the device's reg property in DT?

How is this not a hack?

Why don't you use the full address for identification?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
