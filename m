From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v5 00/11] drm: add support for Atmel HLCDC Display
 Controller
Date: Thu, 25 Sep 2014 20:02:06 -0400
Message-ID: <CAF6AEGsBp84LRLHUY=6_AFs5d4pyfNnjfRGMy+8g_QAfxVqT+A@mail.gmail.com>
References: <1410165822-16868-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1410165822-16868-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Andrew Victor <linux@maxim.org.za>
List-Id: linux-pwm@vger.kernel.org

On Mon, Sep 8, 2014 at 4:43 AM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:
> Hello,
>
> This patch series adds support for Atmel HLCDC (HLCD Controller) available
> on some Atmel SoCs (i.e. the sama5d3 family).
>
> The HLCDC actually provides a Display Controller and a PWM device, hence I
> decided to declare an MFD device exposing 2 subdevices: a display
> controller and a PWM chip.
> This also solves a circular dependency issue preventing HLCDC driver from
> unloading.
> The HLCDC request a drm_panel device, which request a backlight device
> (a PWM backlight), which depends on a PWM which is provided by the HLCDC
> driver (hlcdc -> panel -> backlight -> hlcdc (pwm part)).
>
> The current implementation only supports sama5d3 SoCs but other SoCs should
> be easily ported by defining new compatible strings and adding HLCDC
> description structures for these SoCs (Ludovic tested this driver on an
> at91sam9x5 board).
>
> The drivers supports basic CRTC functionalities, several overlays and an
> hardware cursor.
>
> At the moment, it only supports connection to LCD panels through an RGB
> connector (defined as an LVDS connector in my implementation), though
> connection to other kind of devices (like DRM bridges) could be added later.
>
> It also supports several RGB formats on all planes and some YUV formats on
> the HEO overlay plane.
>
> This series depends those series: [1] and [2].
>
> I know you're all quite busy, but I was expecting to get support for
> atmel's HLCDC block in 3.18, and given the lack of review I got on the
> DRM and PWM parts I doubt it can happen :-(.
>
> Moreover, the dependencies ([1] and [2]) are stuck too.
> The first one has been reviewed by Rob, but didn't get any feedback after
> that. David, Rob, is there anything blocking this series ?
> The second patch series contains some rework I've done to describe the
> transfer format used on a connector bus. Laurent, Thierry, you're the one
> who suggested this rework. Could you give your opinion on my
> implementation ?


hmm, looks like I still owe you a review after conversion to flip-work
helpers..  Sorry, I thought I'd already reviewed one of the later
versions.  It is on my list for tomorrow.

Definitely we should get the flip-work helper patches landed, that
part already has my r-b

BR,
-R

> Best Regards,
>
> Boris
>
> [1]http://lkml.iu.edu/hypermail/linux/kernel/1407.1/04171.html
> [2]http://www.spinics.net/lists/kernel/msg1791681.html
>
> Changes since v4:
> - fix a few more bugs in rotation handling (rotation was buggy on some
>   formats)
> - return connector_status_unknown until a panel is exposed by the
>   drm_panel infrastructure (prevent fbdev creation until everyting is
>   in place)
> - rework Kconfig MFD_ATMEL_HLCDC selection to simplify the configuration
>   (automatically select this option when selecting the HLCDC PMW or DRM
>   driver, instead of depending on this option)
>
> Changes since v3:
> - rework the layer code to simplify several parts (locking and layer
>   disabling)
> - make use of the drm_flip_work infrastructure
> - rely on default HW cursor implementation using on the cursor plane
> - rework the display controller DT bindings (based on OF graph
>   representation)
> - add rotation support
> - retrive RGB bus format from drm_display_info
> - drop the dynamic pinctrl state selection
> - rework HLCDC output handling (previously specialized to interface
>   with LCD panels)
> - drop ".module = THIS_MODULE" lines
> - change display controller compatible string
>
> Changes since v2:
> - fix coding style issues (macro indentation)
> - make use of GENMASK in several places
> - declare regmap config as a static structure
> - rework hlcdc plane update API
> - rework cursor handling to make use of the new plane update API
> - fix backporch config
> - do not use devm_regmap_init_mmio_clk to avoid extra clk_enable
>   clk disable calls when accessing registers
> - explicitely include regmap and clk headers instead of relying on
>   atmel-hlcdc.h inclusions
> - make the atmel-hlcdc driver depends on CONFIG_OF
> - separate DT bindings documentation from driver implementation
> - support several pin muxing for HLCDC pins on sama5d3 SoCs
>
> Changes since v1:
> - replace the backlight driver by a PWM driver
> - make use of drm_panel infrastructure
> - split driver code in several subsystem: MFD, PWM and DRM
> - add support for overlays
> - add support for hardware cursor
>
> Boris BREZILLON (11):
>   mfd: add atmel-hlcdc driver
>   mfd: add documentation for atmel-hlcdc DT bindings
>   pwm: add support for atmel-hlcdc-pwm device
>   pwm: add DT bindings documentation for atmel-hlcdc-pwm driver
>   drm: add Atmel HLCDC Display Controller support
>   drm: add DT bindings documentation for atmel-hlcdc-dc driver
>   ARM: AT91/dt: split sama5d3 lcd pin definitions to match RGB mode
>     configs
>   ARM: AT91/dt: add alternative pin muxing for sama5d3 lcd pins
>   ARM: at91/dt: define the HLCDC node available on sama5d3 SoCs
>   ARM: at91/dt: add LCD panel description to sama5d3xdm.dtsi
>   ARM: at91/dt: enable the LCD panel on sama5d3xek boards
>
>  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     |  54 ++
>  .../devicetree/bindings/mfd/atmel-hlcdc.txt        |  50 ++
>  .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    |  55 ++
>  arch/arm/boot/dts/sama5d31ek.dts                   |  20 +
>  arch/arm/boot/dts/sama5d33ek.dts                   |  20 +
>  arch/arm/boot/dts/sama5d34ek.dts                   |  20 +
>  arch/arm/boot/dts/sama5d36ek.dts                   |  20 +
>  arch/arm/boot/dts/sama5d3_lcd.dtsi                 | 205 ++++-
>  arch/arm/boot/dts/sama5d3xdm.dtsi                  |  58 ++
>  drivers/gpu/drm/Kconfig                            |   2 +
>  drivers/gpu/drm/Makefile                           |   1 +
>  drivers/gpu/drm/atmel-hlcdc/Kconfig                |  13 +
>  drivers/gpu/drm/atmel-hlcdc/Makefile               |   7 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 286 +++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       | 488 ++++++++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       | 224 ++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c    | 656 ++++++++++++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h    | 403 ++++++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 476 ++++++++++++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    | 836 +++++++++++++++++++++
>  drivers/mfd/Kconfig                                |   6 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/atmel-hlcdc.c                          | 118 +++
>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-atmel-hlcdc.c                      | 229 ++++++
>  include/linux/mfd/atmel-hlcdc.h                    |  78 ++
>  27 files changed, 4306 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/Kconfig
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/Makefile
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>  create mode 100644 drivers/mfd/atmel-hlcdc.c
>  create mode 100644 drivers/pwm/pwm-atmel-hlcdc.c
>  create mode 100644 include/linux/mfd/atmel-hlcdc.h
