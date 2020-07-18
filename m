From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v4 05/20] backlight: improve backlight_device
 documentation
Date: Sat, 18 Jul 2020 08:00:07 +0200
Message-ID: <20200718060007.GA2419852@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-6-sam@ravnborg.org>
 <SL2P216MB0105B428FFAB66BDA245B814AA7D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:43540 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgGRGAP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 18 Jul 2020 02:00:15 -0400
Content-Disposition: inline
In-Reply-To: <SL2P216MB0105B428FFAB66BDA245B814AA7D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jingoohan1@gmail.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>, Support

Hi Jingoo
On Sat, Jul 18, 2020 at 05:18:39AM +0000, Jingoo Han wrote:
> On 7/3/20, 2:46 PM, Sam Ravnborg wrote:
> >
> > Improve the documentation for backlight_device and
> > adapt it to kernel-doc style.
> >
> > The updated documentation is more strict on how locking is used.
> > With the update neither update_lock nor ops_lock may be used
> > outside the backlight core.
> > This restriction was introduced to keep the locking simple
> > by keeping it in the core.
> > It was verified that this documents the current state by renaming
> > update_lock => bl_update_lock and ops_lock => bl_ops_lock.
> > The rename did not reveal any uses outside the backlight core.
> > The rename is NOT part of this patch.
> >
> > v3:
> >   - Update changelog to explain locking details (Daniel)
> >
> > v2:
> >   - Add short intro to all fields (Daniel)
> >   - Updated description of update_lock (Daniel)
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>  > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> 
> It looks good!
> Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Thanks!

> 
> For the rebase, if you don't know which branch of maintainer's git can be used,
> linux-next tree [1] is useful. The linux-next git collects all next branches from 
> other maintainers' git every day.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/

I had used drm-misc-next because the original focus was to clean up
drivers in gpu/drm/ - and then I just continued to use this wrong tree.
linux-next is indeed a good place to catch the latest and greatest - but
as I now have the URL for the backlight tree (thanks to Lee) I will use it here.
Will try to find time this weekend so we can land these.

	Sam
