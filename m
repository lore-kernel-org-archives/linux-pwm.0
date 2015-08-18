From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC PATCH] pwm: TLC591xx PWM driver
Date: Tue, 18 Aug 2015 16:52:06 +0300
Message-ID: <1439905927-27861-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-leds-owner@vger.kernel.org>
Sender: linux-leds-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Andrew Lunn <andrew@lunn.ch>, linux-leds@vger.kernel.org, Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Bryan Wu <cooloney@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-pwm@vger.kernel.org

Hi,

Here's an RFC for a driver for TI's TLC59108/TLC59116 chips. This is an
alternate implementation to the LED driver [1].

We (TI) use the chip for LCD backlight and also as a GPIO expander. Andrew
(author of the LED driver) uses it for plain LEDs.

This implementation works for backlight and plain LED use cases. The LED
version does not (afaik) work for backlight out of the box. Neither supports
GPIO API.

I'd like to hear feedback on whether this kind of HW should have a PWM or a LED
driver.

The LED driver offers APIs for things like blinking, which the PWM API doesn't.
On the other hand, there's pwm_bl.c which give us backlight device with PWM,
and a GPIO over PWM sounds more sane to me than GPIO over LED. But I really
don't have any hard arguments why one solution would be better than the other.

Of course, one option is to have both PWM and LED drivers in the kernel. This
is the reason I set the driver's compatible string to "tlc59108-pwm" so that it
doesn't clash with the LED driver.

Or, possibly a mfd is an option.

 Tomi

[1] https://www.marc.info/?l=devicetree&m=142663032707961&w=1

Tomi Valkeinen (1):
  pwm: add TLC59108/TLC59116 PWM driver

 .../devicetree/bindings/pwm/ti,tlc59108-pwm.txt    |  16 ++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-tlc591xx.c                         | 273 +++++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/ti,tlc59108-pwm.txt
 create mode 100644 drivers/pwm/pwm-tlc591xx.c

-- 
2.1.4
