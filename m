From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 6/6] ARM: PWM: add allwinner sun8i R40/T3/V40 PWM
 support.
Date: Mon, 3 Dec 2018 10:49:08 +0100
Message-ID: <20181203094908.lga2r56gelaghrej@pengutronix.de>
References: <20181125162319.GA5422@arx-s1>
 <20181126213158.q5m5bbwnmewud2gb@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126213158.q5m5bbwnmewud2gb@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Hao Zhang <hao5781286@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org, thierry.reding@gmail.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-pwm@vger.kernel.org

Hello,

On Mon, Nov 26, 2018 at 10:31:58PM +0100, Uwe Kleine-König wrote:
> > +static int sun8i_pwm_config(struct sun8i_pwm_chip *sun8i_pwm, u8 ch,
> > +			    struct pwm_state *state)
> > +{
> > +[...]
> > +		clk_rate = clk_get_rate(clk);
> > +		val = state->period * clk_rate;
> > +		do_div(val, NSEC_PER_SEC);
> > +		if (val <= 1) {
> > +			dev_err(sun8i_pwm->chip.dev,
> > +				"Period expects a larger value\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		/* change clock source to "mux-1" */
> > +		clk_disable_unprepare(sun8i_pwm->clk);
> > +		devm_clk_put(sun8i_pwm->chip.dev, sun8i_pwm->clk);
> > +		sun8i_pwm->clk = clk;
> 
> sun8i_pwm is shared for all 8 PWMs, right? So if you assign mux-1 here
> for the second mux, how does this influence the first PWM?

To clearify my question:

after the first pwm is used and enabled (maybe using mux-0) changing
sun8i_pwm->clk for the second pwm is broken because then when the first
pwm is disabled the wrong clock is stopped.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
