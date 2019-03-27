From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v11 00/27] Ingenic JZ47xx TCU pachset v11
Date: Thu, 28 Mar 2019 00:16:04 +0100
Message-ID: <20190327231631.15708-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

This is the v11 of my patchset that adds support to the Timer/Counter
Unit (TCU) present in the JZ47xx SoCs from Ingenic.

Changes from v10:

[03/27]: Fix info about default value of ingenic,pwm-channels-mask

[04/27]: - Change prototype of exported function
           ingenic_tcu_pwm_can_use_chn(), use a struct device * as first
	   argument.
	 - Read clocksource using the regmap instead of bypassing it.
	   Bypassing the regmap makes sense only for the sched_clock where
	   the read operation must be as fast as possible.
	 - Fix incorrect format in pr_crit() macro

[05/27]: Use regmap inside the clocksource read functions. Keep bypassing the
         regmap inside the sched_clock read functions.

[12/27]: Add note about abrupt shutdown

[13/27]: - Use pwm_set_chip_data() to hold the clock pointers
         - Remove unused variable 'jz' in jz4740_pwm_request()

[14/27]: - Use proper block-comment style.
         - Modify commit message to fit the new algorithm used.

[15/27]: Use new version of ingenic_tcu_pwm_can_use_chn()

The other patches have not been modified since v10.

If this patchset passes review, I'd like it to be merged in the MIPS
tree.

Thanks,
-Paul
