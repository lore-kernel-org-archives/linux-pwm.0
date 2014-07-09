From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RESEND PATCH v3 05/11] drm: add Atmel HLCDC Display Controller
 support
Date: Wed, 9 Jul 2014 16:02:51 +0200
Message-ID: <20140709140251.GU17271@phenom.ffwll.local>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1404751384-5077-6-git-send-email-boris.brezillon@free-electrons.com>
 <CAF6AEGtttUFquRQrhFKtEKq+frAAmzp4AVtF5gixVkMmJNC68g@mail.gmail.com>
 <20140708092348.4ecdbb8f@bbrezillon>
 <CAF6AEGuUz7Td-9Hh31rYpn_Zros=ozK_ttv9FadHot6qAuaq1Q@mail.gmail.com>
 <20140708163731.6693a883@bbrezillon>
 <CAF6AEGuOYQbZ_Mgv+Y7oQO4kKmOEF=gwi0YcBXERE80nS2QL+g@mail.gmail.com>
 <20140708190820.2a94723f@bbrezillon>
 <20140708235124.GM31728@intel.com>
 <20140709091424.167b8f16@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:60859 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbaGIOCm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Jul 2014 10:02:42 -0400
Received: by mail-wg0-f51.google.com with SMTP id y10so2764212wgg.22
        for <linux-pwm@vger.kernel.org>; Wed, 09 Jul 2014 07:02:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140709091424.167b8f16@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Matt Roper <matthew.d.roper@intel.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Samuel Ortiz <sameo@linux.intel.com>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Nicolas Ferre <nicolas.ferre@atmel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Tim Niemeyer <tim.niemeyer@corscience.de>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Andrew Victor <linux@maxim.org.za>

On Wed, Jul 09, 2014 at 09:14:24AM +0200, Boris BREZILLON wrote:
> Hi Matt,
> 
> On Tue, 8 Jul 2014 16:51:24 -0700
> Matt Roper <matthew.d.roper@intel.com> wrote:
> 
> > Hi Boris.
> > 
> > I haven't really looked at any of your driver in depth, but from a quick
> > glance it looks like you're registering a cursor drm_plane (i.e., making
> > use of the new universal plane infrastructure), but you're also
> > providing an implementation of the legacy cursor ioctls (cursor_set and
> > cursor_move).  There's some patches working their way through the
> > pipeline that should make this unnecessary and hopefully simplify your
> > life a bit:
> > 
> >         http://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-nightly&id=c394c2b08e247c32ef292b75fd8b34312465f8ae
> >         http://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-nightly&id=b36552b32aa9c69e83a3a20bda56379fb9e52435
> >         http://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-nightly&id=161d0dc1dccb17ff7a38f462c7c0d4ef8bcc5662
> >         http://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-nightly&id=fc1d3e44ef7c1db93384150fdbf8948dcf949f15
> > 
> > The third patch there is the one that's really important for your work.
> > When a driver provides a cursor plane via the universal plane interface,
> > cursor_set and cursor_move are automatically implemented for you by
> > drm_mode_cursor_universal() in drivers/gpu/drm/drm_crtc.c and your
> > legacy handlers will never get called.  drm_mode_cursor_universal() will
> > take care of wrapping the bo's into a drm_framebuffer for you.
> > 
> > When I added the universal cursor stuff, I wanted to make sure that as
> > soon as a driver starts supporting universal planes it can stop
> > supporting the legacy ioctls directly; otherwise handling refcounting
> > when userspace switches back and forth between calling legacy ioctl's
> > and calling setplane() on a cursor plane would be a nightmare.
> > 
> > I think those patches are only available in drm-intel-nightly at the
> > moment and haven't moved on to drm-next and such yet, since i915 is the
> > only driver that currently has patches to make use of cursors via the
> > univeral plane interface (probably landing for kernel 3.17).
> 
> That's great news. I knew there were some work in progress on this
> topic, but didn't know it was planned for 3.17. 
> 
> I'll move to this solution.

As of today those patches have landed in Dave's drm-next branch.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
