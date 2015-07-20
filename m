From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 06/15] pwm: define a new pwm_state struct
Date: Mon, 20 Jul 2015 12:12:52 +0200
Message-ID: <20150720121252.559d286a@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<1435738921-25027-7-git-send-email-boris.brezillon@free-electrons.com>
	<20150720080458.GG29614@ulmo>
	<20150720120116.2358b829@bbrezillon>
	<20150720100925.GX29614@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20150720100925.GX29614@ulmo>
Sender: linux-leds-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, 20 Jul 2015 12:09:26 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Jul 20, 2015 at 12:01:16PM +0200, Boris Brezillon wrote:
> > On Mon, 20 Jul 2015 10:04:59 +0200
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> > 
> > > On Wed, Jul 01, 2015 at 10:21:52AM +0200, Boris Brezillon wrote:
> > > [...]
> > > > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > > [...]
> > > > +struct pwm_state {
> > > > +	unsigned int		period; 	/* in nanoseconds */
> > > > +	unsigned int		duty_cycle;	/* in nanoseconds */
> > > > +	enum pwm_polarity	polarity;
> > > > +};
> > > 
> > > No need for the extra padding here.
> > 
> > What do you mean by "extra padding" ?
> > I just reused the indentation used in the pwm_device struct.
> 
> Yeah, I have a local patch to fix that up. I find it useless to pad
> things like this, and it has the downside that it will become totally
> inconsistent (or cause a lot of churn by reformatting) if ever you add a
> field that extends beyond the padding. Single spaces don't have any such
> drawbacks and, in my opinion, look just as good.

I prefer the single space approach too, so I won't complain ;-).

> 
> > Would you prefer something like that ?
> > 
> > struct pwm_state {
> > 	unsigned int period; 		/* in nanoseconds */
> > 	unsigned int duty_cycle;	/* in nanoseconds */
> > 	enum pwm_polarity polarity;
> > };
> 
> Yeah. I'd say even the comments would be more suited in a kerneldoc-
> style comment:
> 
> 	/**
> 	 * struct pwm_state - state of a PWM channel
> 	 * @period: PWM period (in nanoseconds)
> 	 * @duty_cycle: PWM duty cycle (in nanoseconds)
> 	 * @polarity: PWM polarity
> 	 */
> 	struct pwm_state {
> 		unsigned int period;
> 		unsigned int duty_cycle;
> 		enum pwm_polarity polarity;
> 	};
> 
> This is something that users will need to deal with, so eventually
> somebody might look at this via some DocBook generated HTML or PDF.

I agree.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
