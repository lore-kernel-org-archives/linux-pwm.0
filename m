From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v9 00/27] Ingenic TCU patchset v9
Date: Thu, 27 Dec 2018 19:12:52 +0100
Message-ID: <20181227181319.31095-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

This is the v9 of my patchset to add support for the Timer/Counter Unit
present on Ingenic JZ47xx SoCs.

Changes from v8 mainly include:

- The system timer and clocksource sub-nodes of the ingenic-timer driver
  are gone. Now, the ingenic-timer will use the (optional) property
  named "ingenic,pwm-channels-mask" to know which TCU channels are
  reserved for PWM use.

- New patch [11/27] makes the PWM driver implement the .apply callback,
  which is cleaner and incidentally fixes a long-standing bug.

- The patch in V8 that converted the PWM driver to use the regmap and
  clocks provided by the ingenic-timer driver has been splitted in three
  patches, [12,13,14/27]. The algorithm in [14/27] has been slightly
  improved.

- The patch that adds support for the JZ4725B SoC to the PWM driver has
  been removed from the patchset, as it's been suggested that the core
  could use a "npwms" device property to override the number of PWMs set
  in the driver.

Thanks,
-Paul Cercueil
