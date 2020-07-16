From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 05/20] backlight: improve backlight_device
 documentation
Date: Thu, 16 Jul 2020 16:09:23 +0100
Message-ID: <20200716150923.GY3165313@dell>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-6-sam@ravnborg.org>
 <20200716143941.GS3165313@dell>
 <20200716150021.GA1936267@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200716150021.GA1936267@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Daniel Thompson <daniel.thompson@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>
List-Id: linux-pwm@vger.kernel.org

On Thu, 16 Jul 2020, Sam Ravnborg wrote:

> Hi Lee.
> 
> On Thu, Jul 16, 2020 at 03:39:41PM +0100, Lee Jones wrote:
> > On Fri, 03 Jul 2020, Sam Ravnborg wrote:
> > 
> > > Improve the documentation for backlight_device and
> > > adapt it to kernel-doc style.
> > > 
> > > The updated documentation is more strict on how locking is used.
> > > With the update neither update_lock nor ops_lock may be used
> > > outside the backlight core.
> > > This restriction was introduced to keep the locking simple
> > > by keeping it in the core.
> > > It was verified that this documents the current state by renaming
> > > update_lock => bl_update_lock and ops_lock => bl_ops_lock.
> > > The rename did not reveal any uses outside the backlight core.
> > > The rename is NOT part of this patch.
> > > 
> > > v3:
> > >   - Update changelog to explain locking details (Daniel)
> > > 
> > > v2:
> > >   - Add short intro to all fields (Daniel)
> > >   - Updated description of update_lock (Daniel)
> > > 
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > ---
> > >  include/linux/backlight.h | 72 ++++++++++++++++++++++++++-------------
> > >  1 file changed, 49 insertions(+), 23 deletions(-)
> > 
> > Some of these do not apply cleanly.
> > 
> > Please collect the *-bys already received, rebase and resubmit.
> 
> Will do.
> The patch-set is based on drm-misc-next. Are there another
> tree that I should use?

I don't have anything to do with that tree.

Either Backlight [0] or Next would be fine.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
