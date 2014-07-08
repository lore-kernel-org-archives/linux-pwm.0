From: Matt Roper <matthew.d.roper@intel.com>
Subject: Re: [RESEND PATCH v3 05/11] drm: add Atmel HLCDC Display
 Controller support
Date: Tue, 8 Jul 2014 16:51:24 -0700
Message-ID: <20140708235124.GM31728@intel.com>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-6-git-send-email-boris.brezillon@free-electrons.com>
 <CAF6AEGtttUFquRQrhFKtEKq+frAAmzp4AVtF5gixVkMmJNC68g@mail.gmail.com>
 <20140708092348.4ecdbb8f@bbrezillon>
 <CAF6AEGuUz7Td-9Hh31rYpn_Zros=ozK_ttv9FadHot6qAuaq1Q@mail.gmail.com>
 <20140708163731.6693a883@bbrezillon>
 <CAF6AEGuOYQbZ_Mgv+Y7oQO4kKmOEF=gwi0YcBXERE80nS2QL+g@mail.gmail.com>
 <20140708190820.2a94723f@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:25913 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbaGHXuW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 8 Jul 2014 19:50:22 -0400
Content-Disposition: inline
In-Reply-To: <20140708190820.2a94723f@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Rob Clark <robdclark@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Lee Jones <lee.jones@linaro.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Andrew Victor <linux@maxim.org.za>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas

On Tue, Jul 08, 2014 at 07:08:20PM +0200, Boris BREZILLON wrote:
> On Tue, 8 Jul 2014 11:41:32 -0400
> Rob Clark <robdclark@gmail.com> wrote:
> 
> > On Tue, Jul 8, 2014 at 10:37 AM, Boris BREZILLON
> > <boris.brezillon@free-electrons.com> wrote:
> > > On Tue, 8 Jul 2014 08:49:41 -0400
> > > Rob Clark <robdclark@gmail.com> wrote:
> > >
> > >> On Tue, Jul 8, 2014 at 3:23 AM, Boris BREZILLON
> > >> <boris.brezillon@free-electrons.com> wrote:
> > >> > Hello Rob,
> > >> >
> > >> > On Mon, 7 Jul 2014 23:45:54 -0400
> > >> > Rob Clark <robdclark@gmail.com> wrote:
> > >> >
> > >> >> On Mon, Jul 7, 2014 at 12:42 PM, Boris BREZILLON
> > >> >> <boris.brezillon@free-electrons.com> wrote:
...
> > >> >> > +/**
> > >> >> > + * Atmel HLCDC Plane update request structure.
> > >> >> > + *
> > >> >> > + * @crtc_x: x position of the plane relative to the CRTC
> > >> >> > + * @crtc_y: y position of the plane relative to the CRTC
> > >> >> > + * @crtc_w: visible width of the plane
> > >> >> > + * @crtc_h: visible height of the plane
> > >> >> > + * @src_x: x buffer position
> > >> >> > + * @src_y: y buffer position
> > >> >> > + * @src_w: buffer width
> > >> >> > + * @src_h: buffer height
> > >> >> > + * @pixel_format: pixel format
> > >> >> > + * @gems: GEM object object containing image buffers
> > >> >> > + * @offsets: offsets to apply to the GEM buffers
> > >> >> > + * @pitches: line size in bytes
> > >> >> > + * @crtc: crtc to display on
> > >> >> > + * @finished: finished callback
> > >> >> > + * @finished_data: data passed to the finished callback
> > >> >> > + * @bpp: bytes per pixel deduced from pixel_format
> > >> >> > + * @xstride: value to add to the pixel pointer between each line
> > >> >> > + * @pstride: value to add to the pixel pointer between each pixel
> > >> >> > + * @nplanes: number of planes (deduced from pixel_format)
> > >> >> > + */
> > >> >> > +struct atmel_hlcdc_plane_update_req {
> > >> >> > +       int crtc_x;
> > >> >> > +       int crtc_y;
> > >> >> > +       unsigned int crtc_w;
> > >> >> > +       unsigned int crtc_h;
> > >> >> > +       uint32_t src_x;
> > >> >> > +       uint32_t src_y;
> > >> >> > +       uint32_t src_w;
> > >> >> > +       uint32_t src_h;
> > >> >> > +       uint32_t pixel_format;
> > >> >> > +       struct drm_gem_cma_object *gems[ATMEL_HLCDC_MAX_PLANES];
> > >> >> > +       unsigned int offsets[ATMEL_HLCDC_MAX_PLANES];
> > >> >> > +       unsigned int pitches[ATMEL_HLCDC_MAX_PLANES];
> > >> >>
> > >> >> tbh, I've only looked closely, but I don't completely follow all the
> > >> >> layering here..  I wonder if we'd be better off just moving 'struct
> > >> >> drm_fb_cma' to header file so you could get the gem objects / pixel
> > >> >> fmt / width / height directly from the fb object (and then you can
> > >> >> reference count things at the fb level, rather than at the individual
> > >> >> gem obj level, too)
> > >> >>
> > >> >
> > >> > Actually, the HW cursor is a drm_plane too, and in this case I cannot
> > >> > retrieve a drm_fb_cma object, but just a single GEM object (see
> > >> > atmel_hlcdc_crtc_cursor_set function in atmel_hlcdc_crtc.c).
> > >>
> > >> oh, right..  well maybe for the cursor case it would be possible to
> > >> wrap up the gem bo with an internally created fb?  Not sure if that
> > >> ends up simplifying things or not, so it is definitely your call.  But
> > >> at least my experience with other drivers (that did not use a plane as
> > >> a cursor internally) was that I could simplify things after fb gained
> > >> refcnt'ing.
> > >
> > > Unless I'm missing something, I'd say moving to fb objects instead of
> > > GEM objects won't simplify the code much (I'm already refcnt'ing GEM
> > > objects when launching a DMA transfer for a plane update).
> > 
> > yeah, mostly just saves you a bit of bookkeeping.  Ie. ref/unref one
> > thing instead of loop over N objects, etc.  Nothing earth-shattering.
> > 
> 
> Okay, my bad, this is definitely simpler with fb objects (I made use of
> drm_fb_cma_create to create an fb object when cursor_set is called)
> than it was when using GEM objects.
> 
> I might even be able to simplify the layer update mechanism with this
> approach.
> 
> Thanks for the advice.
> 
> Best Regards,
> 
> Boris

Hi Boris.

I haven't really looked at any of your driver in depth, but from a quick
glance it looks like you're registering a cursor drm_plane (i.e., making
use of the new universal plane infrastructure), but you're also
providing an implementation of the legacy cursor ioctls (cursor_set and
cursor_move).  There's some patches working their way through the
pipeline that should make this unnecessary and hopefully simplify your
life a bit:

        http://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-nightly&id=c394c2b08e247c32ef292b75fd8b34312465f8ae
        http://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-nightly&id=b36552b32aa9c69e83a3a20bda56379fb9e52435
        http://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-nightly&id=161d0dc1dccb17ff7a38f462c7c0d4ef8bcc5662
        http://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-nightly&id=fc1d3e44ef7c1db93384150fdbf8948dcf949f15

The third patch there is the one that's really important for your work.
When a driver provides a cursor plane via the universal plane interface,
cursor_set and cursor_move are automatically implemented for you by
drm_mode_cursor_universal() in drivers/gpu/drm/drm_crtc.c and your
legacy handlers will never get called.  drm_mode_cursor_universal() will
take care of wrapping the bo's into a drm_framebuffer for you.

When I added the universal cursor stuff, I wanted to make sure that as
soon as a driver starts supporting universal planes it can stop
supporting the legacy ioctls directly; otherwise handling refcounting
when userspace switches back and forth between calling legacy ioctl's
and calling setplane() on a cursor plane would be a nightmare.

I think those patches are only available in drm-intel-nightly at the
moment and haven't moved on to drm-next and such yet, since i915 is the
only driver that currently has patches to make use of cursors via the
univeral plane interface (probably landing for kernel 3.17).


Matt

-- 
Matt Roper
Graphics Software Engineer
IoTG Platform Enabling & Development
Intel Corporation
(916) 356-2795
