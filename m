From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 10/14] regulator: pwm: Switch to the atomic PWM API
Date: Fri, 3 Jun 2016 13:50:28 -0700
Message-ID: <20160603205028.GH124478@google.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-11-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1464942192-25967-11-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

+ Laxman

Hi,

On Fri, Jun 03, 2016 at 10:23:08AM +0200, Boris Brezillon wrote:
> Use the atomic API wherever appropriate and get rid of pwm_apply_args()
> call (the reference period and polarity are now explicitly set when
> calling pwm_apply_state()).
> 
> We also make use of the pwm_set_relative_duty_cycle() helper to ease
> relative to absolute duty_cycle conversion.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/regulator/pwm-regulator.c | 38 ++++++++++----------------------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
> index 524b43f..bf033fd 100644
> --- a/drivers/regulator/pwm-regulator.c
> +++ b/drivers/regulator/pwm-regulator.c
> @@ -59,16 +59,14 @@ static int pwm_regulator_set_voltage_sel(struct regulator_dev *rdev,
>  					 unsigned selector)
>  {
>  	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
> -	struct pwm_args pargs;
> -	int dutycycle;
> +	struct pwm_state pstate;
>  	int ret;
>  
> -	pwm_get_args(drvdata->pwm, &pargs);
> +	pwm_prepare_new_state(drvdata->pwm, &pstate);
> +	pwm_set_relative_duty_cycle(&pstate,
> +			drvdata->duty_cycle_table[selector].dutycycle, 100);
>  
> -	dutycycle = (pargs.period *
> -		    drvdata->duty_cycle_table[selector].dutycycle) / 100;
> -
> -	ret = pwm_config(drvdata->pwm, dutycycle, pargs.period);
> +	ret = pwm_apply_state(drvdata->pwm, &pstate);
>  	if (ret) {
>  		dev_err(&rdev->dev, "Failed to configure PWM: %d\n", ret);
>  		return ret;
> @@ -126,34 +124,18 @@ static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
>  {
>  	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
>  	unsigned int ramp_delay = rdev->constraints->ramp_delay;
> -	struct pwm_args pargs;
>  	unsigned int req_diff = min_uV - rdev->constraints->min_uV;
> +	struct pwm_state pstate;
>  	unsigned int diff;
> -	unsigned int duty_pulse;
> -	u64 req_period;
> -	u32 rem;
>  	int ret;
>  
> -	pwm_get_args(drvdata->pwm, &pargs);
> +	pwm_prepare_new_state(drvdata->pwm, &pstate);
>  	diff = rdev->constraints->max_uV - rdev->constraints->min_uV;
>  
> -	/* First try to find out if we get the iduty cycle time which is
> -	 * factor of PWM period time. If (request_diff_to_min * pwm_period)
> -	 * is perfect divided by voltage_range_diff then it is possible to
> -	 * get duty cycle time which is factor of PWM period. This will help
> -	 * to get output voltage nearer to requested value as there is no
> -	 * calculation loss.
> -	 */
> -	req_period = req_diff * pargs.period;
> -	div_u64_rem(req_period, diff, &rem);
> -	if (!rem) {
> -		do_div(req_period, diff);
> -		duty_pulse = (unsigned int)req_period;
> -	} else {
> -		duty_pulse = (pargs.period / 100) * ((req_diff * 100) / diff);
> -	}
> +	/* We pass diff as the scale to get a uV precision. */
> +	pwm_set_relative_duty_cycle(&pstate, req_diff, diff);

Notably, you're dropping much of Laxman's commit fd786fb0276a ("regulator:
pwm: Try to avoid voltage error in duty cycle calculation"), but I
believe the DIV_ROUND_CLOSEST_ULL() in pwm_set_relative_duty_cycle()
solves his problem better.

>  
> -	ret = pwm_config(drvdata->pwm, duty_pulse, pargs.period);
> +	ret = pwm_apply_state(drvdata->pwm, &pstate);
>  	if (ret) {
>  		dev_err(&rdev->dev, "Failed to configure PWM: %d\n", ret);
>  		return ret;

Reviewed-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Tested-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
