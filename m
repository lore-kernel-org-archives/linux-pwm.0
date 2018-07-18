From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix uninitialized variable
Date: Wed, 18 Jul 2018 14:08:53 +0100
Message-ID: <20180718130853.GE4641@dell>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
 <20180718080913.GB4641@dell>
 <1531902119.16896.13.camel@toradex.com>
 <20180718095335.GD4641@dell>
 <20180718101227.shqf54wpt4kdrsj2@holly.lan>
 <1531918626.16896.22.camel@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531918626.16896.22.camel@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "patches@linaro.org" <patches@linaro.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, 18 Jul 2018, Marcel Ziswiler wrote:

> On Wed, 2018-07-18 at 11:12 +0100, Daniel Thompson wrote:
> > On Wed, Jul 18, 2018 at 10:53:35AM +0100, Lee Jones wrote:
> > > On Wed, 18 Jul 2018, Marcel Ziswiler wrote:
> > > 
> > > > On Wed, 2018-07-18 at 09:09 +0100, Lee Jones wrote:
> > > > > On Mon, 16 Jul 2018, Daniel Thompson wrote:
> > > > > 
> > > > > > Currently, if the DT does not define num-interpolated-steps
> > > > > > then
> > > > > > num_steps is undefined and the interpolation code will deploy
> > > > > > randomly.
> > > > > > Fix this.
> > > > > > 
> > > > > > Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation
> > > > > > between
> > > > > > brightness-levels")
> > > > > > Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > > > > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > > > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > > > 
> > > > > This line is confusing.  Did you guys author this patch
> > > > > together?
> > > > 
> > > > Yes, I reported it and we came to a conclusion together.
> > > 
> > > It sounds like you need to have all of the tags (except this one).
> > > :)
> > > 
> > >  Reported-by:  for reporting the issue
> > >  Suggested-by: for suggesting a resolution
> > >  Acked-by:     for reviewing it
> > >  Tested-by:    for testing it
> > > 
> > > Signed-off-by usually means you either wrote a significant amount
> > > of
> > > the diffstat or you were part of the submission path.
> > 
> > He did [I don't object to but wouldn't have used the extra brackets
> > you
> > brought up ;-) ].
> 
> Yes, I take all the blame for the extra brackets. Regardless of having
> a masters in CS or not I still prefer too many then too few of them (;-
> p).
> 
> > > > > My guess is that this line should be dropped and the RB and TB
> > > > > tags
> > > > > should remain?  If it was reviewed too, perhaps an AB too?
> > > > 
> > > > I'm OK either way and do not need any explicit authorship to be
> > > > expressed for me.
> > > 
> > > In this instance I suggest keeping Reported-by and Tested-by.
> > > 
> > > > > > Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > > > > ---
> > > > > >  drivers/video/backlight/pwm_bl.c | 17 ++++++++---------
> > > > > >  1 file changed, 8 insertions(+), 9 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/video/backlight/pwm_bl.c
> > > > > > b/drivers/video/backlight/pwm_bl.c
> > > > > > index 9ee4c1b735b2..e3c22b79fbcd 100644
> > > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > > @@ -299,15 +299,14 @@ static int
> > > > > > pwm_backlight_parse_dt(struct
> > > > > > device *dev,
> > > > > >  		 * interpolation between each of the values
> > > > > > of
> > > > > > brightness levels
> > > > > >  		 * and creates a new pre-computed table.
> > > > > >  		 */
> > > > > > -		of_property_read_u32(node, "num-
> > > > > > interpolated-
> > > > > > steps",
> > > > > > -				     &num_steps);
> > > > > > -
> > > > > > -		/*
> > > > > > -		 * Make sure that there is at least two
> > > > > > entries in
> > > > > > the
> > > > > > -		 * brightness-levels table, otherwise we
> > > > > > can't
> > > > > > interpolate
> > > > > > -		 * between two points.
> > > > > > -		 */
> > > > > > -		if (num_steps) {
> > > > > > +		if ((of_property_read_u32(node, "num-
> > > > > > interpolated-
> > > > > > steps",
> > > > > > +					  &num_steps) == 0)
> > > > > > &&
> > > > > > num_steps) {
> > > > > 
> > > > > This is pretty ugly, and isn't it suffering from over-
> > > > > bracketing?  My
> > > > > suggestion would be to break out the invocation of
> > > > > of_property_read_u32() from the if and test only the result.
> > > > > 
> > > > > 		of_property_read_u32(node, "num-interpolated-
> > > > > steps", 
> > > > > &num_steps);
> > > > 
> > > > you mean:
> > > > 
> > > > 		ret = of_property_read_u32(node, "num-interpolated-
> > > > steps", &num_steps);
> > > > 
> > > > > 		if (!ret && num_steps) {
> > > > > 
> > > > > I haven't checked the underling code, but is it even feasible
> > > > > for
> > > > > of_property_read_u32() to not succeed AND for num_steps to be
> > > > > set?
> > > > > 
> > > > > If not, the check for !ret if superfluous and you can drop it.
> > > > 
> > > > No, then we are back to the initial issue of num_steps
> > > > potentially not
> > > > being initialised. We really want both of_property_read_u32() to
> > > > succeed AND num_steps to actually be set.
> > > 
> > > I also think num_steps should be pre-initialised.
> 
> Yes, I guess it definitely does not hurt.
> 
> > > Then it will only be set if of_property_read_u32() succeeds.
> 
> Yes, but we still need to check for both, the function not failing and
> num_steps to actually be non zero.

Why?  You don't do anything differently if it fails.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
