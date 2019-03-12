From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v9 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Tue, 12 Mar 2019 10:17:39 +0100
Message-ID: <20190312091739.fhv2hb2ll2eamdsn@pengutronix.de>
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <1552378289-27245-3-git-send-email-yash.shah@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1552378289-27245-3-git-send-email-yash.shah@sifive.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Yash Shah <yash.shah@sifive.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, palmer@sifive.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, sachin.ghadi@sifive.com, thierry.reding@gmail.com, paul.walmsley@sifive.com, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

there are just a few minor things left I commented below.

On Tue, Mar 12, 2019 at 01:41:29PM +0530, Yash Shah wrote:
> +#define div_u64_round(a, b) \
> +	({typeof(b) __b =3D b; div_u64((a) + __b / 2, __b); })

Parenthesis around b please. I guess I didn't had them in my suggestion
either, sorry for that.

> +static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
> +{
> +	struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> +	int ret;
> +
> +	if (enable) {
> +		ret =3D clk_enable(pwm->clk);
> +		if (ret) {
> +			dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (!enable)
> +		clk_disable(pwm->clk);
> +
> +	return 0;
> +}

There is only a single caller for this function. I wonder if it is
trivial enough to fold it into pwm_sifive_apply.

> +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *de=
v,
> +			    struct pwm_state *state)
> +{
> +	struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chip);
> +	unsigned int duty_cycle;
> +	u32 frac;
> +	struct pwm_state cur_state;
> +	bool enabled;
> +	int ret =3D 0;
> +	unsigned long num;
> +
> +	if (state->polarity !=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	ret =3D clk_enable(pwm->clk);
> +	if (ret) {
> +		dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
> +		return ret;
> +	}
> +
> +	mutex_lock(&pwm->lock);
> +	pwm_get_state(dev, &cur_state);
> +
> +	enabled =3D cur_state.enabled;
> +
> +	if (state->period !=3D pwm->approx_period) {
> +		if (pwm->user_count !=3D 1) {
> +			ret =3D -EBUSY;
> +			goto exit;
> +		}
> +		pwm->approx_period =3D state->period;
> +		pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
> +	}
> +
> +	duty_cycle =3D state->duty_cycle;
> +	if (!state->enabled)
> +		duty_cycle =3D 0;
> +
> +	num =3D (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
> +	frac =3D div_u64_round(num, state->period);
> +	/* The hardware cannot generate a 100% duty cycle */
> +	frac =3D min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
> +
> +	writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 +
> +	       dev->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
> +
> +	if (state->enabled !=3D enabled) {
> +		ret =3D pwm_sifive_enable(chip, state->enabled);
> +		if (ret)
> +			goto exit;

This goto is a noop.

> +	}
> +
> +exit:
> +	clk_disable(pwm->clk);
> +	mutex_unlock(&pwm->lock);
> +	return ret;
> +}

There are a few other things that could be improved, but I think they
could be addressed later. For some of these I don't even know what to
suggest, for some Thierry might not agree it is worth fixing:

 - rounding
   how to round? When should a request declined, when is rounding ok?
   There is still "if (state->period !=3D pwm->approx_period) return -EBUSY"
   in this driver. This is better than before, but if state-period =3D=3D
   pwm->approx_period + 1 the result (if accepted) might be the same as
   without the +1 and so returning -EBUSY for one case and accepting the
   other is strange.
 - don't call PWM API functions designed for consumers (here: pwm_get_state)
 - Move div_u64_round to include/linux/math64.h

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
