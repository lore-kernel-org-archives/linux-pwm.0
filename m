From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Date: Tue, 9 Jun 2020 19:52:31 +0100
Message-ID: <20200609185231.GO4106@dell>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
 <20200608082827.GB3567@dell>
 <20200609165401.GB1019634@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbgFISwg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jun 2020 14:52:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77C8C08C5C2
        for <linux-pwm@vger.kernel.org>; Tue,  9 Jun 2020 11:52:35 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r15so4176951wmh.5
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jun 2020 11:52:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200609165401.GB1019634@bogus>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Michael Walle <michael@walle.cc>, Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>

On Tue, 09 Jun 2020, Rob Herring wrote:

> On Mon, Jun 08, 2020 at 09:28:27AM +0100, Lee Jones wrote:
> > Rob, something for you below.
> > 
> > On Sat, 06 Jun 2020, Michael Walle wrote:
> > > Am 2020-06-06 13:46, schrieb Mark Brown:
> > > > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> > > > > Am 2020-06-05 12:50, schrieb Mark Brown:
> > > > 
> > > > > > I have no idea what you are thinking of when you say "simple-regmap" so
> > > > > > it is difficult to comment.
> > > > 
> > > > > I guess, Lee is suggesting to be able to create a regmap instance via
> > > > > device tree (and populate its child nodes?). Like
> > > > >   compatible = "syscon", "simple-mfd";
> > > > > but for any regmap, not just MMIO.
> > 
> > Bingo!
> > 
> > > > I don't understand why this would be anything separate to
> > > > simple-mfd.
> > > 
> > > Don't just simple-mfd tells the of core, to probe the children this
> > > node? Where does the regmap then come from?
> > 
> > Right.  I'm suggesting a means to extrapolate complex shared and
> > sometimes intertwined batches of register sets to be consumed by
> > multiple (sub-)devices spanning different subsystems.
> > 
> > Actually scrap that.  The most common case I see is a single Regmap
> > covering all child-devices.  It would be great if there was a way in
> > which we could make an assumption that the entire register address
> > space for a 'tagged' (MFD) device is to be shared (via Regmap) between
> > each of the devices described by its child-nodes.  Probably by picking
> > up on the 'simple-mfd' compatible string in the first instance.
> > 
> > Rob, is the above something you would contemplate?
> 
> No. I'd like to just kill off syscon and simple-mfd really. Those are 
> just hints meaning a specific compatible is still needed, but I see them 
> all the time alone (or combined like above). 'syscon' just serves to 
> create a regmap. This could be accomplished just with a list of 
> compatibles to register a regmap for. That might be a longish list, but 
> wanting a regmap is really a kernel implementation detail and decision.

Exactly.  Syscon is a real tangible thing and Regmap is a Linux
subsystem.  So swapping out the former for the latter sounds like the
opposite of what you'd want to do.

> > > MFD core can
> > > match a device tree node today; but only one per unique compatible
> > > string. So what should I use to differentiate the different
> > > subdevices?
> > 
> > Right.  I have been aware of this issue.  The only suitable solution
> > to this would be to match on 'reg'.
> > 
> > FYI: I plan to fix this.
> > 
> > If your register map needs to change, then I suggest that this is
> > either a new device or at least a different version of the device and
> > would also have to be represented as different (sub-)mfd_cell.
> 
> The same register set at a different offset is the same (sub)device.

See below.

> > > Rob suggested the internal offset, which I did here.
> > 
> > FWIW, I don't like this idea.  DTs should not have to be modified
> > (either in the first instance or subsequently) or specifically
> > designed to patch inadequacies in any given OS.
> 
> My understanding is there can be differing combinations or number of 
> instances of sub devices for this device. That's when having DT sub 
> devices makes sense. If the h/w changes, then the DT should change.

This is the same point I was making above.

> Multiple instances of devices require an address to identify them and we 
> don't make up numbering if we can avoid it. The earlier revisions just 
> had made up indices for addresses.

Right.  Which I'm against.

Placing "internal offsets" into the 'reg' property is a hack.

The issue is, if we need to configure the devices differently, then
how do we identify them in order to ensure the correct OF node pointer
is allocated to the correct platform device?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
