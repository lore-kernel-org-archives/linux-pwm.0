From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v9 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Tue, 12 Mar 2019 14:17:12 +0100
Message-ID: <20190312131712.rxiarnthcfrsgdqn@pengutronix.de>
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <1552378289-27245-3-git-send-email-yash.shah@sifive.com>
 <20190312091739.fhv2hb2ll2eamdsn@pengutronix.de>
 <20190312121218.GM31026@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312121218.GM31026@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Yash Shah <yash.shah@sifive.com>, palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 12, 2019 at 01:12:18PM +0100, Thierry Reding wrote:
> On Tue, Mar 12, 2019 at 10:17:39AM +0100, Uwe Kleine-König wrote:
> > Hello,
> > 
> > there are just a few minor things left I commented below.
> > 
> > On Tue, Mar 12, 2019 at 01:41:29PM +0530, Yash Shah wrote:
> > > +#define div_u64_round(a, b) \
> > > +	({typeof(b) __b = b; div_u64((a) + __b / 2, __b); })
> > 
> > Parenthesis around b please. I guess I didn't had them in my suggestion
> > either, sorry for that.
> 
> We don't really need the parentheses here, do we? The only operator that
> has lower priority than the assignment is the comma operator, and that's
> not going to work in the macro anyway, unless you put it inside a pair
> of parentheses, in which case, well, you have the parentheses already.

I thought that, too, but using parenthesis just always is a safe bet and
prevents people stumbling over this and spending time to come to the
conclusion that it is actually safe without them.

> > > +static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
> > > +{
> > > +	struct pwm_sifive_ddata *pwm = pwm_sifive_chip_to_ddata(chip);
> > > +	int ret;
> > > +
> > > +	if (enable) {
> > > +		ret = clk_enable(pwm->clk);
> > > +		if (ret) {
> > > +			dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	if (!enable)
> > > +		clk_disable(pwm->clk);
> > > +
> > > +	return 0;
> > > +}
> > 
> > There is only a single caller for this function. I wonder if it is
> > trivial enough to fold it into pwm_sifive_apply.
> 
> I think this is fine. pwm_sifive_apply() is already fairly long at this
> point, so might as well split things up a little.

I don't have a strong opinion here, so keeping as is is fine for me.

> > There are a few other things that could be improved, but I think they
> > could be addressed later. For some of these I don't even know what to
> > suggest, for some Thierry might not agree it is worth fixing:
> > 
> >  - rounding
> >    how to round? When should a request declined, when is rounding ok?
> >    There is still "if (state->period != pwm->approx_period) return -EBUSY"
> >    in this driver. This is better than before, but if state-period ==
> >    pwm->approx_period + 1 the result (if accepted) might be the same as
> >    without the +1 and so returning -EBUSY for one case and accepting the
> >    other is strange.
> 
> Perhaps a good idea would be to reject a configuration only after we've
> determined that it is incompatible? If we're really going to end up with
> the same configuration within a given margin of period or duty cycle and
> we can't do much about it, there's little point in rejecting such
> configurations.

It seems we agree here. Is this important enough to delay taking this
driver further? Currently the driver rejects too broad so if it annoys
someone this can still be fixed later and there is only little harm
(assuming correct error handling in the consumers).

> >  - don't call PWM API functions designed for consumers (here: pwm_get_state)
> 
> Agreed. The driver can just access pwm_device.state directly.

I wouldn't do this either. IMHO the driver should only look into its
hardware registers instead of using framework interna (or consumer API
calls).

> >  - Move div_u64_round to include/linux/math64.h
> 
> Looks to me like DIV_ROUND_CLOSEST_ULL() is already pretty much this.
> The only difference that I can see is that the divisor is 32-bit, but
> since we pass in state->period, that already works fine.

num (i.e. the divident) should be a u64, but it isn't. This needs
fixing. But I agree that DIV_ROUND_CLOSEST_ULL should be good enough
then.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
