From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v5 12/13] arm64: dts: freescale: sl28: enable LED support
Date: Fri, 17 Jul 2020 23:54:42 +0200
Message-ID: <af0584da0f43cb6cfffeb8fcf2235acb@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-13-michael@walle.cc> <20200717083610.GC1027@bug>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from ssl.serverraum.org ([176.9.125.105]:37007 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgGQVyu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 17:54:50 -0400
In-Reply-To: <20200717083610.GC1027@bug>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@>

Hi Pavel,

Am 2020-07-17 10:36, schrieb Pavel Machek:
> Hi!
> 
>> Now that we have support for GPIO lines of the SMARC connector, enable
>> LED support on the KBox A-230-LS. There are two LEDs without fixed
>> functions, one is yellow and one is green. Unfortunately, it is just 
>> one
>> multi-color LED, thus while it is possible to enable both at the same
>> time it is hard to tell the difference between "yellow only" and 
>> "yellow
>> and green".
> 
>> +		user_yellow {
>> +			label = "s1914:yellow:user";
>> +			gpios = <&sl28cpld_gpio0 0 0>;
>> +		};
>> +
>> +		user_green {
>> +			label = "s1914:green:user";
>> +			gpios = <&sl28cpld_gpio1 3 0>;
>> +		};
> 
> This is not suitable label for such LEDs... there's zero chance 
> userland will
> know what to do with these.
> 
> Do they have some kind of "usual" function?

Unfortunately, they do not. I guess the green one could be something 
like
"application ready" and the yellow one could be an indication that some
fault occurred.

Do you have any suggestions?

-michael
