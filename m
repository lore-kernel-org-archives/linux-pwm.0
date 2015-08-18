From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH] pwm: TLC591xx PWM driver
Date: Tue, 18 Aug 2015 17:09:16 +0200
Message-ID: <20150818150916.GG4381@lunn.ch>
References: <1439905927-27861-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:33041 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbbHRPQe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 18 Aug 2015 11:16:34 -0400
Content-Disposition: inline
In-Reply-To: <1439905927-27861-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, Jacek Anaszewski <j.anaszewski@samsung.com>, Bryan Wu <cooloney@gmail.com>

> On the other hand, there's pwm_bl.c which give us backlight device
> with PWM,

Lets look at this. A backlight device seems to do most of its work in
the update_status callback. It is given a brightness in
bl->props.brightness, which takes a value between 0 and
props.max_brightness.

What pwm_bl.c does it then turn this brightness value into an
artificial PWM configuration. Your proposed PWM driver then turns this
back into a brightness, since you don't actually implement the period
part of the PWM interface.

From an architecture point of view, doesn't an LED class device, which
takes a brightness value, seem much more naturally?

It seems like implementing a generic led_bl.c driver would make sense.
It would also allow some of the code in drivers/video/backlight/ to be
eliminated. There seems to be both an LED class driver for lp55xx and
a blacklight driver lp855x_bl.c. There are duplicate lp8788, 88pm860x,
adp5520, da903x, da9052, hp6xx, and lm3533 drivers which might all be
removed if a led_bl.c generic driver existed.

> and a GPIO over PWM sounds more sane to me than GPIO over LED.

Currently two LED class drivers are calling gpiochip_add:

~/linux/drivers/leds$ grep gpiochip_add *.c
leds-pca9532.c:	      	   err = gpiochip_add(&data->gpio);
leds-tca6507.c:		   err = gpiochip_add(&tca->gpio);

The pca9532 has full GPIO capabilities, in as well as out. But it
seems like tca6507 is output only. The TLC59108/TLC59116 is also
output only. So a generic GPO driver on top of LED would make sense
for these two, and save some code/bugs.

From a stand back, lets take a look at the architecture point of view,
generic led_bl and gpio-led drivers seem to make sense.

       Andrew
