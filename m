From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Fri, 18 Jul 2014 17:43:34 +0200
Message-ID: <20140718174334.209e99c1@bbrezillon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
	<1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
	<20140714100542.GB9870@ulmo>
	<20140715120619.7f29c458@bbrezillon>
	<20140715103136.GA6616@ulmo>
	<20140718165152.0a9fde09@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42543 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933454AbaGRPni (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Jul 2014 11:43:38 -0400
In-Reply-To: <20140718165152.0a9fde09@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.>

On Fri, 18 Jul 2014 16:51:52 +0200
Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:

> Hi Thierry,
> 
> Oops, I missed this reply.
> 
> On Tue, 15 Jul 2014 12:31:37 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
> 
> > On Tue, Jul 15, 2014 at 12:06:19PM +0200, Boris BREZILLON wrote:
> > > On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> > [...]
> > > > > diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> > > > [...]
> > > > > +The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
> > > > > +See Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt for more details.
> > > > 
> > > > I think it's better to refer to these using relative filenames. When the
> > > > device tree bindings are moved out of the kernel tree, they may no
> > > > longer use the same hierarchy.
> > > 
> > > Sure.
> > > By relative path you mean ../../mfd/atmel-hlcdc.txt or just
> > > mfd/atmel-hlcdc.txt ?
> > 
> > I think the former is more explicit.
> 
> Okay.
> 
> > 
> > > > > + - atmel,panel: Should contain a phandle with 2 parameters.
> > > > > +   The first cell is a phandle to a DRM panel device
> > > > > +   The second cell encodes the RGB mode, which can take the following values:
> > > > > +   * 0: RGB444
> > > > > +   * 1: RGB565
> > > > > +   * 2: RGB666
> > > > > +   * 3: RGB888
> > > > 
> > > > These are properties of the panel and should be obtained from the panel
> > > > directly rather than an additional cell in this specifier.
> > > 
> > > Okay.
> > > What's the preferred way of doing this ?
> > > What about defining an rgb-mode property in the panel node.
> > 
> > There's .bpc in struct drm_display_info, I suspect that it could be used
> > for this. Alternatively, maybe we could extend the list of color formats
> > that go into drm_display_info.color_formats? RGB444 is already covered.
> 

I forgot to ask about bpc meaning. If, as I think, it means "bits per
color" then it cannot be used to encode RGB565 where green color is
encoded on 6 bits and red and blue are encoded on 5 bits. 

> I don't think this color_formats field is intended to represent data
> stream format going through the bus.
> Moreover, AFAIU, RGB444 in this definition represent RGB 4:4:4 (chroma
> subsampling rate) and not 12 bits signals (4 bits for each color).
> 
> Anyway I'll propose a patch series adding a new field to
> drm_display_info to encode the mediabus format (as discussed with
> Laurent and you).
> 
> > 
> > Also, like Laurent said, this shouldn't go into the device tree, since
> > it's already implied by the panel's compatible value, so we'd be
> > duplicating information.
> 
> Again, this is not necessarily true (depending on your board design).
> One can decide to connect an RGB888 panel on an RGB666 bus and connect
> the missing pins to ground.
> 
> > 
> > > BTW, have you received this series [1] adding support for the LCD panel
> > > I'm testing this driver with.
> > > 
> > > [1] https://lkml.org/lkml/2014/6/5/612
> > 
> > I don't think I've seen it in my inbox, let me check my archives.
> > 
> > > > > +   The third cell encodes specific flags describing LCD signals configuration
> > > > > +   (see Atmel's datasheet for a full description of these fields):
> > > > > +   * bit 0: HSPOL: Horizontal Synchronization Pulse Polarity
> > > > > +   * bit 1: VSPOL: Vertical Synchronization Pulse Polarity
> > > > > +   * bit 2: VSPDLYS: Vertical Synchronization Pulse Start
> > > > > +   * bit 3: VSPDLYE: Vertical Synchronization Pulse End
> > > > > +   * bit 4: DISPPOL: Display Signal Polarity
> > > > > +   * bit 7: DISPDLY: LCD Controller Display Power Signal Synchronization
> > > > > +   * bit 12: VSPSU: LCD Controller Vertical synchronization Pulse Setup Configuration
> > > > > +   * bit 13: VSPHO: LCD Controller Vertical synchronization Pulse Hold Configuration
> > > > > +   * bit 16-20: GUARDTIME: LCD DISPLAY Guard Time
> > > > 
> > > > Similarly for most of these: HSPOL and VSPOL seem to correspond to the
> > > > DRM_MODE_FLAG_{{P,N},{H,V}}SYNC flags in struct drm_display_mode. And
> > > > VSPDLYS as well as VSPDLYE sound like they may be vsync_start and
> > > > vsync_end of the same structure.
> > > 
> > > I agree with HSPOL and VSPOL.
> > > 
> > > > 
> > > > As for the others, maybe if you could explain what exactly they are we
> > > > may be able to find a better fit.
> > > 
> > > Atmel datasheets include several timing diagrams [2] (chapter "32.6.17
> > > Output Timing Generation" page 603), and I think you will get more
> > > informations from these diagrams than if I try to explain what I
> > > understood ;-).
> > 
> > These look like knobs to tune the signal in a very fine-grained manner.
> > To be honest, maybe the best way to solve this would be by omitting them
> > for now and choose some default that's likely to work on most devices.
> > Does the panel that you use specify how it expects HSYNC to be timed vs.
> > VSYNC?
> 
> 
> No it doesn't, and I agree that we should leave these specific timing
> tweaks unimplemented until we really need them.
> 
> Regards,
> 
> Boris
> 
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
