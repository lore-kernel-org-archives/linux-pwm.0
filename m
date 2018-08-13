From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
Date: Mon, 13 Aug 2018 17:54:48 +0200
Message-ID: <f1f2a2d7-ae27-87af-8041-93d3f8fe07cc@microchip.com>
References: <20180812184152.GA22343@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180812184152.GA22343@ravnborg.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, Joshua Henderson <joshua.henderson@microchip.com>, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 12/08/2018 at 20:41, Sam Ravnborg wrote:
> New DRM based driver for at91sam9 SOC's that uses the
> Atmel LCDC IP core.

I'm delighted to see this work: Thanks a lot Sam!

> This is first version of a patch set that adds
> drivers for the Atmel LCDC IP core.
> Posted for review as the basics works now.
> 
> The LCDC IP core contains two devices:
> - a PWM often used for backlight
> - a LCD display controller
> 
> Both devices are supported today by the atmel_lcdfb driver.
> For this new set of drivers the compatible strings was
> selected to avoid clash with the existing compatible
> strings used for the atmel_lcdfb driver to allow them
> to co-exist.

Would be good to have a plan to phase-out the old atmel_lcdfb fbdev 
driver when this one addresses some TODO items that make sense.

The mfd suffix seems strange to me. What about "atmel,at91sam9263-lcdc-mfd"
=> "atmel,at91sam9263-lcd" (or "microchip,at91sam9263-lcdc").

> This patchset implements three drivers.
> - A MFD driver that include the generic parts.
> - A PWM driver.
> - A DRM display controller driver.
> This is the same split as used for the Atmel hlcdc IP.

Good, this is why I would use the same type of compatibility string for 
the split mfd/pwm/lcd (just without the "h").

> The hlcdc and lcdc has only a few things in common and
> trying to share the code for them was not a viable solution.

Yes, I agree.

> The DRM implementation has a few shortcomings compared to the
> existing fbdev based driver:
>      - STN displays are not supported
>              Binding support is missing but most of the
>              STN specific functionality is otherwise ported
>              from the fbdev driver.
>              I assume the info should come from the panel
>              but as I lack HW I have not looked too much
>              into what is required.

Yes, I'm not even sure if STN displays are still available those days... 
Might not be worth it spending time on this.

>      - gamma support is missing
>              The driver utilises drm_simple_kms_helper and
>              this helper lacks support for setting up gamma.
>              If this is useful please let me know and I
>              will extend drm_simple_kms_helper to support this
>              and update the driver.
>      - modesetting is not checked (see TODO in file)
>              Is this required for such a simple setup?
>      - support for extra modes as applicable (and lcd-wiring-mode)
>      - support for AVR32 (is it relevant?)

No, AVR32 is not relevant anymore as the core and SoC were removed some 
years ago from Linux.
All mention of AT32 or AVR32 can be remove then.

> The first patch renames .../drm/atmel-hlcdc to .../drm/atmel
> to have a nice home for both drivers.
> 
> The drivers _works_ on a proprietary at91sam9263 based board
> and I will eventually migrate the at91sam9263ek over
> to use it as well.

We'll be able to test it on other SoCs and boards.

> Works is maybe a stretch - the following was tested:
>    modetest shows reasonable output
>    modetest -s shows some nice colored squares

You must see something like this (without the overlay additional black 
square):
http://www.at91.com/linux4sam/bin/view/Linux4SAM/UsingAtmelDRMDriver#Some_modetest_commands

>    vbltest shows 45.70 Hz (after terminating modetest -s with SIGINT)
>    drmdevice shows reasonable output
>    brightness can be controlled
> 
> Anything else that can be recommended for some basic tests?
> How to test suspend/resume?
> 
> REVIEW
> Please give feedback on general structure/architecture
> Please check if the drm framework is used in the optimal way
> And then the usual review from spelling errors, names, style etc.
> 
> All feedback (from spelling errors to general structure) appreciated!

On my side, it's mostly Nitpicking ;-)
Now that we're Microchip for a little bit more than 2 years, I tend to 
make this name prevalent compared to Atmel for new work around our 
products... But I know this driver is for older SoCs and that it got 
inspired by two former drivers that have this "atmel" naming everywhere. 
MAINTAINERS and Kconfig changes could include Microchip name, so that 
it's obvious for the newcomers...

> 	Sam
> 
> Sam Ravnborg (7):
>        atmel-hlcdc: renamed directory to drm/atmel/
>        dt-binding: add bindings for Atmel LCDC mfd
>        mfd: add atmel-lcdc driver
>        dt-bindings: add bindings for Atmel LCDC pwm
>        pwm: add pwm-atmel-lcdc driver
>        dt-bindings: add bindings for Atmel lcdc-display-controller
>        drm: add Atmel LCDC display controller support
> 
>   .../display/atmel/lcdc-display-controller.txt      |   40 +
>   .../devicetree/bindings/mfd/atmel-lcdc.txt         |   75 ++
>   .../devicetree/bindings/pwm/atmel-lcdc-pwm.txt     |   30 +
>   MAINTAINERS                                        |    9 +-
>   drivers/gpu/drm/Kconfig                            |    2 +-
>   drivers/gpu/drm/Makefile                           |    2 +-
>   drivers/gpu/drm/atmel-hlcdc/Kconfig                |   10 -
>   drivers/gpu/drm/atmel/Kconfig                      |   28 +
>   drivers/gpu/drm/{atmel-hlcdc => atmel}/Makefile    |    2 +
>   .../drm/{atmel-hlcdc => atmel}/atmel_hlcdc_crtc.c  |    0
>   .../drm/{atmel-hlcdc => atmel}/atmel_hlcdc_dc.c    |    0
>   .../drm/{atmel-hlcdc => atmel}/atmel_hlcdc_dc.h    |    0
>   .../{atmel-hlcdc => atmel}/atmel_hlcdc_output.c    |    0
>   .../drm/{atmel-hlcdc => atmel}/atmel_hlcdc_plane.c |    0
>   drivers/gpu/drm/atmel/atmel_lcdc-dc.c              | 1094 ++++++++++++++++++++
>   drivers/mfd/Kconfig                                |   10 +
>   drivers/mfd/Makefile                               |    1 +
>   drivers/mfd/atmel-lcdc.c                           |  158 +++
>   drivers/pwm/Kconfig                                |   13 +
>   drivers/pwm/Makefile                               |    1 +
>   drivers/pwm/pwm-atmel-lcdc.c                       |  178 ++++
>   include/linux/mfd/atmel-lcdc.h                     |  184 ++++
>   22 files changed, 1824 insertions(+), 13 deletions(-)
> 


-- 
Nicolas Ferre
