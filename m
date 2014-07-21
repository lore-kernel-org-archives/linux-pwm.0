From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Mon, 21 Jul 2014 14:33:21 +0200
Message-ID: <20140721143321.5bda6ea9@bbrezillon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
	<1404751384-5077-7-git-send-email-boris.brezillon@free-electrons.com>
	<20140714100542.GB9870@ulmo>
	<20140715120619.7f29c458@bbrezillon>
	<20140715103136.GA6616@ulmo>
	<20140718165152.0a9fde09@bbrezillon>
	<20140721121513.GB15238@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52912 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754040AbaGUMdZ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Jul 2014 08:33:25 -0400
In-Reply-To: <20140721121513.GB15238@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Robert Nelson <robertcnelson@gmail.com>, Tim Niemeyer <tim.niemeyer@corscience>

On Mon, 21 Jul 2014 14:15:16 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Fri, Jul 18, 2014 at 04:51:52PM +0200, Boris BREZILLON wrote:
> > Hi Thierry,
> > 
> > Oops, I missed this reply.
> > 
> > On Tue, 15 Jul 2014 12:31:37 +0200
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> > 
> > > On Tue, Jul 15, 2014 at 12:06:19PM +0200, Boris BREZILLON wrote:
> > > > On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > > On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> > > [...]
> > > > > > diff --git a/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt b/Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> > > > > [...]
> > > > > > +The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
> > > > > > +See Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt for more details.
> > > > > 
> > > > > I think it's better to refer to these using relative filenames. When the
> > > > > device tree bindings are moved out of the kernel tree, they may no
> > > > > longer use the same hierarchy.
> > > > 
> > > > Sure.
> > > > By relative path you mean ../../mfd/atmel-hlcdc.txt or just
> > > > mfd/atmel-hlcdc.txt ?
> > > 
> > > I think the former is more explicit.
> > 
> > Okay.
> > 
> > > 
> > > > > > + - atmel,panel: Should contain a phandle with 2 parameters.
> > > > > > +   The first cell is a phandle to a DRM panel device
> > > > > > +   The second cell encodes the RGB mode, which can take the following values:
> > > > > > +   * 0: RGB444
> > > > > > +   * 1: RGB565
> > > > > > +   * 2: RGB666
> > > > > > +   * 3: RGB888
> > > > > 
> > > > > These are properties of the panel and should be obtained from the panel
> > > > > directly rather than an additional cell in this specifier.
> > > > 
> > > > Okay.
> > > > What's the preferred way of doing this ?
> > > > What about defining an rgb-mode property in the panel node.
> > > 
> > > There's .bpc in struct drm_display_info, I suspect that it could be used
> > > for this. Alternatively, maybe we could extend the list of color formats
> > > that go into drm_display_info.color_formats? RGB444 is already covered.
> > 
> > I don't think this color_formats field is intended to represent data
> > stream format going through the bus.
> > Moreover, AFAIU, RGB444 in this definition represent RGB 4:4:4 (chroma
> > subsampling rate) and not 12 bits signals (4 bits for each color).
> > 
> > Anyway I'll propose a patch series adding a new field to
> > drm_display_info to encode the mediabus format (as discussed with
> > Laurent and you).
> > 
> > > 
> > > Also, like Laurent said, this shouldn't go into the device tree, since
> > > it's already implied by the panel's compatible value, so we'd be
> > > duplicating information.
> > 
> > Again, this is not necessarily true (depending on your board design).
> > One can decide to connect an RGB888 panel on an RGB666 bus and connect
> > the missing pins to ground.
> 
> I think in that case the board design itself could be considered as an
> RGB888 to RGB666 bridge, and I think that's what the device tree should
> be describing rather than a panel with a variable number of input
> formats.

So, you're suggesting to add an RGB to RGB drm_bridge driver (and
the appropriate DT bindings) to handle this case, right ?

I don't know much about drm bridges, but I'll take a look.

Anyway, at the moment I don't have such hardware (one connecting an
RGB888 panel on an RGB666 bus), I was just wondering how I could
represent it ;-).

Thanks,

Boris



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
