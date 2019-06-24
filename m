From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
Date: Mon, 24 Jun 2019 12:28:44 +0100
Message-ID: <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
References: <20190522163428.7078-1-paul@crapouillou.net>
 <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
 <20190621135608.GB11839@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621135608.GB11839@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Paul Cercueil <paul@crapouillou.net>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, od@zcrc.me, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 21, 2019 at 03:56:08PM +0200, Thierry Reding wrote:
> On Fri, Jun 21, 2019 at 01:41:45PM +0100, Daniel Thompson wrote:
> > On 22/05/2019 17:34, Paul Cercueil wrote:
> > > When the driver probes, the PWM pin is automatically configured to its
> > > default state, which should be the "pwm" function.
> > 
> > At which point in the probe... and by who?
> 
> The driver core will select the "default" state of a device right before
> calling the driver's probe, see:
> 
> 	drivers/base/pinctrl.c: pinctrl_bind_pins()
> 
> which is called from:
> 
> 	drivers/base/dd.c: really_probe()
> 

Thanks. I assumed it would be something like that... although given
pwm-backlight is essentially a wrapper driver round a PWM I wondered why
the pinctrl was on the backlight node (rather than the PWM node).

Looking at the DTs in the upstream kernel it looks like ~20% of the
backlight drivers have pinctrl on the backlight node. Others presumable
have none or have it on the PWM node (and it looks like support for
sleeping the pins is *very* rare amoung the PWM drivers).


> > > However, at this
> > > point we don't know the actual level of the pin, which may be active or
> > > inactive. As a result, if the driver probes without enabling the
> > > backlight, the PWM pin might be active, and the backlight would be
> > > lit way before being officially enabled.
> > > 
> > > To work around this, if the probe function doesn't enable the backlight,
> > > the pin is set to its sleep state instead of the default one, until the
> > > backlight is enabled. Whenk the backlight is disabled, the pin is reset
> > > to its sleep state.
> > Doesn't this workaround result in a backlight flash between whatever enables
> > it and the new code turning it off again?
> 
> Yeah, I think it would. I guess if you're very careful on how you set up
> the device tree you might be able to work around it. Besides the default
> and idle standard pinctrl states, there's also the "init" state. The
> core will select that instead of the default state if available. However
> there's also pinctrl_init_done() which will try again to switch to the
> default state after probe has finished and the driver didn't switch away
> from the init state.
> 
> So you could presumably set up the device tree such that you have three
> states defined: "default" would be the one where the PWM pin is active,
> "idle" would be used when backlight is off (PWM pin inactive) and then
> another "init" state that would be the same as "idle" to be used during
> probe. During probe the driver could then switch to the "idle" state so
> that the pin shouldn't glitch.
> 
> I'm not sure this would actually work because I think the way that
> pinctrl handles states both "init" and "idle" would be the same pointer
> values and therefore pinctrl_init_done() would think the driver didn't
> change away from the "init" state because it is the same pointer value
> as the "idle" state that the driver selected. One way to work around
> that would be to duplicate the "idle" state definition and associate one
> instance of it with the "idle" state and the other with the "init"
> state. At that point both states should be different (different pointer
> values) and we'd get the init state selected automatically before probe,
> select "idle" during probe and then the core will leave it alone. That's
> of course ugly because we duplicate the pinctrl state in DT, but perhaps
> it's the least ugly solution.
> Adding Linus for visibility. Perhaps he can share some insight.

To be honest I'm happy to summarize in my head as "if it flashes then it's not
a pwm_bl.c's problem" ;-).


Daniel.


> 
> On that note, I'm wondering if perhaps it'd make sense for pinctrl to
> support some mode where a device would start out in idle mode. That is,
> where pinctrl_bind_pins() would select the "idle" mode as the default
> before probe. With something like that we could easily support this
> use-case without glitching.
> 
> I suppose yet another variant would be for the PWM backlight to not use
> any of the standard pinctrl states at all. Instead it could just define
> custom states, say "active" and "inactive". Looking at the code that
> would prevent pinctrl_bind_pins() from doing anything with pinctrl
> states and given the driver exact control over when each of the states
> will be selected. That's somewhat suboptimal because we can't make use
> of the pinctrl PM helpers and it'd require more boilerplate.
> 
> Thierry
> 
> > > Signed-off-by: Paul Cercueil <paul@crapouillou.net> > ---
> > >   drivers/video/backlight/pwm_bl.c | 9 +++++++++
> > >   1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > index fb45f866b923..422f7903b382 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -16,6 +16,7 @@
> > >   #include <linux/module.h>
> > >   #include <linux/kernel.h>
> > >   #include <linux/init.h>
> > > +#include <linux/pinctrl/consumer.h>
> > >   #include <linux/platform_device.h>
> > >   #include <linux/fb.h>
> > >   #include <linux/backlight.h>
> > > @@ -50,6 +51,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
> > >   	struct pwm_state state;
> > >   	int err;
> > > +	pinctrl_pm_select_default_state(pb->dev);
> > > +
> > >   	pwm_get_state(pb->pwm, &state);
> > >   	if (pb->enabled)
> > >   		return;
> > > @@ -90,6 +93,8 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> > >   	regulator_disable(pb->power_supply);
> > >   	pb->enabled = false;
> > > +
> > > +	pinctrl_pm_select_sleep_state(pb->dev);
> > >   }
> > >   static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
> > > @@ -626,6 +631,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> > >   	backlight_update_status(bl);
> > >   	platform_set_drvdata(pdev, bl);
> > > +
> > > +	if (bl->props.power == FB_BLANK_POWERDOWN)
> > > +		pinctrl_pm_select_sleep_state(&pdev->dev);
> > 
> > Didn't backlight_update_status(bl) already do this?
> > 
> > 
> > Daniel.
> > 
> > 
> > > +
> > >   	return 0;
> > >   err_alloc:
> > > 
> > 
