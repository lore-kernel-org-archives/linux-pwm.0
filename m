Return-Path: <>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH RFC 0/7] treewide: modify sh-pfc and add support pwm duty zero
Date: Mon,  8 Jul 2019 18:07:41 +0900
Message-Id: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linus.walleij@linaro.org, geert+renesas@glider.be, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch series modifies pinctrl/sh-pfc and pwm drivers. Since the R-Car
SoCs PWM Timer cannot output duty zero, the Salvator-X[S] board cannot
output max_brightness. This patch series can support it.

I'm not sure whether pinctrl subsystem and sh-pfc driver allows
to change the pin configuration automatically by .gpio_disable_free(),
so that I marked "RFC" on this patch series.

< log file >
 # cd /sys/class/backlight/backlight
 # echo 1 > brightness
 # cat /sys/kernel/debug/pinctrl/e60060000.pin-controller-sh-pfc/pinmux-pins |\
   grep -w 71
 pin 71 (GP_2_7): e6e31000.pwm (GPIO UNCLAIMED) function pwm1 group pwm1_a

 # echo 6 > brightness
 # cat /sys/kernel/debug/pinctrl/e60060000.pin-controller-sh-pfc/pinmux-pins |\
   grep -w 71
 pin 71 (GP_2_7): e6e31000.pwm e6052000.gpio:459 function pwm1 group pwm1_a

 # echo 1 > brightness
 # cat /sys/kernel/debug/pinctrl/e60060000.pin-controller-sh-pfc/pinmux-pins |\
   grep -w 71
 pin 71 (GP_2_7): e6e31000.pwm (GPIO UNCLAIMED) function pwm1 group pwm1_a


Yoshihiro Shimoda (7):
  pinctrl: sh-pfc: add new flags into struct sh_pfc_pin_config
  pinctrl: sh-pfc: remove incomplete flag "cfg->type"
  pinctrl: sh-pfc: Rollback to mux if requires when the gpio is freed
  dt-bindings: pwm: rcar: Add specific gpios property to output duty
    zero
  pwm: rcar: remove a redundant condition in rcar_pwm_apply()
  pwm: rcar: Add gpio support to output duty zero
  arm64: dts: renesas: salvator-common: add gpio property into pwm1

 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |  3 ++
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |  1 +
 drivers/pinctrl/sh-pfc/pinctrl.c                   | 44 +++++++++++-----------
 drivers/pwm/pwm-rcar.c                             | 36 +++++++++++++++++-
 4 files changed, 60 insertions(+), 24 deletions(-)

-- 
2.7.4
