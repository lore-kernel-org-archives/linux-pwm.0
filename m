From: Paul Cercueil <paul@crapouillou.net>
Subject: [5.2][PATCH v10 00/27] Ingenic TCU patchset
Date: Sat,  2 Mar 2019 20:33:46 -0300
Message-ID: <20190302233413.14813-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

This is the Ingenic JZ47xx TCU patchset version 10.

Changes from v9:
- [04/27]: - The clocksource is now created unconditionally, even if the
             SoC has the better OS Timer. This gives the choice back to
	     the user.
	   - Simplify the set_rate/set_parent callbacks for the clocks
	   - Probe platform driver at subsys_initcall() instead of
	     using builtin_platform_driver_probe(), to ensure that the
	     devices are populated before the children drivers (e.g. OS
	     Timer driver) are probed.
- [05/27]: Fix incorrect mask used with regmap_update_bits, which caused
           the clocksource to be unstable on JZ4770 and JZ4780.
- [13/27]: Update commit message to reflect why "select REGMAP" was
           removed.
- [14/27]: Use a new algorithm that does not use clk_round_rate().
- [23/27] and [25/27]: Revert behaviour to what was in V8.

It has been tested and reported to be working, on the JZ4725B by me,
on the JZ4740 by Artur Rojek, and on the JZ4780 by Mathieu Malaterre.

I'd like this patchset to go through the MIPS tree, that will allow other
unrelated cleanups to follow.

Thanks,
- Paul
