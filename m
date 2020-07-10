From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] [stable v5.4.x] pwm: jz4740: Fix build failure
Date: Fri, 10 Jul 2020 12:48:36 +0200
Message-ID: <DB8C7C01-0FBB-4A9F-B068-15C06BBC0873@goldelico.com>
References: <20200710102758.8341-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200710102758.8341-1-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, linux-mips@vger.kernel.org, tsbogend@alpha.franken.de
List-Id: linux-pwm@vger.kernel.org


> Am 10.07.2020 um 12:27 schrieb Uwe Kleine-König <u.kleine-koenig@pengutronix.de>:
> 
> When commit 9017dc4fbd59 ("pwm: jz4740: Enhance precision in calculation
> of duty cycle") from v5.8-rc1 was backported to v5.4.x its dependency on
> commit ce1f9cece057 ("pwm: jz4740: Use clocks from TCU driver") was not
> noticed which made the pwm-jz4740 driver fail to build.

Please can you add my "reported by?"

> As ce1f9cece057 depends on still more rework, just backport a small part
> of this commit to make the driver build again. (There is no dependency
> on the functionality introduced in ce1f9cece057, just the rate variable
> is needed.)

BR and thanks,
Nikolaus

> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> @Paul: Can you please check this is correct? I only build-tested this
> change.
> 
> Best regards
> Uwe
> 
> drivers/pwm/pwm-jz4740.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index d0f5c69930d0..77c28313e95f 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -92,11 +92,12 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> {
> 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
> 	unsigned long long tmp;
> -	unsigned long period, duty;
> +	unsigned long rate, period, duty;
> 	unsigned int prescaler = 0;
> 	uint16_t ctrl;
> 
> -	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * state->period;
> +	rate = clk_get_rate(jz4740->clk);
> +	tmp = rate * state->period;
> 	do_div(tmp, 1000000000);
> 	period = tmp;
> 
> -- 
> 2.27.0
> 
