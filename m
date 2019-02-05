From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
Date: Tue, 5 Feb 2019 21:47:32 +0100
Message-ID: <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: jic23@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, mcoquelin.stm32@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

Hello,

On Tue, Feb 05, 2019 at 01:40:27PM +0100, Fabrice Gasnier wrote:
> Add suspend/resume PM sleep ops. When going to low power, disable
> active PWM channel. Active PWM channel is resumed, by calling
> pwm_apply_state(). This is inspired by Thierry's comment in [1].
> Don't touch inactive channels, as it may be used by other LPTimer MFD
> child driver.
> [1]https://lkml.org/lkml/2017/12/5/175
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index 0059b24c..0c40d48 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -13,6 +13,7 @@
>  #include <linux/mfd/stm32-lptimer.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  
> @@ -20,6 +21,8 @@ struct stm32_pwm_lp {
>  	struct pwm_chip chip;
>  	struct clk *clk;
>  	struct regmap *regmap;
> +	struct pwm_state suspend;
> +	bool suspended;
>  };
>  
>  static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
> @@ -223,6 +226,40 @@ static int stm32_pwm_lp_remove(struct platform_device *pdev)
>  	return pwmchip_remove(&priv->chip);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int stm32_pwm_lp_suspend(struct device *dev)
> +{
> +	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
> +
> +	pwm_get_state(&priv->chip.pwms[0], &priv->suspend);
> +	priv->suspended = priv->suspend.enabled;
> +
> +	/* safe to call pwm_disable() for already disabled pwm */
> +	pwm_disable(&priv->chip.pwms[0]);
> +
> +	return pinctrl_pm_select_sleep_state(dev);

IMHO a PWM should not stop if the PWM user didn't call pwm_disable() (or
pwm_apply_state() with .enabled = false).

I don't understand all the PM details, but I think there is no defined
order in which devices are signalled to suspend. If so the PWM might be
stopped before its consumer. Then the PWM changes state without the
consumer being aware of that.

I understand Thierry's position in the link you provided in the commit
log consistant with my position here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
