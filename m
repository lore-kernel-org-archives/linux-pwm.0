From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/3] pwm: hibvt: Add hi3559v100 support
Date: Tue, 19 Feb 2019 08:38:07 +0100
Message-ID: <20190219073807.osevzhot6qdfvuke@pengutronix.de>
References: <20190213150508.11499-1-m.othacehe@gmail.com>
 <20190213150508.11499-3-m.othacehe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190213150508.11499-3-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Feb 13, 2019 at 04:05:08PM +0100, Mathieu Othacehe wrote:
> Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
> platforms. They require a special quirk: pwm has to be enabled again
> to force duty_cycle refresh.
> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> ---
>  drivers/pwm/pwm-hibvt.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
> index ffc803818c3c..b6a7942b3367 100644
> --- a/drivers/pwm/pwm-hibvt.c
> +++ b/drivers/pwm/pwm-hibvt.c
> @@ -54,6 +54,7 @@ struct hibvt_pwm_chip {
>  
>  struct hibvt_pwm_soc {
>  	u32 num_pwms;
> +	bool quirk_force_enable;
>  };
>  
>  static const struct hibvt_pwm_soc hi3516cv300_soc_info = {
> @@ -64,6 +65,16 @@ static const struct hibvt_pwm_soc hi3519v100_soc_info = {
>  	.num_pwms = 8,
>  };
>  
> +static const struct hibvt_pwm_soc hi3559v100_shub_soc_info = {
> +	.num_pwms = 8,
> +	.quirk_force_enable = true,
> +};
> +
> +static const struct hibvt_pwm_soc hi3559v100_soc_info = {
> +	.num_pwms = 2,
> +	.quirk_force_enable = true,
> +};
> +
>  static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
>  {
>  	return container_of(chip, struct hibvt_pwm_chip, chip);
> @@ -152,13 +163,24 @@ static void hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  static int hibvt_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  				struct pwm_state *state)
>  {
> +	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
> +
>  	if (state->polarity != pwm->state.polarity)
>  		hibvt_pwm_set_polarity(chip, pwm, state->polarity);
>  
>  	if (state->period != pwm->state.period ||
> -		state->duty_cycle != pwm->state.duty_cycle)
> +		state->duty_cycle != pwm->state.duty_cycle) {
>  		hibvt_pwm_config(chip, pwm, state->duty_cycle, state->period);

I would prefer to have the continued line in the if condition aligned to
the opening parenthesis. Then it is optically separated from the first
expression in the body of the if.

>  
> +		/*
> +		 * On those platforms, it is required to enable the

Which platforms? I think in a previous round it was obvious what was
meant here because there was a test against two specific compatibles.
Now something like

	Some implementations require the pwm to be enabled once more
	each time the duty cycle is refreshed.

would be more suitable.

Is there a publicly available reference manual available for the newly
supported hardware?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
