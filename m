From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v13 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Tue, 11 Jun 2019 17:25:33 +0200
Message-ID: <20190611152533.satxxae7dfrovgny@pengutronix.de>
References: <1560231884-15694-1-git-send-email-yash.shah@sifive.com>
 <1560231884-15694-3-git-send-email-yash.shah@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1560231884-15694-3-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, palmer@sifive.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, sachin.ghadi@sifive.com
List-Id: linux-pwm@vger.kernel.org

Hello,

On Tue, Jun 11, 2019 at 11:14:44AM +0530, Yash Shah wrote:
> [...]
> +static int pwm_sifive_remove(struct platform_device *dev)
> +{
> +	struct pwm_sifive_ddata *ddata = platform_get_drvdata(dev);
> +	bool is_enabled = false;
> +	struct pwm_device *pwm;
> +	int ret, ch;
> +
> +	for (ch = 0; ch < ddata->chip.npwm; ch++) {
> +		pwm = &ddata->chip.pwms[ch];
> +		if (pwm->state.enabled) {
> +			is_enabled = true;
> +			break;
> +		}
> +	}
> +	if (is_enabled)
> +		clk_disable(ddata->clk);
> +
> +	clk_disable_unprepare(ddata->clk);
> +	ret = pwmchip_remove(&ddata->chip);
> +	clk_notifier_unregister(ddata->clk, &ddata->notifier);
> +
> +	return ret;

I think the return value of a platform driver's remove callback is
ignored. So usually you should return 0.

Not sure this is worth addressing in a new round, so if noone else has
something to criticise that justifies a new round, take my

	Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

> +}

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
