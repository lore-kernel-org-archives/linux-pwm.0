From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v4 0/4] ARM: at91: Properly handle slow clock
Date: Sun, 16 Aug 2015 11:23:42 +0200
Message-ID: <1439717026-30634-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-pwm@vger.kernel.org

Hi,

It was discovered that all the slow clock user were not properly claiming it.
This can end up in a system hang because the last registered user is releasing
it, and it gets disabled.

commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system hang")
was a workaround. This series is adding the slow clock to the necessary drivers
to avoid the issue and then removes that workaround.

Changes in v4:
 - enable slow_clk before t2_clk in tcb_clksrc.c
 - properly disable slow_clk in the error path of atmel_tcb_pwm_probe()
 - added Daniel's acks

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pwm@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>

Alexandre Belloni (2):
  watchdog: at91sam9: get and use slow clock
  clocksource: atmel-st: get and use slow clock

Boris Brezillon (2):
  clocksource: tcb_clksrc: fix setup_clkevents error path
  misc: atmel_tclib: get and use slow clock

 drivers/clocksource/tcb_clksrc.c     | 12 ++++++++++--
 drivers/clocksource/timer-atmel-st.c | 31 ++++++++++++++++++++++---------
 drivers/misc/atmel_tclib.c           |  4 ++++
 drivers/pwm/pwm-atmel-tcb.c          | 26 +++++++++++++++++++-------
 drivers/watchdog/at91sam9_wdt.c      | 22 ++++++++++++++++++++--
 include/linux/atmel_tc.h             |  1 +
 6 files changed, 76 insertions(+), 20 deletions(-)

-- 
2.1.4
