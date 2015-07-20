From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 10/15] pwm: add the PWM initial state retrieval
 infra
Date: Mon, 20 Jul 2015 11:42:11 +0200
Message-ID: <20150720114211.155c3579@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<1435738921-25027-11-git-send-email-boris.brezillon@free-electrons.com>
	<20150720090123.GM29614@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150720090123.GM29614@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, 20 Jul 2015 11:01:24 +0200
Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Wed, Jul 01, 2015 at 10:21:56AM +0200, Boris Brezillon wrote:
> > Add a ->init_state() function to the pwm_ops struct to let PWM drivers
> > initialize the PWM state attached to a PWM device.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  drivers/pwm/core.c  | 3 +++
> >  include/linux/pwm.h | 2 ++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 3e830ce..30631f5 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -264,6 +264,9 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
> >  		pwm->hwpwm = i;
> >  		pwm_set_default_polarity(pwm, polarity);
> >  
> > +		if (chip->ops->init_state)
> > +			chip->ops->init_state(chip, pwm);
> > +
> >  		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
> >  	}
> >  
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index 0f36a06..b47244a 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -177,6 +177,8 @@ struct pwm_ops {
> >  					  struct pwm_device *pwm);
> >  	void			(*disable)(struct pwm_chip *chip,
> >  					   struct pwm_device *pwm);
> > +	void			(*init_state)(struct pwm_chip *chip,
> > +					      struct pwm_device *pwm);
> 
> I think I'd call this reset_state. init has this connotation of setting
> a set of default values. For reset it's clearer in my opinion that it's
> resetting to the hardware state.

I'm fine with the reset_state name, I'll change that in my v2.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
