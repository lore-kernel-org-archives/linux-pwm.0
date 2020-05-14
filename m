From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 08/18] backlight: add backlight_is_blank()
Date: Thu, 14 May 2020 22:03:49 +0200
Message-ID: <20200514200349.GD206103@phenom.ffwll.local>
References: <20200514191001.457441-1-sam@ravnborg.org>
 <20200514191001.457441-9-sam@ravnborg.org>
 <20200514194116.GB206103@phenom.ffwll.local>
 <20200514194646.GA460099@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200514194646.GA460099@ravnborg.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, Kate Stewart <kstewart@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Russell King <linux@armlinux.org.uk>, Andy Gross <agross@kernel.org>, Uwe Kleine Konig <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Bartlomiej Zolnierkiewicz <b.zo>
List-Id: linux-pwm@vger.kernel.org

On Thu, May 14, 2020 at 09:46:46PM +0200, Sam Ravnborg wrote:
> Hi Daniel.
> 
> On Thu, May 14, 2020 at 09:41:16PM +0200, Daniel Vetter wrote:
> > On Thu, May 14, 2020 at 09:09:51PM +0200, Sam Ravnborg wrote:
> > > The backlight support has two properties that express the state:
> > > - power
> > > - state
> > > 
> > > It is un-documented and easy to get wrong.
> > > Add backlight_is_blank() helper to make it simpler for drivers
> > > to get the check of the state correct.
> > > 
> > > A lot of drivers also includes checks for fb_blank.
> > > This check is redundant when the state is checked
> > > as thus not needed in this helper function.
> > > Rolling out this helper to all relevant backlight drivers
> > > will eliminate almost all accesses to fb_blank.
> > > 
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > ---
> > >  include/linux/backlight.h | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> > > index b7839ea9d00a..e67e926de1e2 100644
> > > --- a/include/linux/backlight.h
> > > +++ b/include/linux/backlight.h
> > > @@ -165,6 +165,23 @@ static inline int backlight_disable(struct backlight_device *bd)
> > >  	return backlight_update_status(bd);
> > >  }
> > >  
> > > +/**
> > > + * backlight_is_blank - Return true if display is expected to be blank
> > > + * @bd: the backlight device
> > > + *
> > > + * Display is expected to be blank if any of these is true::
> > > + *
> > > + *   1) if power in not UNBLANK
> > > + *   2) if state indicate BLANK or SUSPENDED
> > > + *
> > > + * Returns true if display is expected to be blank, false otherwise.
> > > + */
> > > +static inline bool backlight_is_blank(struct backlight_device *bd)
> > > +{
> > > +	return bd->props.power != FB_BLANK_UNBLANK ||
> > > +	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
> > 
> > This definition here doesn't match backlight_enabled/disable() functions
> > we added. I think to avoid lots of pondering and surprises we should try
> > to make sure these are all matching, so that once we rolled them out
> > everywhere, we can just replace the complicated state with one flag.
> 
> Will add it in v2. When all user of fb_blank is dropped we can
> safely remove it then.
> And as you said on irc, the risk of introducing regressions is lower
> as we see some creative uses in the drivers today.
> I already did some kind of audit - but I may have missed something.

btw one pattern I've seen in a few places with a few greps I've just done
is maybe worth putting into a helper too:

backlight_force_enable(bl)
{
	if (bl->brightness == 0)
		bl->brightness = bl->max_brightness;
	backlight_enable(backlight);
}

Just in case you run out of ideas anytime soon :-)

Cheers, Daniel

> 
> 	Sam
> 
> > 
> > > +}
> > > +
> > >  extern struct backlight_device *backlight_device_register(const char *name,
> > >  	struct device *dev, void *devdata, const struct backlight_ops *ops,
> > >  	const struct backlight_properties *props);
> > > -- 
> > > 2.25.1
> > > 
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
