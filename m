From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 01/13] pwm: Add new helpers to create/manipulate PWM
 states
Date: Fri, 10 Jun 2016 18:29:42 +0200
Message-ID: <20160610182942.5e7485ff@bbrezillon>
References: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
	<1465403688-17098-2-git-send-email-boris.brezillon@free-electrons.com>
	<20160610152109.GQ27142@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36365 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932855AbcFJQ35 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Jun 2016 12:29:57 -0400
In-Reply-To: <20160610152109.GQ27142@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>

Hi Thierry,

On Fri, 10 Jun 2016 17:21:09 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Jun 08, 2016 at 06:34:36PM +0200, Boris Brezillon wrote:
> > The pwm_prepare_new_state() helper prepares a new state object
> > containing the current PWM state except for the polarity and period
> > fields which are set to the reference values.
> > This is particurly useful for PWM users who want to apply a new
> > duty-cycle expressed relatively to the reference period without
> > changing the enable state.
> > 
> > The PWM framework expect PWM users to configure the duty cycle in
> > nanosecond, but most users just want to express this duty cycle
> > relatively to the period value (i.e. duty_cycle = 33% of the period).
> > Add pwm_{get,set}_relative_duty_cycle() helpers to ease this kind of
> > conversion.  
> 
> This looks pretty useful and good, though I think these could be two
> separate patches. A couple of suggestions on wording and such below.

Sure, I can split those changes.

> 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  include/linux/pwm.h | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> > 
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index 17018f3..e09babf 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -148,6 +148,87 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
> >  }
> >  
> >  /**
> > + * pwm_prepare_new_state() - prepare a new state to be applied with
> > + *			     pwm_apply_state()  
> 
> This is weirdly indented.

I'll fix the indentation.

> 
> > + * @pwm: PWM device
> > + * @state: state to fill with the prepared PWM state
> > + *
> > + * This functions prepares a state that can later be tweaked and applied
> > + * to the PWM device with pwm_apply_state(). This is a convenient function
> > + * that first retrieves the current PWM state and the replaces the period
> > + * and polarity fields with the reference values defined in pwm->args.
> > + * Once the new state is created you can adjust the ->enable and ->duty_cycle  
> 
> "created" has the connotation of allocating. Perhaps: "Once the function
> returns, you can adjust the ->enabled and ->duty_cycle fields according
> to your needs before calling pwm_apply_state()."?

Okay.

> 
> Also note that the field is called ->enabled.
> 
> > + * according to your need before calling pwm_apply_state().  
> 
> Maybe mention that the ->duty_cycle field is explicitly zeroed. Then
> again, do we really need it? If users are going to overwrite it anyway,
> do we even need to bother? I suppose it makes some sense because the
> current duty cycle is stale when the ->period gets set to the value from
> args. I think the documentation should mention this in some way.

Yes, if we keep the current duty_cycle it can exceed the period value.
I'm fine dropping the ->duty_cycle = 0 assignment and documenting the
behavior.

> 
> > + */
> > +static inline void pwm_prepare_new_state(const struct pwm_device *pwm,
> > +					 struct pwm_state *state)  
> 
> Perhaps choose a shorter name, such as: pwm_init_state()?

Sure.

> 
> > +{
> > +	struct pwm_args args;
> > +
> > +	/* First get the current state. */
> > +	pwm_get_state(pwm, state);
> > +
> > +	/* Then fill it with the reference config */
> > +	pwm_get_args(pwm, &args);
> > +
> > +	state->period = args.period;
> > +	state->polarity = args.polarity;
> > +	state->duty_cycle = 0;
> > +}
> > +
> > +/**
> > + * pwm_get_relative_duty_cycle() - Get a relative duty_cycle value
> > + * @state: the PWM state to extract period and duty_cycle from
> > + * @scale: the scale you want to use for you relative duty_cycle value  
> 
> Other kerneldoc comments in this file don't prefix the description with
> "the".
> 
> Also, perhaps the following descriptions would be slightly less
> confusing:
> 
> 	@state: PWM state to extract the duty cycle from

Agreed.

> 
> We don't extract (i.e. return) period from the state, so it's a little
> confusing to mention it here.
> 
> 	@scale: scale in which to return the relative duty cycle
> 
> This is slightly more explicit in that it says what the returned duty
> cycle will be in. Perhaps as an alternative:
> 
> 	@scale: target scale of the relative duty cycle

I'll go for this one.

> 
> > + *
> > + * This functions converts the absolute duty_cycle stored in @state
> > + * (expressed in nanosecond) into a relative value.  
> 
> Perhaps: "... into a value relative to the period."?

Okay.

> 
> > + * For example if you want to get the duty_cycle expressed in nanosecond,  
> 
> The example below would give you the duty cycle in percent, not
> nanoseconds, right?

Absolutely. I'll fix that.

> 
> > + * call:
> > + *
> > + * pwm_get_state(pwm, &state);
> > + * duty = pwm_get_relative_duty_cycle(&state, 100);
> > + */
> > +static inline unsigned int
> > +pwm_get_relative_duty_cycle(const struct pwm_state *state, unsigned int scale)
> > +{
> > +	if (!state->period)
> > +		return 0;
> > +
> > +	return DIV_ROUND_CLOSEST_ULL((u64)state->duty_cycle * scale,
> > +				     state->period);
> > +}
> > +
> > +/**
> > + * pwm_set_relative_duty_cycle() - Set a relative duty_cycle value
> > + * @state: the PWM state to fill
> > + * @val: the relative duty_cycle value
> > + * @scale: the scale you use for you relative duty_cycle value  
> 
> "scale in which @duty_cycle is expressed"?

Yep.

> 
> > + *
> > + * This functions converts a relative duty_cycle stored into an absolute
> > + * one (expressed in nanoseconds), and put the result in state->duty_cycle.
> > + * For example if you want to change configure a 50% duty_cycle, call:
> > + *
> > + * pwm_prepare_new_state(pwm, &state);
> > + * pwm_set_relative_duty_cycle(&state, 50, 100);
> > + * pwm_apply_state(pwm, &state);
> > + */
> > +static inline void
> > +pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int val,  
> 
> Any reason why we can't call "val" "duty_cycle"? That's what it is,
> after all.

Nope, I'll switch to duty_cycle.

> 
> > +			    unsigned int scale)
> > +{
> > +	if (!scale)
> > +		return;
> > +
> > +	/* Make sure we don't have duty_cycle > period */
> > +	if (val > scale)
> > +		val = scale;  
> 
> Can we return -EINVAL for both of the above checks? I don't like
> silently clamping the duty cycle that the user passed in.

I'm fine returning -EINVAL in this case.

Thanks for rewording some of my sentences and reviewing the patch.

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
