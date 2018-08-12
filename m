From: Sam Ravnborg <sam@ravnborg.org>
Subject: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
Date: Sun, 12 Aug 2018 20:41:52 +0200
Message-ID: <20180812184152.GA22343@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

New DRM based driver for at91sam9 SOC's that uses the
Atmel LCDC IP core.

This is first version of a patch set that adds
drivers for the Atmel LCDC IP core.
Posted for review as the basics works now.

The LCDC IP core contains two devices:
- a PWM often used for backlight
- a LCD display controller

Both devices are supported today by the atmel_lcdfb driver.
For this new set of drivers the compatible strings was
selected to avoid clash with the existing compatible
strings used for the atmel_lcdfb driver to allow them
to co-exist.

This patchset implements three drivers.
- A MFD driver that include the generic parts.
- A PWM driver.
- A DRM display controller driver.
This is the same split as used for the Atmel hlcdc IP.

The hlcdc and lcdc has only a few things in common and
trying to share the code for them was not a viable solution.

The DRM implementation has a few shortcomings compared to the
existing fbdev based driver:
    - STN displays are not supported
            Binding support is missing but most of the
            STN specific functionality is otherwise ported
            from the fbdev driver.
            I assume the info should come from the panel
            but as I lack HW I have not looked too much
            into what is required.
    - gamma support is missing
            The driver utilises drm_simple_kms_helper and
            this helper lacks support for setting up gamma.
            If this is useful please let me know and I
            will extend drm_simple_kms_helper to support this
            and update the driver.
    - modesetting is not checked (see TODO in file)
            Is this required for such a simple setup?
    - support for extra modes as applicable (and lcd-wiring-mode)
    - support for AVR32 (is it relevant?)

The first patch renames .../drm/atmel-hlcdc to .../drm/atmel
to have a nice home for both drivers.

The drivers _works_ on a proprietary at91sam9263 based board
and I will eventually migrate the at91sam9263ek over
to use it as well.

Works is maybe a stretch - the following was tested:
  modetest shows reasonable output
  modetest -s shows some nice colored squares
  vbltest shows 45.70 Hz (after terminating modetest -s with SIGINT)
  drmdevice shows reasonable output
  brightness can be controlled

Anything else that can be recommended for some basic tests?
How to test suspend/resume?

REVIEW
Please give feedback on general structure/architecture
Please check if the drm framework is used in the optimal way
And then the usual review from spelling errors, names, style etc.

All feedback (from spelling errors to general structure) appreciated!

	Sam

Sam Ravnborg (7):
      atmel-hlcdc: renamed directory to drm/atmel/
      dt-binding: add bindings for Atmel LCDC mfd
      mfd: add atmel-lcdc driver
      dt-bindings: add bindings for Atmel LCDC pwm
      pwm: add pwm-atmel-lcdc driver
      dt-bindings: add bindings for Atmel lcdc-display-controller
      drm: add Atmel LCDC display controller support

 .../display/atmel/lcdc-display-controller.txt      |   40 +
 .../devicetree/bindings/mfd/atmel-lcdc.txt         |   75 ++
 .../devicetree/bindings/pwm/atmel-lcdc-pwm.txt     |   30 +
 MAINTAINERS                                        |    9 +-
 drivers/gpu/drm/Kconfig                            |    2 +-
 drivers/gpu/drm/Makefile                           |    2 +-
 drivers/gpu/drm/atmel-hlcdc/Kconfig                |   10 -
 drivers/gpu/drm/atmel/Kconfig                      |   28 +
 drivers/gpu/drm/{atmel-hlcdc => atmel}/Makefile    |    2 +
 .../drm/{atmel-hlcdc => atmel}/atmel_hlcdc_crtc.c  |    0
 .../drm/{atmel-hlcdc => atmel}/atmel_hlcdc_dc.c    |    0
 .../drm/{atmel-hlcdc => atmel}/atmel_hlcdc_dc.h    |    0
 .../{atmel-hlcdc => atmel}/atmel_hlcdc_output.c    |    0
 .../drm/{atmel-hlcdc => atmel}/atmel_hlcdc_plane.c |    0
 drivers/gpu/drm/atmel/atmel_lcdc-dc.c              | 1094 ++++++++++++++++++++
 drivers/mfd/Kconfig                                |   10 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/atmel-lcdc.c                           |  158 +++
 drivers/pwm/Kconfig                                |   13 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-atmel-lcdc.c                       |  178 ++++
 include/linux/mfd/atmel-lcdc.h                     |  184 ++++
 22 files changed, 1824 insertions(+), 13 deletions(-)
