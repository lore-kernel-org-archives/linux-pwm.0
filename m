From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/3] pwm: core: add consumer device link
Date: Mon, 11 Feb 2019 20:06:28 +0100
Message-ID: <20190211190628.eisyi6wjus4ltrrn@pengutronix.de>
References: <1549901522-15071-1-git-send-email-fabrice.gasnier@st.com>
 <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1549901522-15071-4-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, tduszyns@gmail.com, mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

Hello Fabrice,

On Mon, Feb 11, 2019 at 05:12:02PM +0100, Fabrice Gasnier wrote:
> Add a device link between the PWM consumer and the PWM provider. This
> enforces the PWM user to get suspended before the PWM provider. It
> allows proper synchronization of suspend/resume sequences: the PWM user
> is responsible for properly stopping PWM, before the provider gets
> suspended: see [1]. Add the device link in:
> - pwm_get()
> - devm_pwm_get()
> - devm_of_pwm_get()
> as it requires a reference to the device for the PWM consumer.
> 
> [1] https://lkml.org/lkml/2019/2/5/770
> 
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6a..2835e27 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -770,8 +770,13 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>  	int err;
>  
>  	/* look up via DT first */
> -	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
> -		return of_pwm_get(dev->of_node, con_id);
> +	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node) {
> +		pwm = of_pwm_get(dev->of_node, con_id);
> +		if (!IS_ERR(pwm))
> +			device_link_add(dev, pwm->chip->dev,
> +					DL_FLAG_AUTOREMOVE_CONSUMER);
> +		return pwm;
> +	}
>  
>  	/*
>  	 * We look up the provider in the static table typically provided by
> @@ -851,6 +856,8 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>  	pwm->args.period = chosen->period;
>  	pwm->args.polarity = chosen->polarity;
>  
> +	device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> +
>  	return pwm;
>  }
>  EXPORT_SYMBOL_GPL(pwm_get);
> @@ -943,6 +950,8 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
>  	if (!IS_ERR(pwm)) {
>  		*ptr = pwm;
>  		devres_add(dev, ptr);
> +		device_link_add(dev, pwm->chip->dev,
> +				DL_FLAG_AUTOREMOVE_CONSUMER);

IMHO it's surprising that devm_of_pwm_get() does more than of_pwm_get()
+ devres stuff. I'd put device_link_add() into of_pwm_get().

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
