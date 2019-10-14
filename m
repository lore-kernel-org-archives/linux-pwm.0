From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: sun4i: Fix incorrect calculation of
 duty_cycle/period
Date: Mon, 14 Oct 2019 18:23:35 +0200
Message-ID: <20191014162335.xgjy6kij2ippjc7h@pengutronix.de>
References: <20191014135303.2944058-1-megous@megous.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191014135303.2944058-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
To: megous@megous.com
Cc: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Mon, Oct 14, 2019 at 03:53:03PM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> Since 5.4-rc1, pwm_apply_state calls ->get_state after ->apply
> if available, and this revealed an issue with integer precision
> when calculating duty_cycle and period for the currently set
> state in ->get_state callback.
> 
> This issue manifested in broken backlight on several Allwinner
> based devices.
> 
> Previously this worked, because ->apply updated the passed state
> directly.
> 
> Fixes: deb9c462f4e53 ("pwm: sun4i: Don't update the state for the caller of pwm_apply_state")
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 6f5840a1a82d..05273725a9ff 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -137,10 +137,10 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
>  
>  	val = sun4i_pwm_readl(sun4i_pwm, PWM_CH_PRD(pwm->hwpwm));
>  
> -	tmp = prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
> +	tmp = (u64)prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
>  	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
>  
> -	tmp = prescaler * NSEC_PER_SEC * PWM_REG_PRD(val);
> +	tmp = (u64)prescaler * NSEC_PER_SEC * PWM_REG_PRD(val);
>  	state->period = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);

The issue is real and the fix looks right. So take my

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

There are a few more issues though:

- The dty value is calculated as (simplified):

    dty = prd * state->duty_cycle / state->period

  which gives suboptimal values in some cases.

- The algorithm does 2 divisions (and one too early) instead of a single
  one at the end, which is both ineffective and gives away precision.

- the test in sun4i_pwm_apply about cstate.period != state->period and
  the same for duty is probably less useful now because it compares
  requested values with actually implemented ones.

- it's unclear what the "surprising values" are that sun4i_pwm_calculate
  talks about in a comment. (And IMHO you should always round down.)

- Having a comment describing the implemented duty_cycle and period
  depending on how the registers are set would be helpful to understand
  the implemented algorithm.

- If there is a publically available datasheet adding a link to it in
  the header of the driver would be great.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
