From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 00/48] ARM: at91: rework Atmel TCB drivers
Date: Sat, 11 Jun 2016 00:03:03 +0200
Message-ID: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Antoine Aubert <a.aubert@overkiz.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, Douglas Gilbert <dgilbert@interlog.com>, Fabio Porcedda <fabio.porcedda@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Gregory Hermant <gregory.hermant@calao-systems.com>, Joachim Eastwood <manabian@gmail.com>, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, Marek Vasut <marex@denx.de>, Martin Reimann <martin.reimann@egnite.de>, Rob Herring <robh+dt@kernel.org>, Rodolfo Giometti <giometti@linux.it>, Sergio Tanzilli <tanzilli@acmesystems.it>, Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thie>
List-Id: linux-pwm@vger.kernel.org

Hi,

This series reworks the Atmel Timer counter Block drivers. Those blocks
each have 3 counters with 2 channels each and can be used for
multiple functions:
 - timers
 - PWMs
 - Quadrature decoders
 - Stepper motor counters

Up until now, each TCB was fully used by each driver, possibly wasting
counters/channels.

There is a second issue motivating that rework. Until now, the PIT is
still used to boot then later in the boot sequence, the clocksource is
switched to the TCB. This ends up not working well with preempt-rt
because on some SoCs, the PIT interrupt is shared with the DBGU uart.
When using preempt-rt the interrupt flags for the PIT and the DBGU end
up being incompatible.

The whole rework doesn't break the DT ABI for the clocksource as the old
driver is kept anyway for AVR32. However, I still took the time to
switch all the upstreamed board dts to the new bindings.
However, there is no other choice than breaking the mainly unused
pwm-atmel-tcb binding. Only the kizbox is actually using it.

I hope we could quickly come to an agreement on the new DT bindings and
include those changes in 4.8.

Regarding the tcbclksrc driver, I'm not completely happy with the
request_irq/free_irq thing but there is not much choice unless we want
to pass in the clksrc handler even when using the clkevt driver as they
may share the same interrupt.

Cc: Antoine Aubert <a.aubert@overkiz.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: Douglas Gilbert <dgilbert@interlog.com>
Cc: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>
Cc: Martin Reimann <martin.reimann@egnite.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Rodolfo Giometti <giometti@linux.it>
Cc: Sergio Tanzilli <tanzilli@acmesystems.it>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Schendekehl <tim.schendekehl@egnite.de>

Alexandre Belloni (47):
  ARM: at91: Document new TCB bindings
  ARM: dts: at91: at91rm9200: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91rm9200ek; use TCB0 as clocksource
  ARM: dts: at91: mpa1600; use TCB0 as clocksource
  ARM: dts: at91: at91sam9260: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: ethernut5: use TCB0 as clocksource
  ARM: dts: at91: foxg20: use TCB0 as clocksource
  ARM: dts: at91: animeo_ip: use TCB0 as clocksource
  ARM: dts: at91: kizbox: use TCB0 as clocksource
  ARM: dts: at91: at91sam9g20ek: use TCB0 as clocksource
  ARM: dts: at91: ge863-pro3: use TCB0 as clocksource
  ARM: dts: at91: at91sam9261: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9261ek: use TCB0 as clocksource
  ARM: dts: at91: at91sam9263: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9263ek: use TCB0 as clocksource
  ARM: dts: at91: calao: use TCB0 as clocksource
  ARM: dts: at91: at91sam9g45: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9m10g45ek: use TCB0 as clocksource
  ARM: dts: at91: pm9g45: use TCB0 as clocksource
  ARM: dts: at91: at91sam9rl: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9rlek: use TCB0 as clocksource
  ARM: dts: at91: at91sam9n12: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9n12ek: use TCB0 as clocksource
  ARM: dts: at91: at91sam9x5: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9x5cm: use TCB0 as clocksource
  ARM: dts: at91: acme/g25: use TCB0 as clocksource
  ARM: dts: at91: cosino: use TCB0 as clocksource
  ARM: dts: at91: kizboxmini: use TCB0 as clocksource
  ARM: dts: at91: sama5d3: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: sama5d3xek; use TCB0 as clocksource
  ARM: dts: at91: sama5d3 Xplained: use TCB0 as clocksource
  ARM: dts: at91: kizbox2: use TCB0 as clocksource
  ARM: dts: at91: sama5d4: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: sama5d4: Add TCB2
  ARM: dts: at91: sama5d4ek: use TCB2 as clocksource
  ARM: dts: at91: sama5d4 Xplained: use TCB2 as clocksource
  ARM: dts: at91: ma5d4: use TCB2 as clocksource
  ARM: dts: at91: vinco: use TCB2 as clocksource
  ARM: dts: at91: sama5d2: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: sama5d2 Xplained: use TCB0 as clocksource
  clocksource/drivers: Add a new driver for the Atmel ARM TC blocks
  clocksource/drivers: Add a clockevent driver for Atmel TC blocks
  clocksource: atmel-pit: allow unselecting ATMEL_PIT
  ARM: at91/defconfig: sama5: unselect ATMEL_PIT
  ARM: at91/defconfig: at91_dt unselect ATMEL_PIT
  PWM: atmel-tcb: switch to new binding
  ARM: dts: at91: kizbox: switch to new pwm-atmel-tcb binding

Cyrille Pitchen (1):
  clk: at91: replace usleep() by udelay() calls

 .../devicetree/bindings/arm/atmel-at91.txt         |  32 ---
 .../devicetree/bindings/mfd/atmel-tcb.txt          |  62 +++++
 .../devicetree/bindings/pwm/atmel-tcb-pwm.txt      |  12 +-
 arch/arm/boot/dts/animeo_ip.dts                    |  12 +
 arch/arm/boot/dts/at91-ariag25.dts                 |  12 +
 arch/arm/boot/dts/at91-ariettag25.dts              |  12 +
 arch/arm/boot/dts/at91-cosino.dtsi                 |  12 +
 arch/arm/boot/dts/at91-foxg20.dts                  |  12 +
 arch/arm/boot/dts/at91-kizbox.dts                  |  54 +++-
 arch/arm/boot/dts/at91-kizbox2.dts                 |  12 +
 arch/arm/boot/dts/at91-kizboxmini.dts              |  12 +
 arch/arm/boot/dts/at91-qil_a9260.dts               |  12 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  12 +
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  12 +
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi          |  12 +
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |  12 +
 arch/arm/boot/dts/at91-sama5d4ek.dts               |  12 +
 arch/arm/boot/dts/at91-vinco.dts                   |  12 +
 arch/arm/boot/dts/at91rm9200.dtsi                  |   8 +-
 arch/arm/boot/dts/at91rm9200ek.dts                 |  12 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |   8 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |   4 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |  12 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |   4 +-
 arch/arm/boot/dts/at91sam9263ek.dts                |  12 +
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |  12 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   8 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |  12 +
 arch/arm/boot/dts/at91sam9n12.dtsi                 |   8 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                |  12 +
 arch/arm/boot/dts/at91sam9rl.dtsi                  |   4 +-
 arch/arm/boot/dts/at91sam9rlek.dts                 |  12 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   8 +-
 arch/arm/boot/dts/at91sam9x5cm.dtsi                |  12 +
 arch/arm/boot/dts/ethernut5.dts                    |  12 +
 arch/arm/boot/dts/ge863-pro3.dtsi                  |  12 +
 arch/arm/boot/dts/mpa1600.dts                      |  12 +
 arch/arm/boot/dts/pm9g45.dts                       |  12 +
 arch/arm/boot/dts/sama5d2.dtsi                     |   8 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |   4 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi                |   4 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi                  |  12 +
 arch/arm/boot/dts/sama5d4.dtsi                     |  18 +-
 arch/arm/boot/dts/tny_a9260_common.dtsi            |  12 +
 arch/arm/boot/dts/tny_a9263.dts                    |  12 +
 arch/arm/boot/dts/usb_a9260_common.dtsi            |  12 +
 arch/arm/boot/dts/usb_a9263.dts                    |  12 +
 arch/arm/configs/at91_dt_defconfig                 |   1 +
 arch/arm/configs/sama5_defconfig                   |   1 +
 drivers/clk/at91/clk-main.c                        |   2 +-
 drivers/clk/at91/clk-slow.c                        |   6 +-
 drivers/clocksource/Kconfig                        |  32 ++-
 drivers/clocksource/Makefile                       |   4 +-
 drivers/clocksource/timer-atmel-tcbclkevt.c        | 220 +++++++++++++++
 drivers/clocksource/timer-atmel-tcbclksrc.c        | 305 +++++++++++++++++++++
 drivers/pwm/Kconfig                                |   3 +-
 drivers/pwm/pwm-atmel-tcb.c                        | 219 ++++++++-------
 include/soc/at91/atmel_tcb.h                       | 220 +++++++++++++++
 58 files changed, 1452 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
 create mode 100644 drivers/clocksource/timer-atmel-tcbclkevt.c
 create mode 100644 drivers/clocksource/timer-atmel-tcbclksrc.c
 create mode 100644 include/soc/at91/atmel_tcb.h

-- 
2.8.1
