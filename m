From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 3/3] pwm: core: add consumer device link
Date: Mon, 18 Feb 2019 18:22:23 +0100
Message-ID: <20190218172223.lw3e5tn5hzsow6tg@pengutronix.de>
References: <1550139951-25788-1-git-send-email-fabrice.gasnier@st.com>
 <1550139951-25788-4-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550139951-25788-4-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, tduszyns@gmail.com, mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

Hello,

On Thu, Feb 14, 2019 at 11:25:51AM +0100, Fabrice Gasnier wrote:
> Add a device link between the PWM consumer and the PWM provider. This
> enforces the PWM user to get suspended before the PWM provider. It
> allows proper synchronization of suspend/resume sequences: the PWM user
> is responsible for properly stopping PWM, before the provider gets
> suspended: see [1]. Add the device link in:
> - of_pwm_get()
> - pwm_get()
> - devm_*pwm_get() variants
> as it requires a reference to the device for the PWM consumer.
> 
> [1] https://lkml.org/lkml/2019/2/5/770
> 
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v4:
> - rework error handling following Thierry's comments
> - turn/split pr_debug() into dev_err()/pr_warn().
> 
> Changes in v3:
> - add struct device to of_get_pwm() arguments to handle device link from
>   there as discussed with Uwe.
> ---
>  drivers/pwm/core.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/pwm.h |  6 ++++--
>  2 files changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6a..64e10a6 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -636,8 +636,35 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
>  	return ERR_PTR(-EPROBE_DEFER);
>  }
>  
> +static struct device_link *pwm_device_link_add(struct device *dev,
> +					       struct pwm_device *pwm)
> +{
> +	struct device_link *dl;
> +
> +	if (!dev) {
> +		/*
> +		 * No device for the PWM consumer has been provided. It may
> +		 * impact the PM sequence ordering: the PWM supplier may get
> +		 * suspended before the consumer.
> +		 */
> +		pr_warn("no consumer dev, can't create device link to %s\n",
> +			dev_name(pwm->chip->dev));

Maybe use dev_warn(pwm->chip->dev, ...) ?

> +		return NULL;
> +	}
> +
> +	dl = device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> +	if (!dl) {
> +		dev_err(dev, "failed to create device link to %s\n",
> +			dev_name(pwm->chip->dev));
> +			return ERR_PTR(-EINVAL);

broken indention.

> +	}
> +
> +	return dl;
> +}
> +

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
