From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH v2 00/16] extend PWM framework to support PWM modes
Date: Fri, 12 Jan 2018 16:22:47 +0200
Message-ID: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi all,

Please give feedback on these patches which extends the PWM framework in order
to support multiple PWM modes of operations. This series is a rework of [1].

The current patch series add the following PWM modes:
- PWM mode normal
- PWM mode complementary
- PWM mode push-pull

Normal mode - for PWM chips with one output per PWM channel; output
waveforms looks like this:
             __    __    __    __
    PWM   __|  |__|  |__|  |__|  |__
            <--T-->

Complementary mode - for PWM chips with more than one output per PWM
channel; output waveforms for a PWM controller with 2 outputs per PWM
channel may looks line this:
             __    __    __    __
    PWMH1 __|  |__|  |__|  |__|  |__
          __    __    __    __    __
    PWML1   |__|  |__|  |__|  |__|
            <--T-->

    Where T is the signal period.

Push-pull mode - for PWM chips with mode than one output per PWM channel;
output waveform for a PWM controller with 2 outputs per PWM channel, in
push-pull mode, with normal polarity looks like this:
            __          __
    PWMH __|  |________|  |________
                  __          __
    PWML ________|  |________|  |__
           <--T-->

    If polarity is inversed:
         __    ________    ________
    PWMH   |__|        |__|
         ________    ________    __
    PWML         |__|        |__|
           <--T-->

    Where T is the signal period.

Every PWM device from a PWM chip could be configured in the modes registered
by PWM chip. For this, the PWM chip structure contains a field called caps which
keeps the PWM modes. At probe time the PWM chip registers the supported modes
and PWM devices could switch to the modes registered by PWM chips. For the moment,
in my opinion, it is not neccessary to add a new hook in pwm_ops to go through
the driver to check the capabilities of a single PWM device (as was proposed
in [1]).

I choosed to consider that a PWM controller with 2 outputs to also be capable to
work in normal mode, since the outputs could be connected independently to other
devices.

If the drivers doesn't register any PWM capabilities the default capabilities
will be used (currently, these includes PWM mode normal). 
 
These PWM mode could be configured via sysfs, or pwm_set_mode() +
pwm_apply_state() (for driver clients), or via DT.

In sysfs, user could check the PWM controller capabilities by reading modes file
of PWM chip:
root@sama5d2-xplained:/sys/class/pwm/pwmchip0# ls -l
total 0
lrwxrwxrwx 1 root root    0 Oct  7 03:18 device -> ../../../f802c000.pwm
--w------- 1 root root 4096 Oct  7 03:18 export
-r--r--r-- 1 root root 4096 Oct  7 03:18 modes
-r--r--r-- 1 root root 4096 Oct  7 03:18 npwm
drwxr-xr-x 2 root root    0 Oct  7 03:18 power
lrwxrwxrwx 1 root root    0 Oct  7 03:18 subsystem -> ../../../../../../../class/pwm
-rw-r--r-- 1 root root 4096 Oct  7 01:20 uevent
--w------- 1 root root 4096 Oct  7 03:18 unexport
root@sama5d2-xplained:/sys/class/pwm/pwmchip0# cat modes
normal complementary push-pull 

And the current capability of the PWM device could be checked as follows:
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm1# ls -l
-r--r--r--    1 root     root          4096 Feb  9 10:54 capture
-rw-r--r--    1 root     root          4096 Feb  9 10:54 duty_cycle
-rw-r--r--    1 root     root          4096 Feb  9 10:54 enable
-rw-r--r--    1 root     root          4096 Feb  9 10:54 mode
-rw-r--r--    1 root     root          4096 Feb  9 10:54 period
-rw-r--r--    1 root     root          4096 Feb  9 10:55 polarity
drwxr-xr-x    2 root     root             0 Feb  9 10:54 power
-rw-r--r--    1 root     root          4096 Feb  9 10:54 uevent

root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm1# cat mode
normal

The PWM push-pull mode could be usefull in applications like
half bridge converters.

This series also add support for PWM modes on atmel SAMA5D2 SoC.

Thank you,
Claudiu Beznea

[1] https://www.spinics.net/lists/arm-kernel/msg580275.html

Changes in v2:
- remove of_xlate and of_pwm_n_cells and use generic functions to pharse DT
  inputs; this is done in patches 1, 2, 3, 4, 5, 6, 7 of this series; this will
  make easy the addition of PWM mode support from DT
- add PWM mode normal
- register PWM modes as capabilities of PWM chips at driver probe and, in case
  driver doesn't provide these capabilities use default ones
- change the way PWM mode is pharsed via DT by using a new input for pwms
  binding property

Claudiu Beznea (16):
  drivers: pwm: core: use a single of xlate function
  pwm: pxa: update documentation regarding pwm-cells
  pwm: cros-ec: update documentation regarding pwm-cells
  pwm: clps711x: update documentation regarding pwm-cells
  ARM: dts: clps711x: update pwm-cells
  ARM: dts: pxa: update pwm-cells
  arm64: dts: rockchip: update pwm-cells
  drivers: pwm: core: extend PWM framework with PWM modes
  drivers: pwm: core: add PWM mode to pwm_config()
  pwm: Add PWM modes
  pwm: add documentation for PWM modes
  pwm: atmel: add pwm capabilities
  drivers: pwm: core: add push-pull mode support
  pwm: add push-pull mode
  pwm: add documentation for pwm push-pull mode
  pwm: atmel: add push-pull mode support

 .../bindings/pwm/cirrus,clps711x-pwm.txt           |   4 +-
 .../devicetree/bindings/pwm/google,cros-ec-pwm.txt |   4 +-
 Documentation/devicetree/bindings/pwm/pwm.txt      |  23 ++++-
 Documentation/devicetree/bindings/pwm/pxa-pwm.txt  |   6 +-
 Documentation/pwm.txt                              |  47 ++++++++-
 arch/arm/boot/dts/ep7209.dtsi                      |   2 +-
 arch/arm/boot/dts/pxa25x.dtsi                      |   4 +-
 arch/arm/boot/dts/pxa27x.dtsi                      |   8 +-
 arch/arm/boot/dts/pxa3xx.dtsi                      |   8 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |   5 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   2 +-
 drivers/bus/ts-nbus.c                              |   2 +-
 drivers/clk/clk-pwm.c                              |   3 +-
 drivers/gpu/drm/i915/intel_panel.c                 |   8 +-
 drivers/hwmon/pwm-fan.c                            |   2 +-
 drivers/input/misc/max77693-haptic.c               |   2 +-
 drivers/input/misc/max8997_haptic.c                |   3 +-
 drivers/leds/leds-pwm.c                            |   2 +-
 drivers/media/rc/ir-rx51.c                         |   2 +-
 drivers/media/rc/pwm-ir-tx.c                       |   2 +-
 drivers/pwm/core.c                                 | 112 ++++++++++++++-------
 drivers/pwm/pwm-atmel-hlcdc.c                      |   2 -
 drivers/pwm/pwm-atmel-tcb.c                        |   2 -
 drivers/pwm/pwm-atmel.c                            | 100 ++++++++++++------
 drivers/pwm/pwm-bcm-iproc.c                        |   2 -
 drivers/pwm/pwm-bcm-kona.c                         |   2 -
 drivers/pwm/pwm-bcm2835.c                          |   2 -
 drivers/pwm/pwm-berlin.c                           |   2 -
 drivers/pwm/pwm-clps711x.c                         |  11 --
 drivers/pwm/pwm-cros-ec.c                          |  20 ----
 drivers/pwm/pwm-fsl-ftm.c                          |   2 -
 drivers/pwm/pwm-hibvt.c                            |   2 -
 drivers/pwm/pwm-imx.c                              |   8 --
 drivers/pwm/pwm-lpc18xx-sct.c                      |   2 -
 drivers/pwm/pwm-meson.c                            |   2 -
 drivers/pwm/pwm-omap-dmtimer.c                     |   2 -
 drivers/pwm/pwm-pxa.c                              |  19 ----
 drivers/pwm/pwm-renesas-tpu.c                      |   2 -
 drivers/pwm/pwm-rockchip.c                         |   5 -
 drivers/pwm/pwm-samsung.c                          |   3 -
 drivers/pwm/pwm-sun4i.c                            |   2 -
 drivers/pwm/pwm-tiecap.c                           |   2 -
 drivers/pwm/pwm-tiehrpwm.c                         |   2 -
 drivers/pwm/pwm-vt8500.c                           |   2 -
 drivers/pwm/pwm-zx.c                               |   2 -
 drivers/pwm/sysfs.c                                |  64 ++++++++++++
 drivers/video/backlight/lm3630a_bl.c               |   2 +-
 drivers/video/backlight/lp855x_bl.c                |   2 +-
 drivers/video/backlight/lp8788_bl.c                |   2 +-
 drivers/video/backlight/pwm_bl.c                   |   4 +-
 drivers/video/fbdev/ssd1307fb.c                    |   3 +-
 include/dt-bindings/pwm/pwm.h                      |   4 +
 include/linux/pwm.h                                |  90 +++++++++++++++--
 54 files changed, 402 insertions(+), 222 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
