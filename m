From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: [RESEND PATCH v3 00/11] drm: add support for Atmel HLCDC Display Controller
Date: Mon,  7 Jul 2014 18:42:53 +0200
Message-ID: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:58897 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751112AbaGGQnK (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jul 2014 12:43:10 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>
Cc: Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Boris BREZILLON <boris.brezillon@free-electrons.com>

Hello,

Sorry for the noise, but I forgot to add the LAKML in Cc.

This patch series adds support for Atmel HLCDC (HLCD Controller) available
on some Atmel SoCs (i.e. the sama5d3 family).

The first two versions of this series didn't receive any reviews from DRM
maintainers or experienced DRM developers.
Anyway, I hope I'll get some feedback on this version.

The HLCDC actually provides a Display Controller and a PWM device, hence I
decided to declare an MFD device exposing 2 subdevices: a display
controller and a PWM chip.
This also solves a circular dependency issue preventing HLCDC driver from
unloading.
The HLCDC request a drm_panel device, which request a backlight device
(a PWM backlight), which depends on a PWM which is provided by the HLCDC
driver (hlcdc -> panel -> backlight -> hlcdc (pwm part)).

The current implementation only supports sama5d3 SoCs but other SoCs should
be easily ported by defining new compatible strings and adding HLCDC
description structures for these SoCs.

The drivers supports basic CRTC functionalities, several overlays and an
hardware cursor.

At the moment, it only supports connection to LCD panels through an RGB
connector (defined as an LVDS connector in my implementation), though
connection to other kind of devices (like DRM bridges) can be added later.

It also supports several RGB format on all planes and some YUV formats on
the HEO overlay plane.

Best Regards,

Boris

Changes since v2:
- fix coding style issues (macro indentation)
- make use of GENMASK in several places
- declare regmap config as a static structure
- rework hlcdc plane update API
- rework cursor handling to make use of the new plane update API
- fix backporch config
- do not use devm_regmap_init_mmio_clk to avoid extra clk_enable
  clk disable calls when accessing registers
- explicitely include regmap and clk headers instead of relying on
  atmel-hlcdc.h inclusions
- make the atmel-hlcdc driver depends on CONFIG_OF
- separate DT bindings documentation from driver implementation
- support several pin muxing for HLCDC pins on sama5d3 SoCs

Changes since v1:
- replace the backlight driver by a PWM driver
- make use of drm_panel infrastructure
- split driver code in several subsystem: MFD, PWM and DRM
- add support for overlays
- add support for hardware cursor


Boris BREZILLON (11):
  mfd: add atmel-hlcdc driver
  mfd: add documentation for atmel-hlcdc DT bindings
  pwm: add support for atmel-hlcdc-pwm device
  pwm: add DT bindings documentation for atmel-hlcdc-pwm driver
  drm: add Atmel HLCDC Display Controller support
  drm: add DT bindings documentation for atmel-hlcdc-dc driver
  ARM: AT91/dt: split sama5d3 lcd pin definitions to match RGB mode
    configs
  ARM: AT91/dt: add alternative pin muxing for sama5d3 lcd pins
  ARM: at91/dt: define the HLCDC node available on sama5d3 SoCs
  ARM: at91/dt: add LCD panel description to sama5d3xdm.dtsi
  ARM: at91/dt: enable the LCD panel on sama5d3xek boards

 .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     |  59 ++
 .../devicetree/bindings/mfd/atmel-hlcdc.txt        |  40 ++
 .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    |  46 ++
 arch/arm/boot/dts/sama5d31ek.dts                   |  24 +
 arch/arm/boot/dts/sama5d33ek.dts                   |  24 +
 arch/arm/boot/dts/sama5d34ek.dts                   |  24 +
 arch/arm/boot/dts/sama5d36ek.dts                   |  24 +
 arch/arm/boot/dts/sama5d3_lcd.dtsi                 | 197 +++++-
 arch/arm/boot/dts/sama5d3xdm.dtsi                  |  43 ++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/atmel-hlcdc/Kconfig                |  11 +
 drivers/gpu/drm/atmel-hlcdc/Makefile               |   7 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 469 +++++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       | 474 ++++++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       | 210 ++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c    | 706 ++++++++++++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h    | 422 ++++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_panel.c    | 351 ++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    | 729 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/atmel-hlcdc.c                          | 119 ++++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-atmel-hlcdc.c                      | 229 +++++++
 include/linux/mfd/atmel-hlcdc.h                    |  78 +++
 27 files changed, 4281 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/Kconfig
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/Makefile
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_panel.c
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
 create mode 100644 drivers/mfd/atmel-hlcdc.c
 create mode 100644 drivers/pwm/pwm-atmel-hlcdc.c
 create mode 100644 include/linux/mfd/atmel-hlcdc.h

-- 
1.8.3.2

