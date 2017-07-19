From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 1/2] drivers: pwm: core: implement pwm mode
Date: Wed, 19 Jul 2017 15:13:26 +0300
Message-ID: <c29f8ef1-662f-ab95-b793-06fb07c1c86e@microchip.com>
References: <1494332153-14534-1-git-send-email-claudiu.beznea@microchip.com>
 <1494332153-14534-2-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:7907 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbdGSMNw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2017 08:13:52 -0400
In-Reply-To: <1494332153-14534-2-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "corbet@lwn.net" <corbet@lwn.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>, "boris.brezillon@free-electrons.com" <boris.brezillon@free-electrons.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>

Hello Thierry,

I know you may be very busy but do you have any resolution regarding
this series and the one with title
"[PATCH v2 0/2] extends PWM framework to support PWM dead-times"

Thank you,
Claudiu

On 09.05.2017 15:15, Claudiu Beznea - M18063 wrote:
> Extends PWM framework to support PWM modes. The currently
> implemented PWM modes were called PWM complementary mode
> and PWM push-pull mode. For devices that have more than one
> output per PWM channel:
> - PWM complementary mode is standard working mode; in PWM
> complementary mode the rising and falling edges of the
> channels outputs have opposite levels, same duration and
> same starting time.
> - in PWM push-pull mode the channles outputs has same levels,
> same duration and the rising edges are delayed until the
> beginning of the next period.
> A new member was added in pwm_state structure in order to
> keep the new PWM argument.
> For PWM channels with inputs in DT, the mode could also be
> passed via DT. No new extra field need to be added in device
> tree; since the signal polarity is passed as a flag via DT,
> the field used to pass information for PWM channel polarity
> via DT is also used by PWM mode. Since, for the moment, only
> the complementary and push-pull modes are implemented, only
> one bit in flags used to pass polarity could also be used for
> PWM mode. The other drivers are not affected by this change.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/pwm.txt         | 24 +++++++++++++++++---
>  drivers/pwm/core.c            | 13 +++++++++--
>  drivers/pwm/sysfs.c           | 52 +++++++++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/pwm/pwm.h |  1 +
>  include/linux/pwm.h           | 37 ++++++++++++++++++++++++++++--
>  5 files changed, 120 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
> index 789b27c..1b6fc59 100644
> --- a/Documentation/pwm.txt
> +++ b/Documentation/pwm.txt
> @@ -59,9 +59,9 @@ In addition to the PWM state, the PWM API also exposes PWM arguments, which
>  are the reference PWM config one should use on this PWM.
>  PWM arguments are usually platform-specific and allows the PWM user to only
>  care about dutycycle relatively to the full period (like, duty = 50% of the
> -period). struct pwm_args contains 2 fields (period and polarity) and should
> -be used to set the initial PWM config (usually done in the probe function
> -of the PWM user). PWM arguments are retrieved with pwm_get_args().
> +period). struct pwm_args contains 3 fields (period, polarity and mode) and
> +should be used to set the initial PWM config (usually done in the probe
> +function of the PWM user). PWM arguments are retrieved with pwm_get_args().
>  
>  Using PWMs with the sysfs interface
>  -----------------------------------
> @@ -100,6 +100,24 @@ enable - Enable/disable the PWM signal (read/write).
>  	0 - disabled
>  	1 - enabled
>  
> +mode - Set PWM signal type (for channels with more than one output
> +       per channel)
> +	complementary - for an output signal as follow:
> +                         __    __    __    __
> +                PWMH1 __|  |__|  |__|  |__|  |__
> +                      __    __    __    __    __
> +                PWML1   |__|  |__|  |__|  |__|
> +                        <--T-->
> +		Where T is the signal period.
> +
> +	push-pull - for an output signal as follows:
> +                         __          __
> +                PWMH1 __|  |________|  |________
> +                               __          __
> +                PWML1 ________|  |________|  |__
> +                        <--T-->
> +		Where T is the signal period.
> +
>  Implementing a PWM driver
>  -------------------------
>  
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index a0860b3..4efc92d 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -154,9 +154,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
>  
>  	pwm->args.period = args->args[1];
>  	pwm->args.polarity = PWM_POLARITY_NORMAL;
> +	pwm->args.mode = PWM_MODE_COMPLEMENTARY;
>  
> -	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
> -		pwm->args.polarity = PWM_POLARITY_INVERSED;
> +	if (args->args_count > 2) {
> +		if (args->args[2] & PWM_POLARITY_INVERTED)
> +			pwm->args.polarity = PWM_POLARITY_INVERSED;
> +		if (args->args[2] & PWM_MODE_PUSHPULL)
> +			pwm->args.mode = PWM_MODE_PUSH_PULL;
> +	}
>  
>  	return pwm;
>  }
> @@ -579,6 +584,8 @@ int pwm_adjust_config(struct pwm_device *pwm)
>  	pwm_get_args(pwm, &pargs);
>  	pwm_get_state(pwm, &state);
>  
> +	state.mode = pargs.mode;
> +
>  	/*
>  	 * If the current period is zero it means that either the PWM driver
>  	 * does not support initial state retrieval or the PWM has not yet
> @@ -997,6 +1004,8 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
>  		seq_printf(s, " duty: %u ns", state.duty_cycle);
>  		seq_printf(s, " polarity: %s",
>  			   state.polarity ? "inverse" : "normal");
> +		seq_printf(s, " mode: %s",
> +			   state.mode ? "push-pull" : "complementary");
>  
>  		seq_puts(s, "\n");
>  	}
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index a813239..58f02bf 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -223,11 +223,62 @@ static ssize_t capture_show(struct device *child,
>  	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
>  }
>  
> +static ssize_t mode_show(struct device *child,
> +			 struct device_attribute *attr,
> +			 char *buf)
> +{
> +	const struct pwm_device *pwm = child_to_pwm_device(child);
> +	const char *mode = "unknown";
> +	struct pwm_state state;
> +
> +	pwm_get_state(pwm, &state);
> +
> +	switch (state.mode) {
> +	case PWM_MODE_COMPLEMENTARY:
> +		mode = "complementary";
> +		break;
> +
> +	case PWM_MODE_PUSH_PULL:
> +		mode = "push-pull";
> +		break;
> +	}
> +
> +	return sprintf(buf, "%s\n", mode);
> +}
> +
> +static ssize_t mode_store(struct device *child,
> +			  struct device_attribute *attr,
> +			  const char *buf, size_t size)
> +{
> +	struct pwm_export *export = child_to_pwm_export(child);
> +	struct pwm_device *pwm = export->pwm;
> +	enum pwm_mode mode;
> +	struct pwm_state state;
> +	int ret;
> +
> +	if (sysfs_streq(buf, "complementary"))
> +		mode = PWM_MODE_COMPLEMENTARY;
> +	else if (sysfs_streq(buf, "push-pull"))
> +		mode = PWM_MODE_PUSH_PULL;
> +	else
> +		return -EINVAL;
> +
> +	mutex_lock(&export->lock);
> +	pwm_get_state(pwm, &state);
> +	state.mode = mode;
> +	ret = pwm_apply_state(pwm, &state);
> +	mutex_unlock(&export->lock);
> +
> +	return ret ? : size;
> +}
> +
>  static DEVICE_ATTR_RW(period);
>  static DEVICE_ATTR_RW(duty_cycle);
>  static DEVICE_ATTR_RW(enable);
>  static DEVICE_ATTR_RW(polarity);
>  static DEVICE_ATTR_RO(capture);
> +static DEVICE_ATTR_RW(mode);
>  
>  static struct attribute *pwm_attrs[] = {
>  	&dev_attr_period.attr,
> @@ -235,6 +286,7 @@ static struct attribute *pwm_attrs[] = {
>  	&dev_attr_enable.attr,
>  	&dev_attr_polarity.attr,
>  	&dev_attr_capture.attr,
> +	&dev_attr_mode.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(pwm);
> diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
> index 96f49e8..83bb884 100644
> --- a/include/dt-bindings/pwm/pwm.h
> +++ b/include/dt-bindings/pwm/pwm.h
> @@ -10,5 +10,6 @@
>  #define _DT_BINDINGS_PWM_PWM_H
>  
>  #define PWM_POLARITY_INVERTED			(1 << 0)
> +#define PWM_MODE_PUSHPULL			(1 << 1)
>  
>  #endif
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 08fad7c..d924e55 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -25,9 +25,23 @@ enum pwm_polarity {
>  };
>  
>  /**
> + * enum pwm_mode - PWM mode
> + * @PWM_MODE_COMPLEMENTARY: rising and falling edges of the complementary
> + * PWM channels have opposite levels, same duration and same starting time
> + * @PWM_MODE_PUSH_PULL: rising and falling edges of the complementary PWM
> + * channels have same levels, same duration and are delayed until the
> + * beginning of the next period
> + */
> +enum pwm_mode {
> +	PWM_MODE_COMPLEMENTARY,
> +	PWM_MODE_PUSH_PULL,
> +};
> +
> +/**
>   * struct pwm_args - board-dependent PWM arguments
>   * @period: reference period
>   * @polarity: reference polarity
> + * @mode: pwm mode
>   *
>   * This structure describes board-dependent arguments attached to a PWM
>   * device. These arguments are usually retrieved from the PWM lookup table or
> @@ -40,6 +54,7 @@ enum pwm_polarity {
>  struct pwm_args {
>  	unsigned int period;
>  	enum pwm_polarity polarity;
> +	enum pwm_mode mode;
>  };
>  
>  enum {
> @@ -52,12 +67,14 @@ enum {
>   * @period: PWM period (in nanoseconds)
>   * @duty_cycle: PWM duty cycle (in nanoseconds)
>   * @polarity: PWM polarity
> + * @mode: PWM mode
>   * @enabled: PWM enabled status
>   */
>  struct pwm_state {
>  	unsigned int period;
>  	unsigned int duty_cycle;
>  	enum pwm_polarity polarity;
> +	enum pwm_mode mode;
>  	bool enabled;
>  };
>  
> @@ -143,6 +160,21 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
>  	return state.polarity;
>  }
>  
> +static inline void pwm_set_mode(struct pwm_device *pwm, enum pwm_mode mode)
> +{
> +	if (pwm)
> +		pwm->state.mode = mode;
> +}
> +
> +static inline enum pwm_mode pwm_get_mode(const struct pwm_device *pwm)
> +{
> +	struct pwm_state state;
> +
> +	pwm_get_state(pwm, &state);
> +
> +	return state.mode;
> +}
> +
>  static inline void pwm_get_args(const struct pwm_device *pwm,
>  				struct pwm_args *args)
>  {
> @@ -156,8 +188,8 @@ static inline void pwm_get_args(const struct pwm_device *pwm,
>   *
>   * This functions prepares a state that can later be tweaked and applied
>   * to the PWM device with pwm_apply_state(). This is a convenient function
> - * that first retrieves the current PWM state and the replaces the period
> - * and polarity fields with the reference values defined in pwm->args.
> + * that first retrieves the current PWM state and the replaces the period,
> + * polarity and mode fields with the reference values defined in pwm->args.
>   * Once the function returns, you can adjust the ->enabled and ->duty_cycle
>   * fields according to your needs before calling pwm_apply_state().
>   *
> @@ -180,6 +212,7 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
>  	state->period = args.period;
>  	state->polarity = args.polarity;
>  	state->duty_cycle = 0;
> +	state->mode = args.mode;
>  }
>  
>  /**
> 
