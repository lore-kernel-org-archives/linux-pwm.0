From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] backlight: pwm_bl: switch to using "atomic" PWM API
Date: Fri, 27 Jul 2018 17:03:13 +0200
Message-ID: <8ee6a03a-f137-65c2-98d3-c7dc8d56691a@collabora.com>
References: <20180726091534.27521-1-enric.balletbo@collabora.com>
 <2e157deb-de8d-9f12-b4f2-04e04ff2e5ed@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2e157deb-de8d-9f12-b4f2-04e04ff2e5ed@linaro.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>, linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, cl@rock-chips.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Hi Daniel,

Thanks for reviewing the patch.

On 27/07/18 13:32, Daniel Thompson wrote:
> On 26/07/18 10:15, Enric Balletbo i Serra wrote:
>> The "atomic" API allows us to configure PWM period and duty_cycle and
>> enable it in one call.
>>
>> The patch also moves the pwm_init_state just before any use of the
>> pwm_state struct, this fixes a potential bug where pwm_get_state
>> can be called before pwm_init_state.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>   drivers/video/backlight/pwm_bl.c | 48 ++++++++++++++++++++------------
>>   1 file changed, 30 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
>> index bdfcc0a71db1..2c734d55d607 100644
>> --- a/drivers/video/backlight/pwm_bl.c
>> +++ b/drivers/video/backlight/pwm_bl.c
>> @@ -46,7 +46,8 @@ struct pwm_bl_data {
>>       void            (*exit)(struct device *);
>>   };
>>   -static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
>> +static void pwm_backlight_power_on(struct pwm_bl_data *pb,
>> +                   struct pwm_state *state)
>>   {
>>       int err;
>>   @@ -57,7 +58,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb,
>> int brightness)
>>       if (err < 0)
>>           dev_err(pb->dev, "failed to enable power supply\n");
>>   -    pwm_enable(pb->pwm);
>> +    state->enabled = true;
>> +    pwm_apply_state(pb->pwm, state);
>>         if (pb->post_pwm_on_delay)
>>           msleep(pb->post_pwm_on_delay);
>> @@ -70,6 +72,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb,
>> int brightness)
>>     static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>>   {
>> +    struct pwm_state state;
>> +
>>       if (!pb->enabled)
>>           return;
>>   @@ -79,8 +83,11 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>>       if (pb->pwm_off_delay)
>>           msleep(pb->pwm_off_delay);
>>   -    pwm_config(pb->pwm, 0, pb->period);
>> -    pwm_disable(pb->pwm);
>> +    pwm_get_state(pb->pwm, &state);
>> +    state.enabled = false;
>> +    state.period = pb->period;
>> +    state.duty_cycle = 0;
>> +    pwm_apply_state(pb->pwm, &state);
>>         regulator_disable(pb->power_supply);
>>       pb->enabled = false;
>> @@ -106,6 +113,7 @@ static int pwm_backlight_update_status(struct
>> backlight_device *bl)
>>   {
>>       struct pwm_bl_data *pb = bl_get_data(bl);
>>       int brightness = bl->props.brightness;
>> +    struct pwm_state state;
>>       int duty_cycle;
>>         if (bl->props.power != FB_BLANK_UNBLANK ||
>> @@ -118,8 +126,13 @@ static int pwm_backlight_update_status(struct
>> backlight_device *bl)
>>         if (brightness > 0) {
>>           duty_cycle = compute_duty_cycle(pb, brightness);
>> -        pwm_config(pb->pwm, duty_cycle, pb->period);
>> -        pwm_backlight_power_on(pb, brightness);
>> +        pwm_get_state(pb->pwm, &state);
>> +        state.duty_cycle = duty_cycle;
>> +        state.period = pb->period;
>> +        if (!state.enabled)
>> +            pwm_backlight_power_on(pb, &state);
>> +        else
>> +            pwm_apply_state(pb->pwm, &state);
>>       } else
>>           pwm_backlight_power_off(pb);
>>   @@ -447,7 +460,6 @@ static int pwm_backlight_probe(struct platform_device
>> *pdev)
>>       struct device_node *node = pdev->dev.of_node;
>>       struct pwm_bl_data *pb;
>>       struct pwm_state state;
>> -    struct pwm_args pargs;
>>       unsigned int i;
>>       int ret;
>>   @@ -539,10 +551,17 @@ static int pwm_backlight_probe(struct platform_device
>> *pdev)
>>         dev_dbg(&pdev->dev, "got pwm for backlight\n");
>>   -    if (!data->levels) {
>> -        /* Get the PWM period (in nanoseconds) */
>> -        pwm_get_state(pb->pwm, &state);
>> +    /* Sync up PWM state and ensure it is off. */
>> +    pwm_init_state(pb->pwm, &state);
>> +    state.enabled = false;
>> +    ret = pwm_apply_state(pb->pwm, &state);
> 
> Why do we ensure the PWM is off? Does this cause backlight flickers or make some
> of the code in pwm_backlight_initial_power_state() unreachable?
> 

No, I think that I can just remove that line.

> 
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "failed to apply initial PWM state: %d\n",
>> +            ret);
>> +        goto err_alloc;
>> +    }
>>   +    if (!data->levels) {
>>           ret = pwm_backlight_brightness_default(&pdev->dev, data,
>>                                  state.period);
>>           if (ret < 0) {
>> @@ -559,20 +578,13 @@ static int pwm_backlight_probe(struct platform_device
>> *pdev)
>>           pb->levels = data->levels;
>>       }
>>   -    /*
>> -     * FIXME: pwm_apply_args() should be removed when switching to
>> -     * the atomic PWM API.
>> -     */
>> -    pwm_apply_args(pb->pwm);
>> -
>>       /*
>>        * The DT case will set the pwm_period_ns field to 0 and store the
>>        * period, parsed from the DT, in the PWM device. For the non-DT case,
>>        * set the period from platform data if it has not already been set
>>        * via the PWM lookup table.
>>        */
>> -    pwm_get_args(pb->pwm, &pargs);
>> -    pb->period = pargs.period;
>> +    pb->period = state.period;
>>       if (!pb->period && (data->pwm_period_ns > 0))
>>           pb->period = data->pwm_period_ns;
> 
> Could we have delayed applying the state until we know what the period is
> supposed to be? No other call to pwm_apply_state() has its error value
> checked... so if there are problems with the period we could detect them here.
> 

Yes, I can move this code before 'if (!data->levels)' and call pwm_apply_state
after.

> Note also that we can guarantee the period is set before the probe completes
> then I think pb->period could be removed entirely. It was only really being
> carried around to help with calls to pwm_config() and these no longer exist.
> 

Right, I think that I can also remove pb->period. I'll send a second version soon.

Thanks,
 Enric
> 
> Daniel.
> 
