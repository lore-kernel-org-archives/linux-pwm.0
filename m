From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: [PATCH 00/10]
Date: Mon, 26 Oct 2015 22:32:31 +0100
Message-ID: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Olliver Schinagl <o.schinagl@ultimaker.com>, Olliver Schinagl <oliver@schinagl.nL>
List-Id: linux-pwm@vger.kernel.org

Hey Thierry,

With this patch set I wanted to add some new features to the PWM framework,
while doing so, I ran into 2 minor things with the lpc18xx and sunxi driver.

The lpc18xx I bumped into because I was trying to learn from existing drivers.
Here I only added the setter to set the chip_data, since I think it is bad
practice to set data directly in the struct, I'll be happy to stand corrected
however and that patch not applied.

Since I use the sunxi platform a lot, I used this platform to test things with
and to also ran into some issues with the hardware PWM as can be seen in its
commit log.

The major feature of this patch-set however is the introduction of the Generic
GPIO based PWM driver based on the high-resolution timers. On an Olimex Lime2
featuring an Allwinner A20 SoC, I can toggle quite reliably at 100 kHz. At 150
kHz the SoC started to show signs of being to slow and the scope traces started
to become inconsistent.
Naturally of course, a GPIO based PWM is heavily dependent on system load and
on the SoC. For some use cases a bit-banged PWM might not be ideal, audio for
example does not sound 'pitch-perfect' but does work pretty alright. It really
is up to the users what one might one to use a bit-banged GPIO driver for.

Finally, I've started to add a 'pulse' option to the PWM framework and
added it to the sunxi and gpio variants. It currently does not work and I
did not wanted to submit it until Boris's PWM patches where in, but I also
felt an early review on the intention would be a good idea.
The idea is using this new feature, we can start emitting a fixed number of
pulses, using the PWM 'hardware' guaranteeing properly timed output.
Not all hardware may support this at all (might be emulated however) and the
sunxi hardware for example is limited to 1 pulse max (but may emulate more with
timers for example). The GPIO driver is able to produce a lot of timed pulses
however.

Thanks,

Olliver

Signed-off-by: Olliver Schinagl <oliver@schinagl.nL>

Olliver Schinagl (10):
  pwm: lpc18xx_pwm: use pwm_set_chip_data
  pwm: sunxi: fix whitespace issue
  pwm: sunxi: Yield some time to the pwm-block to become ready
  pwm: core: use bitops
  pwm: sysfs: do not unnecessarily store result in var
  pwm: sysfs: make use of the DEVICE_ATTR_[RW][WO] macro's
  pwm: gpio: Add a generic gpio based PWM driver
  pwm: core: add pulse feature to the PWM framework
  pwm: pwm_gpio: add pulse option
  pwm: sunxi: Add possibility to pulse the sunxi pwm output

 Documentation/devicetree/bindings/pwm/pwm-gpio.txt |  18 ++
 MAINTAINERS                                        |   5 +
 drivers/pwm/Kconfig                                |  15 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  30 ++-
 drivers/pwm/pwm-gpio.c                             | 276 +++++++++++++++++++++
 drivers/pwm/pwm-lpc18xx-sct.c                      |  11 +-
 drivers/pwm/pwm-sun4i.c                            |  73 ++++--
 drivers/pwm/sysfs.c                                | 133 +++++++---
 include/linux/pwm.h                                |  71 +++++-
 10 files changed, 556 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.txt
 create mode 100644 drivers/pwm/pwm-gpio.c

-- 
2.6.1
