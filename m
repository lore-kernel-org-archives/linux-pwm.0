From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Fri, 11 Jul 2014 14:00:25 +0200
Message-ID: <20140711140025.62873695@bbrezillon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1584022.nQ4HpIUW7J@avalon> <20140710145626.48cb956f@bbrezillon>
 <33456066.4Q4p6nxKdU@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <33456066.4Q4p6nxKdU@avalon>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bo Shen <voice.shen@atmel.com>, Lee Jones <lee.jones@linaro.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, 11 Jul 2014 12:37:46 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Boris,
> 
> On Thursday 10 July 2014 14:56:26 Boris BREZILLON wrote:
> > On Thu, 10 Jul 2014 13:16:21 +0200 Laurent Pinchart wrote:
> > > On Monday 07 July 2014 18:42:59 Boris BREZILLON wrote:
> > > > The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
> > > > at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
> > > > controller device.
> > > > 
> > > > The HLCDC block provides a single RGB output port, and only supports LCD
> > > > panels connection to LCD panels for now.
> > > > 
> > > > The atmel,panel property link the HLCDC RGB output with the LCD panel
> > > > connected on this port (note that the HLCDC RGB connector implementation
> > > > makes use of the DRM panel framework).
> > > > 
> > > > Connection to other external devices (DRM bridges) might be added later
> > > > by mean of a new atmel,xxx (atmel,bridge) property.
> > > > 
> > > > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > > > ---
> > > > 
> > > >  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 59 +++++++++++++++
> > > >  1 file changed, 59 insertions(+)
> > > >  create mode 100644
> > > >  Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> > > > b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt new file mode
> > > > 100644
> > > > index 0000000..594bdb2
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> > > > @@ -0,0 +1,59 @@
> > > > +Device-Tree bindings for Atmel's HLCDC (High LCD Controller) DRM driver
> > > > +
> > > > +The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD
> > > > device.
> > > > +See Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt for more
> > > > details.
> > > > +
> > > > +Required properties:
> > > > + - compatible: value should be one of the following:
> > > > +   "atmel,hlcdc-dc"
> > > > + - interrupts: the HLCDC interrupt definition
> > > > + - pinctrl-names: the pin control state names. Should contain
> > > > "default",
> > > > +   "rgb-444", "rgb-565", "rgb-666" and "rgb-888".
> > > > + - pinctrl-[0-4]: should contain the pinctrl states described by
> > > > pinctrl
> > > > +   names.
> > > 
> > > Do you need to switch between the different pinctrl configurations at
> > > runtime, or is the configuration selected from the panel type, which
> > > doesn't change ?
> >
> > At the moment no, but if we ever need to support different devices on
> > the same RGB connector (actually Atmel's sama5d3xek boards have an
> > RGB to HDMI bridge connected on the same RGB connector) and these
> > devices do not support the same RGB mode (say your LCD panel supports
> > RGB888 and your RGB to HDMI bridge supports RGB555), then depending on
> > the output you select you'll have to change your pinctrl config at
> > runtime.
> 
> Just to make sure I understand the use case correctly, are you talking about 
> two devices (for example an RGB666 panel and an RGB888 RGB to HDMI bridge) 
> connected to the same output, with the ability to switch between the two at 
> runtime ?

Exactly.

> That's a valid case (on a side note we shouldn't forget that the 
> option of using both devices at the same time should be supported as well), 

AFAICT this is only possible if both devices connected to the RGB
connector use the same mode.

> but I would probably go for a fixed pinctrl configuration that supports both, 
> although switching configurations at runtime would be a micro-optimization 
> that might make sense.

Yep, it should work, and I agree that we're unlikely to reuse some RGB
pins for other usage when the active device is the one using RGB666
mode.

> 
> > I'd say we could get rid of this runtime pinctrl config as a first step
> > if DT ABI stability was not required.
> > But it is, and I'd like to have a future proof binding to handle these
> > tricky cases when they occurs (if they ever do).
> 
> I think we have a shortcoming of the pinctrl API here in the general case. The 
> API only allows you to select a single configuration per device. Imagine the 
> same display controller, with two DPI outputs, each of them configurable in 
> 444, 565, 666 or 888 modes. With the current API we would have to create 4*4 = 
> 16 pinctrl configurations for all combinations. That obviously wouldn't scale, 
> so we'll have to fix this eventually. From a DT stability point of view, I 
> would thus avoid specifying multiple pinctrl configurations now until we come 
> up with a standard way to support this use case.

Given your inputs, I guess I'll drop dynamic pinctrl config for the
next version.

> 
> > Anyway, I'm open to any other alternative that could let me add support
> > for this later on.
> > 
> > BTW, is there any reason for not defining an RGB connector type (I'm
> > currently defining HLCDC connector as an LVDS connector) ?
> 
> Not that I know of. The DRM API has been developed before display on embedded 
> systems became such a hot topic. If we had to redo it today, panels might be 
> exposed to userspace as such, with a connector. We have to live with the past, 
> so the connector will stay, but adding a new RGB connector type could make 
> sense (although we might need a different name, in a way the VGA and LVDS 
> connectors also carry RGB signals).

I had the same concern: I didn't find how this kind of connectors
was named (most of the time they're just referenced as RGB) :-).
What about RAW_RGB ?

> 
> > > > + - atmel,panel: Should contain a phandle with 2 parameters.
> > > > +   The first cell is a phandle to a DRM panel device
> > > > +   The second cell encodes the RGB mode, which can take the following
> > > > values:
> > > > +   * 0: RGB444
> > > > +   * 1: RGB565
> > > > +   * 2: RGB666
> > > > +   * 3: RGB888
> > > > +   The third cell encodes specific flags describing LCD signals
> > > > configuration
> > > > +   (see Atmel's datasheet for a full description of these
> > > > fields):
> > > > +   * bit 0: HSPOL: Horizontal Synchronization Pulse Polarity
> > > > +   * bit 1: VSPOL: Vertical Synchronization Pulse Polarity
> > > > +   * bit 2: VSPDLYS: Vertical Synchronization Pulse Start
> > > > +   * bit 3: VSPDLYE: Vertical Synchronization Pulse End
> > > > +   * bit 4: DISPPOL: Display Signal Polarity
> > > > +   * bit 7: DISPDLY: LCD Controller Display Power Signal
> > > > Synchronization
> > > > +   * bit 12: VSPSU: LCD Controller Vertical synchronization Pulse Setup
> > > > Configuration
> > > > +   * bit 13: VSPHO: LCD Controller Vertical synchronization Pulse Hold
> > > > Configuration
> > > > +   * bit 16-20: GUARDTIME: LCD DISPLAY Guard Time
> > > 
> > > If I'm not mistaken, those are HLCDC configuration values that depend on
> > > the panel type and characteristics. Shouldn't they then be queries from
> > > the panel through the drm_panel API at runtime instead of being specified
> > > in DT ? This would likely require extending the drm_panel API.
> > 
> > HSPOL and VSPOL can be deduced from DRM_MODE_FLAG_[PN]HSYNC and
> > DRM_MODE_FLAG_[PN]VSYNC, I'm not sure for the other flags or the
> > GUARDTIME value.
> > 
> > Another question I had regarding these flags is whether they were LCD
> > panel specific or a mix of panel and board implementation.
> > Take the VSYNC HSYNC polarity, of course the LCD panel defines what it
> > expects in terms of polarity, but nothing prevents the HW designer from
> > inverting the VSYNC/HSYNC polarity (expect common sense :-)), right ?
> >
> > A solution would be to override some drm_display_mode settings with
> > informations taken from the DT.
> 
> Given that I gave the exact same argument during a V4L2 DT bindings design 
> review, I can only agree :-) It thus makes sense to specify polarities in the 
> HLCDC DT node. The RGB mode, however, should probably be queried from the 
> panel, as I don't expect it to be board-dependent but only panel-dependent.

Yes, what I had in mind is some kind of RGB connector framework (or
just helper functions), where you could define the supported RGB modes
and rely on another infrastructure to define the supported drm display
modes.
Because RGB connector is not just related to panels: see this RGB to
HDMI bridge [1] (this is the one used on Atmel's dev boards).
Moreover, simple panels are connector agnostics for now, and I'm not
sure we want to change that.

[1]http://pdf1.alldatasheet.fr/datasheet-pdf/view/218068/SILICONIMAGE/SII9022.html

> 
> I'm not sure about the other bits in the third cell, maybe we should discuss 
> them in more details. I'm always wary when I see DT bindings referring to a 
> datasheet :-) Getting the information from the panel by default, with a 
> possible override, is an interesting option. You would thus likely need 
> several DT properties associated with each connection to a panel. Would it 
> then make sense to use the OF graph DT bindings instead of the atmel,panel 
> property to specify connections ? You could store per-connection data in the 
> endpoint and/or port nodes.

I'll take a look at these bindings and let you know if they match my
needs.

> 
> > Thanks for your review.
> 
> You're welcome. Sorry for not having had time to review the driver itself. 
> Given my limited bandwidth at the moment I've decided to concentrate on the DT 
> bindings first.

No problem, after all DT bindings is the most tricky part of our work
nowadays, isn't it ;-) ?

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
