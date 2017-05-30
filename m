From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 00/58] ARM: at91: rework Atmel TCB drivers
Date: Tue, 30 May 2017 23:50:41 +0200
Message-ID: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Aubert <a.aubert-ZNYIgs0QAGpBDgjK7y7TUQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>, Fabio Porcedda <fabio.porcedda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Hermant <gregory.hermant-WVCdZa36k+6/3pe1ocb+swC/G2K4zDHf@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Martin Reimann <martin.reimann-inJ12LbcDfezQB+pC5nmwQ@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Raashid Muhammed <raashidmuhammed-1MQmoylvZ5VBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
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

The rework breaks the DT ABI. Backward compatibility can be kept by
keeping tcb_clksrc and atmel_tclib but as AVR32 is now gone from the
kernel, I don't think it makes much sense to keep them.

Also, there is no other choice than breaking the mainly unused
pwm-atmel-tcb binding. Only the kizbox is actually using it.

I think the bindings are now ok and I hope we can take the DT changes
for 4.13.

Cc: Antoine Aubert <a.aubert-ZNYIgs0QAGpBDgjK7y7TUQ@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
Cc: Fabio Porcedda <fabio.porcedda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Gregory Hermant <gregory.hermant-WVCdZa36k+6/3pe1ocb+swC/G2K4zDHf@public.gmane.org>
Cc: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Martin Reimann <martin.reimann-inJ12LbcDfezQB+pC5nmwQ@public.gmane.org>
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: Raashid Muhammed <raashidmuhammed-1MQmoylvZ5VBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Cc: Sergio Tanzilli <tanzilli-ryiEoTCBuMXrBCbmRaR9Nw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Tim Schendekehl <tim.schendekehl-inJ12LbcDfezQB+pC5nmwQ@public.gmane.org>

Alexandre Belloni (58):
  ARM: at91: Document new TCB bindings
  ARM: dts: at91: at91rm9200: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91rm9200ek: use TCB0 as clocksource
  ARM: dts: at91: mpa1600: use TCB0 as clocksource
  ARM: dts: at91: at91sam9260: TC blocks are also simple-mfd and syscon
    devices
  ARM: dts: at91: at91sam9260ek: use TCB0 as clocksource
  ARM: dts: at91: sam9_l9260: use TCB0 as clocksource
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
  ARM: dts: at91: sama5d3xek: use TCB0 as clocksource
  ARM: dts: at91: sama5d3 Xplained: use TCB0 as clocksource
  ARM: dts: at91: kizbox2: use TCB0 as clocksource
  ARM: dts: at91: sama5d3xek_cmp: use TCB0 as clocksource
  ARM: dts: at91: linea/tse850-3: use TCB0 as clocksource
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
  ARM: at91: add TCB registers definitions
  clocksource/drivers: Add a new driver for the Atmel ARM TC blocks
  clocksource/drivers: timer-atmel-tcbclksrc: add clockevent device
  clocksource/drivers: timer-atmel-tcbclksrc: add clockevent device on
    separate channel
  clocksource/drivers: atmel-pit: allow unselecting ATMEL_PIT
  ARM: at91/defconfig: sama5: unselect ATMEL_PIT
  ARM: at91/defconfig: at91_dt unselect ATMEL_PIT
  PWM: atmel-tcb: switch to new binding
  ARM: dts: at91: kizbox: switch to new pwm-atmel-tcb binding
  clocksource/drivers: remove tcb_clksrc
  misc: remove atmel_tclib.c
  ARM: configs: at91: remove ATMEL_TCLIB
  ARM: multi_v7_defconfig: Remove ATMEL_TCLIB Kconfig symbol
  ARM: multi_v5_defconfig: Remove ATMEL_TCLIB Kconfig symbol

 .../devicetree/bindings/arm/atmel-at91.txt         |  32 --
 .../devicetree/bindings/mfd/atmel-tcb.txt          |  58 +++
 .../devicetree/bindings/pwm/atmel-tcb-pwm.txt      |  12 +-
 arch/arm/boot/dts/animeo_ip.dts                    |  12 +
 arch/arm/boot/dts/at91-ariag25.dts                 |  12 +
 arch/arm/boot/dts/at91-ariettag25.dts              |  12 +
 arch/arm/boot/dts/at91-cosino.dtsi                 |  12 +
 arch/arm/boot/dts/at91-foxg20.dts                  |  12 +
 arch/arm/boot/dts/at91-kizbox.dts                  |  54 ++-
 arch/arm/boot/dts/at91-kizbox2.dts                 |  12 +
 arch/arm/boot/dts/at91-kizboxmini.dts              |  12 +
 arch/arm/boot/dts/at91-linea.dtsi                  |  12 +
 arch/arm/boot/dts/at91-qil_a9260.dts               |  12 +
 arch/arm/boot/dts/at91-sam9_l9260.dts              |  12 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  12 +
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  12 +
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi          |  12 +
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |  12 +
 arch/arm/boot/dts/at91-sama5d4ek.dts               |  12 +
 arch/arm/boot/dts/at91-vinco.dts                   |  12 +
 arch/arm/boot/dts/at91rm9200.dtsi                  |   8 +-
 arch/arm/boot/dts/at91rm9200ek.dts                 |  12 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |   8 +-
 arch/arm/boot/dts/at91sam9260ek.dts                |  12 +
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
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi              |  12 +
 arch/arm/boot/dts/sama5d4.dtsi                     |  18 +-
 arch/arm/boot/dts/tny_a9260_common.dtsi            |  12 +
 arch/arm/boot/dts/tny_a9263.dts                    |  12 +
 arch/arm/boot/dts/usb_a9260_common.dtsi            |  12 +
 arch/arm/boot/dts/usb_a9263.dts                    |  12 +
 arch/arm/configs/at91_dt_defconfig                 |   2 +-
 arch/arm/configs/multi_v5_defconfig                |   1 -
 arch/arm/configs/multi_v7_defconfig                |   1 -
 arch/arm/configs/sama5_defconfig                   |   2 +-
 drivers/clocksource/Kconfig                        |  22 +-
 drivers/clocksource/Makefile                       |   2 +-
 drivers/clocksource/tcb_clksrc.c                   | 381 ----------------
 drivers/clocksource/timer-atmel-tcbclksrc.c        | 502 +++++++++++++++++++++
 drivers/misc/Kconfig                               |  33 --
 drivers/misc/Makefile                              |   1 -
 drivers/misc/atmel_tclib.c                         | 198 --------
 drivers/pwm/Kconfig                                |   3 +-
 drivers/pwm/pwm-atmel-tcb.c                        | 221 ++++-----
 include/linux/atmel_tc.h                           |   9 -
 include/soc/at91/atmel_tcb.h                       | 229 ++++++++++
 66 files changed, 1468 insertions(+), 801 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
 delete mode 100644 drivers/clocksource/tcb_clksrc.c
 create mode 100644 drivers/clocksource/timer-atmel-tcbclksrc.c
 delete mode 100644 drivers/misc/atmel_tclib.c
 create mode 100644 include/soc/at91/atmel_tcb.h

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
