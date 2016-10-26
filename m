From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] backlight: pwm_bl: Move the checks for initial power
 state to a separate function
Date: Wed, 26 Oct 2016 16:02:37 +0300
Message-ID: <fd224a5e-9487-eabf-a68f-bbd3ae49f8ef@ti.com>
References: <20160930070259.5710-1-peter.ujfalusi@ti.com>
 <20160930070259.5710-2-peter.ujfalusi@ti.com> <20161026121258.GQ8574@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43614 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753228AbcJZNCx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Oct 2016 09:02:53 -0400
In-Reply-To: <20161026121258.GQ8574@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: thierry.reding@gmail.com, jingoohan1@gmail.com, tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de

On 10/26/16 15:12, Lee Jones wrote:
> On Fri, 30 Sep 2016, Peter Ujfalusi wrote:
> 
>> Move the check for gpio and regulator initial state to a new function and
>> document better what we are checking and why.
>>
>> It is going to be easier to fix or improve the initial power state
>> configuration later and it is easier to read the code.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/video/backlight/pwm_bl.c | 55 +++++++++++++++++++++++++---------------
>>  1 file changed, 35 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
>> index b2b366bb0f97..9bc4715bf116 100644
>> --- a/drivers/video/backlight/pwm_bl.c
>> +++ b/drivers/video/backlight/pwm_bl.c
>> @@ -192,6 +192,40 @@ static int pwm_backlight_parse_dt(struct device *dev,
>>  }
>>  #endif
>>  
>> +static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
>> +{
>> +	struct device_node *node = pb->dev->of_node;
>> +
>> +	/* Not booted with device tree or no phandle link to the node */
>> +	if (!node || !node->phandle)
>> +		return FB_BLANK_UNBLANK;
> 
> This changes the semantics of the current implementation.
> 
> In the code you're removing, if the enable_gpio is present and no DT
> is found, we set the GPIO direction to output.  In your implementation,
> if no DT is found you don't do anything regardless.
> 
> Is that intentional?

Argh, no, it is not intentional.

It should have been like this:

	/* Not booted with device tree or no phandle link to the node */
	if (!node || !node->phandle) {
		/* Set enable GPIO if it is valid */
		if (pb->enable_gpio)
			gpiod_direction_output(pb->enable_gpio, 1);

		return FB_BLANK_UNBLANK;
	}

On the other hand we are not doing the same for the regulator in case of non
DT boot or when the backlight has no users. So we do enable the GPIO, but the
regulator might be left disabled...

I'll resend the series with this change.

> 
>> +	/*
>> +	 * If the driver is probed from the device tree and there is a
>> +	 * phandle link pointing to the backlight node, it is safe to
>> +	 * assume that another driver will enable the backlight at the
>> +	 * appropriate time. Therefore, if it is disabled, keep it so.
>> +	 */
>> +
>> +	/*
>> +	 * if the enable GPIO is set as output and it is disabled, do not enable
>> +	 * the backlight
>> +	 */
>> +	if (pb->enable_gpio) {
>> +		if (gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT &&
>> +		    gpiod_get_value(pb->enable_gpio) == 0)
>> +			return FB_BLANK_POWERDOWN;
>> +
>> +		gpiod_direction_output(pb->enable_gpio, 1);
>> +	}
>> +
>> +	/* The regulator is disabled, do not enable the backlight */
>> +	if (!regulator_is_enabled(pb->power_supply))
>> +		return FB_BLANK_POWERDOWN;
>> +
>> +	return FB_BLANK_UNBLANK;
>> +}
>> +
>>  static int pwm_backlight_probe(struct platform_device *pdev)
>>  {
>>  	struct platform_pwm_backlight_data *data = dev_get_platdata(&pdev->dev);
>> @@ -200,7 +234,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>>  	struct backlight_device *bl;
>>  	struct device_node *node = pdev->dev.of_node;
>>  	struct pwm_bl_data *pb;
>> -	int initial_blank = FB_BLANK_UNBLANK;
>>  	struct pwm_args pargs;
>>  	int ret;
>>  
>> @@ -267,30 +300,12 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>>  		pb->enable_gpio = gpio_to_desc(data->enable_gpio);
>>  	}
>>  
>> -	if (pb->enable_gpio) {
>> -		/*
>> -		 * If the driver is probed from the device tree and there is a
>> -		 * phandle link pointing to the backlight node, it is safe to
>> -		 * assume that another driver will enable the backlight at the
>> -		 * appropriate time. Therefore, if it is disabled, keep it so.
>> -		 */
>> -		if (node && node->phandle &&
>> -		    gpiod_get_direction(pb->enable_gpio) == GPIOF_DIR_OUT &&
>> -		    gpiod_get_value(pb->enable_gpio) == 0)
>> -			initial_blank = FB_BLANK_POWERDOWN;
>> -		else
>> -			gpiod_direction_output(pb->enable_gpio, 1);
>> -	}
>> -
>>  	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
>>  	if (IS_ERR(pb->power_supply)) {
>>  		ret = PTR_ERR(pb->power_supply);
>>  		goto err_alloc;
>>  	}
>>  
>> -	if (node && node->phandle && !regulator_is_enabled(pb->power_supply))
>> -		initial_blank = FB_BLANK_POWERDOWN;
>> -
>>  	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
>>  	if (IS_ERR(pb->pwm) && PTR_ERR(pb->pwm) != -EPROBE_DEFER && !node) {
>>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>> @@ -347,7 +362,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	bl->props.brightness = data->dft_brightness;
>> -	bl->props.power = initial_blank;
>> +	bl->props.power = pwm_backlight_initial_power_state(pb);
>>  	backlight_update_status(bl);
>>  
>>  	platform_set_drvdata(pdev, bl);
> 


-- 
Péter
