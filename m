From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [RESEND PATCH v3 06/11] drm: add DT bindings documentation for
 atmel-hlcdc-dc driver
Date: Wed, 16 Jul 2014 15:44:19 +0200
Message-ID: <20140716154419.3b9ab6b4@bbrezillon>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1484511.NijXCAc7Hx@avalon> <20140716150522.4a5d7280@bbrezillon>
 <2090402.0lsU1s2UzH@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2090402.0lsU1s2UzH@avalon>
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

On Wed, 16 Jul 2014 15:20:59 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Boris,
> 
> On Wednesday 16 July 2014 15:05:22 Boris BREZILLON wrote:
> > On Tue, 15 Jul 2014 13:07:58 +0200 Laurent Pinchart wrote:
> > > On Tuesday 15 July 2014 12:52:54 Thierry Reding wrote:
> > >> On Tue, Jul 15, 2014 at 12:43:02PM +0200, Laurent Pinchart wrote:
> > >>> On Tuesday 15 July 2014 12:37:19 Thierry Reding wrote:
> > >>>> On Tue, Jul 15, 2014 at 12:20:02PM +0200, Laurent Pinchart wrote:
> > >>>>> On Tuesday 15 July 2014 12:06:19 Boris BREZILLON wrote:
> > >>>>>> On Mon, 14 Jul 2014 12:05:43 +0200 Thierry Reding wrote:
> > >>>>>>> On Mon, Jul 07, 2014 at 06:42:59PM +0200, Boris BREZILLON wrote:
> > >>>>>>>> The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs
> > >>>>>>>> (i.e. at91sam9n12, at91sam9x5 family or sama5d3 family) provides
> > >>>>>>>> a display controller device.
> > >>>>>>>> 
> > >>>>>>>> The HLCDC block provides a single RGB output port, and only
> > >>>>>>>> supports LCD panels connection to LCD panels for now.
> > >>>>>>>> 
> > >>>>>>>> The atmel,panel property link the HLCDC RGB output with the LCD
> > >>>>>>>> panel connected on this port (note that the HLCDC RGB connector
> > >>>>>>>> implementation makes use of the DRM panel framework).
> > >>>>>>>> 
> > >>>>>>>> Connection to other external devices (DRM bridges) might be added
> > >>>>>>>> later by mean of a new atmel,xxx (atmel,bridge) property.
> > >>>>>>>> 
> > >>>>>>>> Signed-off-by: Boris BREZILLON
> > >>>>>>>> <boris.brezillon@free-electrons.com>
> > >>>>>>>> ---
> > >>>>>>>> 
> > >>>>>>>>  .../devicetree/bindings/drm/atmel-hlcdc-dc.txt     | 59 ++++++++
> > >>>>>>>>  1 file changed, 59 insertions(+)
> > >>>>>>>>  create mode 100644
> > >>>>>>>>  Documentation/devicetree/bindings/drm/atmel-hlcdc-dc.txt
> > >>>>> 
> > >>>>> [snip]
> > >>>>> 
> > >>>>>>>> + - atmel,panel: Should contain a phandle with 2 parameters.
> > >>>>>>>> +   The first cell is a phandle to a DRM panel device
> > >>>>>>>> +   The second cell encodes the RGB mode, which can take the
> > >>>>>>>> following values:
> > >>>>>>>> +   * 0: RGB444
> > >>>>>>>> +   * 1: RGB565
> > >>>>>>>> +   * 2: RGB666
> > >>>>>>>> +   * 3: RGB888
> > >>>>>>> 
> > >>>>>>> These are properties of the panel and should be obtained from the
> > >>>>>>> panel directly rather than an additional cell in this specifier.
> > >>>>>> 
> > >>>>>> Okay.
> > >>>>>> What's the preferred way of doing this ?
> > >>>>>> What about defining an rgb-mode property in the panel node.
> > >>>>> 
> > >>>>> You could do that, but it won't help you much, as the HLCDC driver
> > >>>>> must not parse properties from the panel node. You should instead
> > >>>>> extend the drm_panel API with a function to retrieve panel
> > >>>>> properties. The HLCDC driver will then query the panel driver at
> > >>>>> runtime for the interface type. The panel driver will get the
> > >>>>> information from hardcoded data in the driver, from DT or possibly
> > >>>>> in some cases by querying the panel hardware directly.
> > >>>> 
> > >>>> My preference for this would be that we either add this to some
> > >>>> existing structure (struct drm_display_info seems like a good
> > >>>> candidate) or if the number of parameters grows out of hands, then
> > >>>> maybe even introduce a new type of device that's specific for the
> > >>>> interface. DRM panels are an abstraction for panels, that is,
> > >>>> interface-agnostic, and if we start exposing interface specific
> > >>>> parameters things will start to become very unwieldy.
> > >>> 
> > >>> I agree with the goal of keeping drm_panel interface-agnostic.
> > >>> However, one way or another, interface parameters will need to be
> > >>> communicated between the panel driver and the controller driver. My
> > >>> preference, if we need to extend the number and/or scope of parameters
> > >>> beyond what drm_display_info could reasonably contain, would be to
> > >>> implement a new drm_panel operation to query/configure interface
> > >>> parameters, using a structure that contains the interface type and a
> > >>> union of type-specific structures. This would keep the API generic in
> > >>> the sense of not requiring explicit knowledge of all interfaces in the
> > >>> drivers, while offering the flexibility we need with a way to easily
> > >>> detect the interface type at runtime and react on unknown/unsupported
> > >>> types.
> > >> 
> > >> That's exactly what I was hoping could be avoided. If instead we modeled
> > >> the interface type as a bus, we could for example have an lvds_bus along
> > >> with an lvds_device and then use that as the natural place to store
> > >> these properties. Much like we do for DSI.
> > > 
> > > And I believe that's what we should avoid ;-) First of all, let's not
> > > forget that Linux models control busses, not data busses. DSI is a
> > > special case as it combines the control and data busses, but in the
> > > general case the same implementation isn't possible. An LVDS panel
> > > controlled through I2C needs to be an I2C device sitting on an I2C bus.
> > > 
> > > Then, I believe it would make all drivers simpler if we had a single
> > > object type to deal with, with proper abstractions for bus types. A
> > > drm_panel that can model panels regardless of the data bus type, with one
> > > operation that conveys bus-specific information, makes storing the objects
> > > and communicating with them simpler than having to deal with different
> > > kind of devices.
> >
> > Could you detail a bit what you mean by "single object type" ?
> > 
> > Is this about making a common abstraction class (by mean of
> > drm_xxx and drm_xxx_funcs) that could represent any display device
> > (drm_bridge, drm_panel, ...) ?
> 
> Exactly :-) This is similar to what exists in V4L, with a v4l2_subdev object 
> able to model any kind of IP core or external chip.
> 
> I don't think we will get there in one go, but I'd like to start by merging 
> drm_encoder and drm_bridge on the kernel side. Both objects model the same 
> hardware, a drm_encoder on one board could be a drm_bridge on another one. 
> From a userspace point of view drm_encoder won't go away, and we can't chain 
> multiple encoders, so the change would be internal to the kernel only.
> 
> Then, as a next step, I believe using the same object to model panels would be 
> a good idea, but there's no consensus on that.
> 

I would be happy to help with that, but AFAICT, this is a huge work and
I'd like to get the HLCDC driver merged first ;-).

How about defining what DT bindings should look like (for the RGB/LVDS
output mode), and parsing this in atmel-hlcdc driver as a first step ?

Then we can define proper RGB/LVDS helper functions and the whole
drm_subdev abstraction you were talking about, and move the atmel-hlcdc
driver to this solution when it's ready.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
