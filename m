From: Rob Clark <robdclark@gmail.com>
Subject: Re: [RESEND PATCH v3 05/11] drm: add Atmel HLCDC Display Controller
 support
Date: Tue, 8 Jul 2014 11:41:32 -0400
Message-ID: <CAF6AEGuOYQbZ_Mgv+Y7oQO4kKmOEF=gwi0YcBXERE80nS2QL+g@mail.gmail.com>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-6-git-send-email-boris.brezillon@free-electrons.com>
 <CAF6AEGtttUFquRQrhFKtEKq+frAAmzp4AVtF5gixVkMmJNC68g@mail.gmail.com>
 <20140708092348.4ecdbb8f@bbrezillon>
 <CAF6AEGuUz7Td-9Hh31rYpn_Zros=ozK_ttv9FadHot6qAuaq1Q@mail.gmail.com>
 <20140708163731.6693a883@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140708163731.6693a883@bbrezillon>
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
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Lee Jones <lee.jones@linaro.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

On Tue, Jul 8, 2014 at 10:37 AM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:
> On Tue, 8 Jul 2014 08:49:41 -0400
> Rob Clark <robdclark@gmail.com> wrote:
>
>> On Tue, Jul 8, 2014 at 3:23 AM, Boris BREZILLON
>> <boris.brezillon@free-electrons.com> wrote:
>> > Hello Rob,
>> >
>> > On Mon, 7 Jul 2014 23:45:54 -0400
>> > Rob Clark <robdclark@gmail.com> wrote:
>> >
>> >> On Mon, Jul 7, 2014 at 12:42 PM, Boris BREZILLON
>> >> <boris.brezillon@free-electrons.com> wrote:
>> >> > The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
>> >> > at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
>> >> > controller device.
>> >> >
>> >> > This display controller supports at least one primary plane and might
>> >> > provide several overlays and an hardware cursor depending on the IP
>> >> > version.
>> >> >
>> >> > At the moment, this driver only implements an RGB connector to interface
>> >> > with LCD panels, but support for other kind of external devices (like DRM
>> >> > bridges) might be added later.
>> >> >
>> >> > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
>> >> > ---
>> >> >  drivers/gpu/drm/Kconfig                         |   2 +
>> >> >  drivers/gpu/drm/Makefile                        |   1 +
>> >> >  drivers/gpu/drm/atmel-hlcdc/Kconfig             |  11 +
>> >> >  drivers/gpu/drm/atmel-hlcdc/Makefile            |   7 +
>> >> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c  | 469 +++++++++++++++
>> >> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c    | 474 +++++++++++++++
>> >> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    | 210 +++++++
>> >> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c | 706 +++++++++++++++++++++++
>> >> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h | 422 ++++++++++++++
>> >> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_panel.c | 351 ++++++++++++
>> >> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 729 ++++++++++++++++++++++++
>> >> >  11 files changed, 3382 insertions(+)
>> >> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/Kconfig
>> >> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/Makefile
>> >> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> >> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> >> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>> >> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
>> >> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
>> >> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_panel.c
>> >> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
>> >> >
>> >> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> >> > index d1cc2f6..df6f0c1 100644
>> >> > --- a/drivers/gpu/drm/Kconfig
>> >> > +++ b/drivers/gpu/drm/Kconfig
>> >> > @@ -182,6 +182,8 @@ source "drivers/gpu/drm/cirrus/Kconfig"
>> >
>> > [...]
>> >
>> >> > +
>> >> > +/**
>> >> > + * Atmel HLCDC Plane properties.
>> >> > + *
>> >> > + * This structure stores plane property definitions.
>> >> > + *
>> >> > + * @alpha: alpha blending (or transparency) property
>> >> > + * @csc: YUV to RGB conversion factors property
>> >> > + */
>> >> > +struct atmel_hlcdc_plane_properties {
>> >> > +       struct drm_property *alpha;
>> >> > +       struct drm_property *csc;
>> >>
>> >> appears like csc is not used yet, so I suppose you can drop it for
>> >> now..  when you do add it, don't forget to update drm.tmp.  But for
>> >> now it at least makes review easier when the driver doesn't add new
>> >> userspace interfaces :-)
>> >
>> >
>> > Sure, I guess this is a leftover from another patch I made to add Color
>> > Space Conversion configuration.
>> >
>> > I'll remove it for the next version.
>> >
>> >>
>> >> > +};
>> >> > +
>> >> > +/**
>> >> > + * Atmel HLCDC Plane.
>> >> > + *
>> >> > + * @base: base DRM plane structure
>> >> > + * @layer: HLCDC layer structure
>> >> > + * @properties: pointer to the property definitions structure
>> >> > + * @alpha: current alpha blending (or transparency) status
>> >> > + */
>> >> > +struct atmel_hlcdc_plane {
>> >> > +       struct drm_plane base;
>> >> > +       struct atmel_hlcdc_layer layer;
>> >> > +       struct atmel_hlcdc_plane_properties *properties;
>> >> > +};
>> >> > +
>> >> > +static inline struct atmel_hlcdc_plane *
>> >> > +drm_plane_to_atmel_hlcdc_plane(struct drm_plane *p)
>> >> > +{
>> >> > +       return container_of(p, struct atmel_hlcdc_plane, base);
>> >> > +}
>> >> > +
>> >> > +static inline struct atmel_hlcdc_plane *
>> >> > +atmel_hlcdc_layer_to_plane(struct atmel_hlcdc_layer *l)
>> >> > +{
>> >> > +       return container_of(l, struct atmel_hlcdc_plane, layer);
>> >> > +}
>> >> > +
>> >> > +/**
>> >> > + * Atmel HLCDC Plane update request structure.
>> >> > + *
>> >> > + * @crtc_x: x position of the plane relative to the CRTC
>> >> > + * @crtc_y: y position of the plane relative to the CRTC
>> >> > + * @crtc_w: visible width of the plane
>> >> > + * @crtc_h: visible height of the plane
>> >> > + * @src_x: x buffer position
>> >> > + * @src_y: y buffer position
>> >> > + * @src_w: buffer width
>> >> > + * @src_h: buffer height
>> >> > + * @pixel_format: pixel format
>> >> > + * @gems: GEM object object containing image buffers
>> >> > + * @offsets: offsets to apply to the GEM buffers
>> >> > + * @pitches: line size in bytes
>> >> > + * @crtc: crtc to display on
>> >> > + * @finished: finished callback
>> >> > + * @finished_data: data passed to the finished callback
>> >> > + * @bpp: bytes per pixel deduced from pixel_format
>> >> > + * @xstride: value to add to the pixel pointer between each line
>> >> > + * @pstride: value to add to the pixel pointer between each pixel
>> >> > + * @nplanes: number of planes (deduced from pixel_format)
>> >> > + */
>> >> > +struct atmel_hlcdc_plane_update_req {
>> >> > +       int crtc_x;
>> >> > +       int crtc_y;
>> >> > +       unsigned int crtc_w;
>> >> > +       unsigned int crtc_h;
>> >> > +       uint32_t src_x;
>> >> > +       uint32_t src_y;
>> >> > +       uint32_t src_w;
>> >> > +       uint32_t src_h;
>> >> > +       uint32_t pixel_format;
>> >> > +       struct drm_gem_cma_object *gems[ATMEL_HLCDC_MAX_PLANES];
>> >> > +       unsigned int offsets[ATMEL_HLCDC_MAX_PLANES];
>> >> > +       unsigned int pitches[ATMEL_HLCDC_MAX_PLANES];
>> >>
>> >> tbh, I've only looked closely, but I don't completely follow all the
>> >> layering here..  I wonder if we'd be better off just moving 'struct
>> >> drm_fb_cma' to header file so you could get the gem objects / pixel
>> >> fmt / width / height directly from the fb object (and then you can
>> >> reference count things at the fb level, rather than at the individual
>> >> gem obj level, too)
>> >>
>> >
>> > Actually, the HW cursor is a drm_plane too, and in this case I cannot
>> > retrieve a drm_fb_cma object, but just a single GEM object (see
>> > atmel_hlcdc_crtc_cursor_set function in atmel_hlcdc_crtc.c).
>>
>> oh, right..  well maybe for the cursor case it would be possible to
>> wrap up the gem bo with an internally created fb?  Not sure if that
>> ends up simplifying things or not, so it is definitely your call.  But
>> at least my experience with other drivers (that did not use a plane as
>> a cursor internally) was that I could simplify things after fb gained
>> refcnt'ing.
>
> Unless I'm missing something, I'd say moving to fb objects instead of
> GEM objects won't simplify the code much (I'm already refcnt'ing GEM
> objects when launching a DMA transfer for a plane update).

yeah, mostly just saves you a bit of bookkeeping.  Ie. ref/unref one
thing instead of loop over N objects, etc.  Nothing earth-shattering.

BR,
-R

> The only benefit I can see is consistency with other drivers (which in
> fact is a good point).
> Indeed atmel_hlcdc_plane_update_req redefines some fields which are
> already availables in drm_fb_cma or drm_framebuffer:
>
> - gems (called objs in drm_fb_cma)
> - pixel_format
> - pitches (offsets must be redefined because it is modified in
>   atmel_hlcdc_plane_prepare_update_req)
>
> Anyway, I'll give it a try.
>
> Thanks for your review.
>
> In the meantime, I realized I hadn't subscribed to the dri-devel
> ML, which might explain why I didn't get any reviews from DRM
> maintainers/developers so far :-).
>
> Best Regards,
>
> Boris
>
> --
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
