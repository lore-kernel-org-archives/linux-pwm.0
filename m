From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH] pwm: TLC591xx PWM driver
Date: Wed, 19 Aug 2015 15:31:04 +0200
Message-ID: <20150819133104.GA12002@lunn.ch>
References: <1439905927-27861-1-git-send-email-tomi.valkeinen@ti.com>
 <20150818150916.GG4381@lunn.ch>
 <55D45FE4.2050805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55D45FE4.2050805@ti.com>
Sender: linux-leds-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, Jacek Anaszewski <j.anaszewski@samsung.com>, Bryan Wu <cooloney@gmail.com>
List-Id: linux-pwm@vger.kernel.org

> But in the end, it is still PWM in the HW level, and also, the
> brightness isn't linear, or even anything like it. At least on my
> backlight, the visible values range from ~230 to 255.

I suspect the narrow range for you is a property of your hardware. For
my WRT1900ac, 0-32 the LEDs look pretty much like off. Above that, i
get light. Should the LED class layer care about this? Probably
not. It seems like the generic backlight layer should have some method
to reduce the 0-255 down to a couple of dozen useful working points.

> That said, I feel that these frameworks, GPIO, PWM and LED are somewhat
> overlapping. Not really my area of expertise, but I imagine a single
> framework containing all those functionalities could be possible.

Humm, i don't think the frameworks overlap that much. I think it is
the hardware which overlaps. You have a device with an output which
you normally connect an LED to, but you could connect anything to. You
can control this pin using a very restricted PWM like scheme, or you
can have it plain off/on.

With hardware like this, you need to decide which it is most like, and
put that framework at the bottom. Then stack generic X->Y layers on
top to get the rest of the functionality.

    Andrew
