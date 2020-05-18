From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 06/16] backlight: improve backlight_device
 documentation
Date: Mon, 18 May 2020 18:58:43 +0100
Message-ID: <20200518175843.fw74gkdm4ib2w5is@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-7-sam@ravnborg.org>
 <20200518160324.mak4mhgyrgdbr7ww@holly.lan>
 <87o8ql2n1i.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87o8ql2n1i.fsf@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Jani Nikula <jani.nikula@intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Douglas Anderson <dianders@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirr
List-Id: linux-pwm@vger.kernel.org

On Mon, May 18, 2020 at 08:03:21PM +0300, Jani Nikula wrote:
> On Mon, 18 May 2020, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > On Sun, May 17, 2020 at 09:01:29PM +0200, Sam Ravnborg wrote:
> >> Improve the documentation for backlight_device and
> >> adapt it to kernel-doc style.
> >> 
> >> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> >> Cc: Jingoo Han <jingoohan1@gmail.com>
> >> ---
> >>  include/linux/backlight.h | 81 ++++++++++++++++++++++++++++-----------
> >>  1 file changed, 58 insertions(+), 23 deletions(-)
> >> 
> >> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> >> index 7f9cef299d6e..e2d72936bf05 100644
> >> --- a/include/linux/backlight.h
> >> +++ b/include/linux/backlight.h
> >> @@ -14,21 +14,6 @@
> >>  #include <linux/mutex.h>
> >>  #include <linux/notifier.h>
> >>  
> >> -/* Notes on locking:
> >> - *
> >> - * backlight_device->ops_lock is an internal backlight lock protecting the
> >> - * ops pointer and no code outside the core should need to touch it.
> >> - *
> >> - * Access to update_status() is serialised by the update_lock mutex since
> >> - * most drivers seem to need this and historically get it wrong.
> >> - *
> >> - * Most drivers don't need locking on their get_brightness() method.
> >> - * If yours does, you need to implement it in the driver. You can use the
> >> - * update_lock mutex if appropriate.
> >> - *
> >> - * Any other use of the locks below is probably wrong.
> >> - */
> >> -
> >>  enum backlight_update_reason {
> >>  	BACKLIGHT_UPDATE_HOTKEY,
> >>  	BACKLIGHT_UPDATE_SYSFS,
> >> @@ -221,30 +206,80 @@ struct backlight_properties {
> >>  	enum backlight_scale scale;
> >>  };
> >>  
> >> +/**
> >> + * struct backlight_device - backlight device data
> >> + *
> >> + * This structure holds all data required by a backlight device.
> >> + */
> >>  struct backlight_device {
> >> -	/* Backlight properties */
> >> +	/**
> >> +	 * @props:
> >> +	 *
> >
> > As last patch. Why no brief descriptions?
> 
> There are no "brief descriptions" in kernel-doc struct member inline
> markup.
> 
> It would be possible to shorten this to:
> 
> 	/**
> 	 * @props: Backlight properties
> 	 */

Sorry. Loose phrasing on my part... basically the question is why
deviate from the form proposed in "Writing kernel-doc comments"?


Daniel.



> >
> >> +	 * Backlight properties
> >> +	 */
> >>  	struct backlight_properties props;
> >>  
> >> -	/* Serialise access to update_status method */
> >> +	/**
> >> +	 * @update_lock:
> >> +	 *
> >> +	 * update_lock is an internal backlight lock that serialise access
> >> +	 * to the update_status() method. The iupdate_lock mutex shall not be used
> >> +	 * by backlight drivers.
> >
> > In addition to the typo this directly contradicts the advice in the
> > original "Notes on locking".
> >
> > A change this dramatic needs to be fully explaining in the patch
> > description.
> >
> >
> > Daniel.
> >
> >
> >> +	 */
> >>  	struct mutex update_lock;
> >>  
> >> -	/* This protects the 'ops' field. If 'ops' is NULL, the driver that
> >> -	   registered this device has been unloaded, and if class_get_devdata()
> >> -	   points to something in the body of that driver, it is also invalid. */
> >> +	/**
> >> +	 * @ops_lock:
> >> +	 *
> >> +	 * ops_lock is an internal backlight lock that protects the ops pointer
> >> +	 * and is used around all accesses to ops and when the operations are
> >> +	 * invoked. The mutex shall not be used by backlight drivers.
> >> +	 */
> >>  	struct mutex ops_lock;
> >> +
> >> +	/**
> >> +	 * @ops:
> >> +	 *
> >> +	 * Pointer to the backlight operations. If ops is NULL, the driver that
> >> +	 * registered this device has been unloaded, and if class_get_devdata()
> >> +	 * points to something in the body of that driver, it is also invalid.
> >> +	 */
> >>  	const struct backlight_ops *ops;
> >>  
> >> -	/* The framebuffer notifier block */
> >> +	/**
> >> +	 * @fb_notif:
> >> +	 *
> >> +	 * The framebuffer notifier block
> >> +	 */
> >>  	struct notifier_block fb_notif;
> >>  
> >> -	/* list entry of all registered backlight devices */
> >> +	/**
> >> +	 * @entry:
> >> +	 *
> >> +	 * List entry of all registered backlight devices
> >> +	 */
> >>  	struct list_head entry;
> >>  
> >> +	/**
> >> +	 * @dev:
> >> +	 *
> >> +	 * Parent device.
> >> +	 */
> >>  	struct device dev;
> >>  
> >> -	/* Multiple framebuffers may share one backlight device */
> >> +	/**
> >> +	 * @fb_bl_on:
> >> +	 *
> >> +	 * Multiple fbdev's may share one backlight device. The fb_bl_on
> >> +	 * records the state of the individual fbdev.
> >> +	 */
> >>  	bool fb_bl_on[FB_MAX];
> >>  
> >> +	/**
> >> +	 * @use_count:
> >> +	 *
> >> +	 * The number of uses of fb_bl_on.
> >> +	 */
> >>  	int use_count;
> >>  };
> >>  
> >> -- 
> >> 2.25.1
> >> 
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
