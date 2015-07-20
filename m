From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 08/15] backlight: pwm_bl: remove useless call to
 pwm_set_period
Date: Mon, 20 Jul 2015 11:57:04 +0200
Message-ID: <20150720115704.0c64d070@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<1435738921-25027-9-git-send-email-boris.brezillon@free-electrons.com>
	<20150720081559.GI29614@ulmo>
	<20150720102143.05949ca2@bbrezillon>
	<20150720083648.GK29614@ulmo>
	<20150720105003.29b5813a@bbrezillon>
	<20150720091003.GN29614@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46398 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752598AbbGTJ5I (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 05:57:08 -0400
In-Reply-To: <20150720091003.GN29614@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>

On Mon, 20 Jul 2015 11:10:04 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Jul 20, 2015 at 10:50:03AM +0200, Boris Brezillon wrote:
> > On Mon, 20 Jul 2015 10:36:50 +0200
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> > 
> > > On Mon, Jul 20, 2015 at 10:21:43AM +0200, Boris Brezillon wrote:
> > > > On Mon, 20 Jul 2015 10:16:00 +0200
> > > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > 
> > > > > On Wed, Jul 01, 2015 at 10:21:54AM +0200, Boris Brezillon wrote:
> > > > > > The PWM period will be set when calling pwm_config. Remove this useless
> > > > > > call to pwm_set_period, which might mess up with the initial PWM state
> > > > > > once we have added proper support for PWM init state retrieval.
> > > > > > 
> > > > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > > > ---
> > > > > >  drivers/video/backlight/pwm_bl.c | 4 +---
> > > > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > > > > index ae498c1..fe5597c 100644
> > > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > > @@ -295,10 +295,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> > > > > >  	 * via the PWM lookup table.
> > > > > >  	 */
> > > > > >  	pb->period = pwm_get_default_period(pb->pwm);
> > > > > > -	if (!pb->period && (data->pwm_period_ns > 0)) {
> > > > > > +	if (!pb->period && (data->pwm_period_ns > 0))
> > > > > >  		pb->period = data->pwm_period_ns;
> > > > > > -		pwm_set_period(pb->pwm, data->pwm_period_ns);
> > > > > > -	}
> > > > > >  
> > > > > >  	pb->lth_brightness = data->lth_brightness * (pb->period / pb->scale);
> > > > > 
> > > > > As far as I remember this line is there in order to pass in a period if
> > > > > the backlight driver is initialized from board setup files. In such a
> > > > > case there won't be an period associated with the PWM channel in the
> > > > > first place.
> > > > > 
> > > > > I think even with the introduction of a default period, we'd be missing
> > > > > out on the board setup case because there is no standard place where it
> > > > > is being set, so it must come from the platform data.
> > > > 
> > > > AFAICT, we don't need to explicitly set the period when probing the
> > > > backlight device, because it will be set next time we call
> > > > pwm_config(), and since we're passing pb->period when calling
> > > > pwm_config() everything should be fine.
> > > 
> > > Calling pwm_set_period() is still good for consistency. Consider for
> > > example what happens if after the driver were to call pwm_get_period().
> > > It would return some more or less random value (likely 0 or whatever it
> > > had been set to by an earlier user).
> > 
> > Yes, that's true in general, but in this specific driver
> > pwm_get_period() is never called, and the driver only relies on the
> > pb->period value.
> 
> Perhaps that's something that should change. If the PWM core has all
> this infrastructure there should be no need for the backlight driver to
> keep it's own copy of that variable.

Yes, probably. In any case, I don't think we want PWM users to be able
to mess up with the current or default PWM state, that's why I was
planning on making the pwm_set_default_xxx helpers private to PWM
drivers and core infrastructure.

Also note that if we keep this assignment it should at least be changed
to a pwm_set_default_period() so that it does not override the current
PWM state.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
