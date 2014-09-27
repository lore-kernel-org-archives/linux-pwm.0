From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v5 05/11] drm: add Atmel HLCDC Display Controller support
Date: Sat, 27 Sep 2014 22:12:55 +0200
Message-ID: <20140927221255.58f4d14d@bbrezillon>
References: <1410165822-16868-1-git-send-email-boris.brezillon@free-electrons.com>
 <1410165822-16868-6-git-send-email-boris.brezillon@free-electrons.com>
 <CAF6AEGup9qvivbcovHBrf6me-sStrK_jaBTd5ofohCS9DfRV4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAF6AEGup9qvivbcovHBrf6me-sStrK_jaBTd5ofohCS9DfRV4g@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Rob Clark <robdclark@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Andrew Victor <linux@maxim.org.za>
List-Id: linux-pwm@vger.kernel.org

Hi Rob,

On Fri, 26 Sep 2014 17:10:49 -0400
Rob Clark <robdclark@gmail.com> wrote:

> On Mon, Sep 8, 2014 at 4:43 AM, Boris BREZILLON
> <boris.brezillon@free-electrons.com> wrote:
> > The Atmel HLCDC (HLCD Controller) IP available on some Atmel SoCs (i.e.
> > at91sam9n12, at91sam9x5 family or sama5d3 family) provides a display
> > controller device.
> >
> > This display controller supports at least one primary plane and might
> > provide several overlays and an hardware cursor depending on the IP
> > version.
> >
> > At the moment, this driver only implements an RGB connector to interface
> > with LCD panels, but support for other kind of external devices might be
> > added later.
> >
> > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> A few small comments below, but with those addressed it has my
> 
> Reviewed-by: Rob Clark <robdclark@gmail.com>

Thanks for your review.

> 
> 
> > ---
> >  drivers/gpu/drm/Kconfig                          |   2 +
> >  drivers/gpu/drm/Makefile                         |   1 +
> >  drivers/gpu/drm/atmel-hlcdc/Kconfig              |  13 +
> >  drivers/gpu/drm/atmel-hlcdc/Makefile             |   7 +
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c   | 286 ++++++++
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c     | 488 +++++++++++++
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h     | 224 ++++++
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c  | 656 ++++++++++++++++++
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h  | 403 +++++++++++
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 476 +++++++++++++
> >  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c  | 836 +++++++++++++++++++++++
> >  11 files changed, 3392 insertions(+)
> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/Kconfig
> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/Makefile
> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
> >  create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> >
> 
> [snip]
> 
> > +
> > +/**
> > + * Atmel HLCDC plane rotation enum
> > + *
> > + * TODO: export DRM_ROTATE_XX macros defined by omap driver and use them
> > + * instead of defining this enum.
> > + */
> > +enum atmel_hlcdc_plane_rotation {
> > +       ATMEL_HLCDC_PLANE_NO_ROTATION,
> > +       ATMEL_HLCDC_PLANE_90DEG_ROTATION,
> > +       ATMEL_HLCDC_PLANE_180DEG_ROTATION,
> > +       ATMEL_HLCDC_PLANE_270DEG_ROTATION,
> > +};
> 
> DRM_ROTATE_* are already in drm_crtc.h
> 
> [snip]

Yep, I changed that, but won't be able to test until next week.

> 
> > +static int atmel_hlcdc_rgb_mode_valid(struct drm_connector *connector,
> > +                                     struct drm_display_mode *mode)
> > +{
> > +       return MODE_OK;
> > +}
> 
> your _mode_valid() should perhaps somehow check the constraints in
> atmel_hlcdc_crtc_mode_set()?  This way invalid modes get filtered out
> earlier..

I'm not sure, the test done in atmel_hlcdc_crtc_mode_set are not
connector related, but rather imposed by the display controller
limitations.
Anyway, let me know if you still think I should move those tests in the
connector mode_valid implementation.

> 
> [snip]
> 
> > +static struct atmel_hlcdc_plane_properties *
> > +atmel_hlcdc_plane_create_properties(struct drm_device *dev)
> > +{
> > +       struct atmel_hlcdc_plane_properties *props;
> > +       const struct drm_prop_enum_list rotations[] = {
> > +               { ATMEL_HLCDC_PLANE_NO_ROTATION,   "rotate-0" },
> > +               { ATMEL_HLCDC_PLANE_90DEG_ROTATION,  "rotate-90" },
> > +               { ATMEL_HLCDC_PLANE_180DEG_ROTATION, "rotate-180" },
> > +               { ATMEL_HLCDC_PLANE_270DEG_ROTATION, "rotate-270" },
> > +       };
> > +
> 
> you could just use drm_mode_create_rotation_property() now
> 

Yep, I changed that too. Thanks for the tip.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
