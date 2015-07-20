From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 11/15] pwm: add the core infrastructure to allow
 atomic update
Date: Mon, 20 Jul 2015 11:48:27 +0200
Message-ID: <20150720114827.2e5d52a5@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<1435738921-25027-12-git-send-email-boris.brezillon@free-electrons.com>
	<20150720085939.GL29614@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20150720085939.GL29614@ulmo>
Sender: linux-leds-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, 20 Jul 2015 10:59:40 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Jul 01, 2015 at 10:21:57AM +0200, Boris Brezillon wrote:
> > Add an ->apply() method to the pwm_ops struct to allow PWM drivers to
> > implement atomic update.
> > This method will be prefered over the ->enable(), ->disable() and
> > ->config() methods if available.
> > 
> > Add the pwm_get_state(), pwm_get_default_state() and pwm_apply_state()
> > functions for PWM users to be able to use the atomic update feature.
> > 
> > Note that the pwm_apply_state() does not guarantee the atomicity of the
> > update operation, it all depends on the availability and implementation
> > of the ->apply() method.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/pwm/core.c  | 110 ++++++++++++++++++++++++++++++++++++++++++++++------
> >  include/linux/pwm.h |  26 +++++++++++++
> >  2 files changed, 124 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 30631f5..6dafd8e 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -238,8 +238,9 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
> >  	unsigned int i;
> >  	int ret;
> >  
> > -	if (!chip || !chip->dev || !chip->ops || !chip->ops->config ||
> > -	    !chip->ops->enable || !chip->ops->disable || !chip->npwm)
> > +	if (!chip || !chip->dev || !chip->ops || (!chip->ops->apply &&
> > +	    (!chip->ops->config || !chip->ops->enable ||
> > +	     !chip->ops->disable)) || !chip->npwm)
> >  		return -EINVAL;
> 
> This is becoming really unreadable, perhaps split it into two checks, or
> even split out the sanity check on the ops into a separate function to
> make the negations easier to read:
> 
> 	static bool pwm_ops_check(const struct pwm_ops *ops)
> 	{
> 		/* driver supports legacy, non-atomic operation */
> 		if (ops->config && ops->enable && ops->disable)
> 			return true;
> 
> 		/* driver supports atomic operation */
> 		if (ops->apply)
> 			return true;
> 
> 		return false;
> 	}
> 
> and then use this:
> 
> 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
> 		return -EINVAL;
> 
> 	if (!pwm_ops_check(chip->ops))
> 		return -EINVAL;
> 

Sure, I'll change that to make it more readable.

> >  	mutex_lock(&pwm_lock);
> > @@ -430,7 +431,17 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> >  	if (!pwm || duty_ns < 0 || period_ns <= 0 || duty_ns > period_ns)
> >  		return -EINVAL;
> >  
> > -	err = pwm->chip->ops->config(pwm->chip, pwm, duty_ns, period_ns);
> > +	if (pwm->chip->ops->apply) {
> > +		struct pwm_state state = pwm->state;
> 
> Shouldn't this use pwm_get_state()?

Yes, I'll fix all of them

[...]

> 
> > +
> > +		state.enabled = true;
> > +		err = pwm->chip->ops->apply(pwm->chip, pwm, &state);
> 
> There should be a space between the above two lines.

I'll add an empty line.


> 
> >  
> > +int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
> > +{
> > +	int err = 0;
> > +
> > +	if (!pwm)
> > +		return -EINVAL;
> > +
> > +	if (!memcmp(state, &pwm->state, sizeof(*state)))
> > +		return 0;
> > +
> > +	if (pwm->chip->ops->apply) {
> > +		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
> > +		if (!err)
> > +			pwm->state = *state;
> 
> Maybe we want pwm_set_state() for this?

I'm not opposed to the addition of the pwm_set_state() function as long
as it's a private one: I don't want to let PMW drivers or users mess up
with the current PWM state.

> 
> > +	} else {
> > +		/*
> > +		 * FIXME: restore the initial state in case of error.
> > +		 */
> > +		if (state->polarity != pwm->state.polarity) {
> > +			pwm_disable(pwm);
> > +			err = pwm_set_polarity(pwm, state->polarity);
> > +			if (err)
> > +				goto out;
> > +		}
> > +
> > +		if (state->period != pwm->state.period ||
> > +		    state->duty_cycle != pwm->state.duty_cycle) {
> > +			err = pwm_config(pwm, state->period, state->duty_cycle);
> > +			if (err)
> > +				goto out;
> > +		}
> > +
> > +		if (state->enabled != pwm->state.enabled) {
> > +			if (state->enabled)
> > +				err = pwm_enable(pwm);
> > +			else
> > +				pwm_disable(pwm);
> > +		}
> > +	}
> > +
> > +out:
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(pwm_apply_state);
> > +
> >  static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
> >  {
> >  	struct pwm_chip *chip;
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index b47244a..7e99679 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -151,6 +151,29 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
> >  	return pwm ? pwm->state.polarity : PWM_POLARITY_NORMAL;
> >  }
> >  
> > +/*
> > + * pwm_apply_state - apply a new state to the PWM device
> > + */
> > +int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
> 
> If you add kerneldoc, please add it properly. It should start with /**
> and you need to list at least the parameters and return value.

Yes, I'll fix that.
BTW, I remember that you were expecting another name for this function
(pwm_update IIRC).



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
