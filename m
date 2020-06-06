From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management
 controller
Date: Sat, 06 Jun 2020 14:45:38 +0200
Message-ID: <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc> <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgFFMpt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 6 Jun 2020 08:45:49 -0400
In-Reply-To: <20200606114645.GB2055@sirena.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>

Am 2020-06-06 13:46, schrieb Mark Brown:
> On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
>> Am 2020-06-05 12:50, schrieb Mark Brown:
> 
>> > I have no idea what you are thinking of when you say "simple-regmap" so
>> > it is difficult to comment.
> 
>> I guess, Lee is suggesting to be able to create a regmap instance via
>> device tree (and populate its child nodes?). Like
>>   compatible = "syscon", "simple-mfd";
>> but for any regmap, not just MMIO.
> 
> I don't understand why this would be anything separate to
> simple-mfd.

Don't just simple-mfd tells the of core, to probe the children this
node? Where does the regmap then come from?

> 
>> But, there is more in my driver:
>>  (1) there is a version check
>>  (2) there is another function for which there is no suitable linux
>>      subsystem I'm aware of and thus which I'd like to us sysfs
>>      attributes for: This controller supports 16 non-volatile
>>      configuration bits. (this is still TBD)
> 
> TBH I'd also say that the enumeration of the subdevices for this
> device should be in the device rather than the DT, they don't
> seem to be things that exist outside of this one device.

We're going circles here, formerly they were enumerated in the MFD.
Yes, they are devices which aren't likely be used outside a
"sl28cpld", but there might there might be other versions of the
sl28cpld with other components on different base addresses. I
don't care if they are enumerated in DT or MFD, actually, I'd
prefer the latter. _But_ I would like to have the device tree
properties for its subdevices, e.g. the ones for the watchdog or
whatever components there might be in the future. MFD core can
match a device tree node today; but only one per unique compatible
string. So what should I use to differentiate the different
subdevices? Rob suggested the internal offset, which I did here.
But then, there is less use in duplicating the offsets in the MFD
just to have the MFD enumerate the subdevices and then match
the device tree nodes against it. I can just use
of_platform_populate() to enumerate the children and I won't
have to duplicate the base addresses.

So here we are, any ideas appreciated.

-michael
