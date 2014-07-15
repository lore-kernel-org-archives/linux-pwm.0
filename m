From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Tue, 15 Jul 2014 12:20:02 +0200
Message-ID: <1417324.PxofUz16v0@avalon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140714100542.GB9870@ulmo> <20140715120619.7f29c458@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140715120619.7f29c458@bbrezillon>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, dri-devel@lists.freedesktop.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Bo Shen <voice.shen@atmel.com>, Lee Jones <lee.jones@linaro.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org

Hi Boris,

On Tuesday 15 July 2014 12:06:19 Boris BREZILLON wrote:
> On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding wrote:
> > On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> > > The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
> > > at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
> > > controller device.
> > > 
> > > The HLCDC block provides a single RGB output port, and only supports LCD
> > > panels connection to LCD panels for now.
> > > 
> > > The atmel,panel property link the HLCDC RGB output with the LCD panel
> > > connected on this port (note that the HLCDC RGB connector implementation
> > > makes use of the DRM panel framework).
> > > 
> > > Connection to other external devices (DRM bridges) might be added later
> > > by mean of a new atmel,xxx (atmel,bridge) property.
> > > 
> > > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > > ---
> > > 
> > >  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 59 +++++++++++++++
> > >  1 file changed, 59 insertions(+)
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt

[snip]

> > > + - atmel,panel: Should contain a phandle with 2 parameters.
> > > +   The first cell is a phandle to a DRM panel device
> > > +   The second cell encodes the RGB mode, which can take the following
> > > values: +   * 0: RGB444
> > > +   * 1: RGB565
> > > +   * 2: RGB666
> > > +   * 3: RGB888
> > 
> > These are properties of the panel and should be obtained from the panel
> > directly rather than an additional cell in this specifier.
> 
> Okay.
> What's the preferred way of doing this ?
> What about defining an rgb-mode property in the panel node.

You could do that, but it won't help you much, as the HLCDC driver must not 
parse properties from the panel node. You should instead extend the drm_panel 
API with a function to retrieve panel properties. The HLCDC driver will then 
query the panel driver at runtime for the interface type. The panel driver 
will get the information from hardcoded data in the driver, from DT or 
possibly in some cases by querying the panel hardware directly.

> BTW, have you received this series [1] adding support for the LCD panel
> I'm testing this driver with.
> 
> [1] https://lkml.org/lkml/2014/6/5/612
> 
> > > +   The third cell encodes specific flags describing LCD signals
> > > configuration
> > > +   (see Atmel's datasheet for a full description of these fields):
> > > +   * bit 0: HSPOL: Horizontal Synchronization Pulse Polarity
> > > +   * bit 1: VSPOL: Vertical Synchronization Pulse Polarity
> > > +   * bit 2: VSPDLYS: Vertical Synchronization Pulse Start
> > > +   * bit 3: VSPDLYE: Vertical Synchronization Pulse End
> > > +   * bit 4: DISPPOL: Display Signal Polarity
> > > +   * bit 7: DISPDLY: LCD Controller Display Power Signal
> > > Synchronization
> > > +   * bit 12: VSPSU: LCD Controller Vertical synchronization Pulse Setup
> > > Configuration
> > > +   * bit 13: VSPHO: LCD Controller Vertical synchronization Pulse Hold
> > > Configuration
> > > +   * bit 16-20: GUARDTIME: LCD DISPLAY Guard Time
> > 
> > Similarly for most of these: HSPOL and VSPOL seem to correspond to the
> > DRM_MODE_FLAG_{{P,N},{H,V}}SYNC flags in struct drm_display_mode. And
> > VSPDLYS as well as VSPDLYE sound like they may be vsync_start and
> > vsync_end of the same structure.
> 
> I agree with HSPOL and VSPOL.
> 
> > As for the others, maybe if you could explain what exactly they are we
> > may be able to find a better fit.
> 
> Atmel datasheets include several timing diagrams [2] (chapter "32.6.17
> Output Timing Generation" page 603), and I think you will get more
> informations from these diagrams than if I try to explain what I
> understood ;-).

The VSP* bits fine-tune the VSYNC pulse generation timings by specifying the 
relationship between the VSYNC edges and the HSYNC pulses at the beginning and 
end of the VSYNC pulse. It might make sense to turn that into standard DRM 
properties, but we'll need to research if and how other vendor offer similar 
features.

As for GUARDTIME, I would split it into its own property. What are the typical 
values you have seen being used in read systems ?

-- 
Regards,

Laurent Pinchart
