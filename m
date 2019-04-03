From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 00/12] clocksource: improve Atmel TCB timer driver
Date: Wed,  3 Apr 2019 16:11:08 +0200
Message-ID: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

Hi,

This series immproves the Atmel TCB clocksource driver to address the
most urgent shortcomings:
 - the current tcb_clksrc driver is probed too late to be able to be used at
   boot and we now have SoCs that don't have a PIT. They currently are not able
   to boot an upstream kernel.
 - using the PIT doesn't work well with preempt-rt because its interrupt is
   shared (in particular with the UART) and their interrupt flags are
   incompatible). This also happen with the threadedirq command line
   switch.
 - there is currently no high resolution sched_clock.

The plan is to get those changes upstream as soon as possible as they
arre fixing real issues that people are facing. There are further
changes needed on the clocksource driver to try to stop wasting a TCB
channel.
the PWM TCB driver will also be changed to actually used the reviewed
binding and this will allow to get rif of atmel_tclib.

Alexandre Belloni (12):
  ARM: at91: move SoC specific definitions to SoC folder
  misc: atmel_tclib: drop AVR32 support
  misc: atmel_tclib: move definitions to header file
  clocksource/drivers/tcb_clksrc: stop depending on atmel_tclib
  clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
  ARM: at91: Implement clocksource selection
  clocksource/drivers/tcb_clksrc: move Kconfig option
  clocksource/drivers/timer-atmel-pit: rework Kconfig option
  clocksource/drivers/tcb_clksrc: Rename the file for consistency
  ARM: configs: at91: unselect PIT
  misc: atmel_tclib: do not probe already used TCBs
  clocksource/drivers/timer-atmel-tcb: Use ARRAY_SIZE instead of  
    hardcoded size

 arch/arm/configs/at91_dt_defconfig            |   1 +
 arch/arm/configs/sama5_defconfig              |   1 +
 arch/arm/mach-at91/Kconfig                    |  23 ++++
 drivers/clocksource/Kconfig                   |  12 +-
 drivers/clocksource/Makefile                  |   2 +-
 .../{tcb_clksrc.c => timer-atmel-tcb.c}       | 123 ++++++++++++------
 drivers/misc/Kconfig                          |  24 ----
 drivers/misc/atmel_tclib.c                    |  37 +-----
 drivers/pwm/pwm-atmel-tcb.c                   |   2 +-
 .../atmel_tc.h => soc/at91/atmel_tcb.h}       |  25 +++-
 10 files changed, 146 insertions(+), 104 deletions(-)
 rename drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} (81%)
 rename include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} (95%)

-- 
2.20.1
