From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
Date: Mon, 13 Aug 2018 20:18:08 +0200
Message-ID: <20180813181808.GA2357@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <f1f2a2d7-ae27-87af-8041-93d3f8fe07cc@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f1f2a2d7-ae27-87af-8041-93d3f8fe07cc@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org, Joshua Henderson <joshua.henderson@microchip.com>, dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Nicholas.

On Mon, Aug 13, 2018 at 05:54:48PM +0200, Nicolas Ferre wrote:
> On 12/08/2018 at 20:41, Sam Ravnborg wrote:
> >New DRM based driver for at91sam9 SOC's that uses the
> >Atmel LCDC IP core.
> 
> I'm delighted to see this work: Thanks a lot Sam!
Glad to hear.
I was a bit worried that the response would be "this is
waste of time as we have a working driver already".

> 
> >This is first version of a patch set that adds
> >drivers for the Atmel LCDC IP core.
> >Posted for review as the basics works now.
> >
> >The LCDC IP core contains two devices:
> >- a PWM often used for backlight
> >- a LCD display controller
> >
> >Both devices are supported today by the atmel_lcdfb driver.
> >For this new set of drivers the compatible strings was
> >selected to avoid clash with the existing compatible
> >strings used for the atmel_lcdfb driver to allow them
> >to co-exist.
> 
> Would be good to have a plan to phase-out the old atmel_lcdfb fbdev
> driver when this one addresses some TODO items that make sense.
Agree on this.
One approach could be to say that when all in-kernel users of atmel_lcdfb
are ported, then the old driver could be dropped after a kernel release.

> The mfd suffix seems strange to me. What about "atmel,at91sam9263-lcdc-mfd"
> => "atmel,at91sam9263-lcd" (or "microchip,at91sam9263-lcdc").
The "-mfd" suffix was added to avoid clashing with the current
compatible string used by the atmel_lcdfb driver.

I susggest we do the following:
- use the microchip prefix, as this is now owned by microchip
- and add the driver to a drm/microchip/ directory
(Then we can only hope that microchip do not change name or
are purchased by someone else).

> 
> >The DRM implementation has a few shortcomings compared to the
> >existing fbdev based driver:
> >     - STN displays are not supported
> >             Binding support is missing but most of the
> >             STN specific functionality is otherwise ported
> >             from the fbdev driver.
> >             I assume the info should come from the panel
> >             but as I lack HW I have not looked too much
> >             into what is required.
> 
> Yes, I'm not even sure if STN displays are still available those
> days... Might not be worth it spending time on this.
Then I will delete all the STN bits that was ported over.
If we need them later they can be found on the mailign list.

> 
> >     - gamma support is missing
> >             The driver utilises drm_simple_kms_helper and
> >             this helper lacks support for setting up gamma.
> >             If this is useful please let me know and I
> >             will extend drm_simple_kms_helper to support this
> >             and update the driver.
> >     - modesetting is not checked (see TODO in file)
> >             Is this required for such a simple setup?
> >     - support for extra modes as applicable (and lcd-wiring-mode)
> >     - support for AVR32 (is it relevant?)
> 
> No, AVR32 is not relevant anymore as the core and SoC were removed
> some years ago from Linux.
> All mention of AT32 or AVR32 can be remove then.
Ok, I will delete these.

> >The drivers _works_ on a proprietary at91sam9263 based board
> >and I will eventually migrate the at91sam9263ek over
> >to use it as well.
> 
> We'll be able to test it on other SoCs and boards.
Thanks!

> 
> >Works is maybe a stretch - the following was tested:
> >   modetest shows reasonable output
> >   modetest -s shows some nice colored squares
> 
> You must see something like this (without the overlay additional
> black square):
> http://www.at91.com/linux4sam/bin/view/Linux4SAM/UsingAtmelDRMDriver#Some_modetest_commands
I posted a picture to G+ here:
https://plus.google.com/+SamRavnborg/posts/YBt4jUGLgWa

They look similar but are not equal. For now I assume this is OK.
I will do some testing with a Qt app, and will test colors with this too.

> >All feedback (from spelling errors to general structure) appreciated!
> 
> On my side, it's mostly Nitpicking ;-)
> Now that we're Microchip for a little bit more than 2 years, I tend
> to make this name prevalent compared to Atmel for new work around
> our products... But I know this driver is for older SoCs and that it
> got inspired by two former drivers that have this "atmel" naming
> everywhere. MAINTAINERS and Kconfig changes could include Microchip
> name, so that it's obvious for the newcomers...
Will fix, as described above.

Thanks for the inputs!

	Sam
