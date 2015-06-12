From: Jonathan Richardson <jonathar@broadcom.com>
Subject: Re: [PATCH v8 3/5] pwm: kona: Fix incorrect config, disable, and
 polarity procedures
Date: Fri, 12 Jun 2015 14:28:00 -0700
Message-ID: <557B4EE0.1000209@broadcom.com>
References: <1432670900-27687-1-git-send-email-jonathar@broadcom.com> <1432670900-27687-4-git-send-email-jonathar@broadcom.com> <CAD7vxx+t=t84hGqVHz3Y3y+eKii5E3J2=oxMaDgtQgbD=WU+ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:56773 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbbFLV2G (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2015 17:28:06 -0400
In-Reply-To: <CAD7vxx+t=t84hGqVHz3Y3y+eKii5E3J2=oxMaDgtQgbD=WU+ow@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>
Cc: Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PWM <linux-pwm@vger.kernel.org>

On 15-05-30 09:41 AM, Tim Kryger wrote:
> On Tue, May 26, 2015 at 1:08 PM, Jonathan Richardson
> <jonathar@broadcom.com> wrote:
>> The config procedure didn't follow the spec which periodically resulted
>> in failing to enable the output signal. This happened one in ten or
>> twenty attempts. Following the spec and adding a 400ns delay in the
>> appropriate locations resolves this problem.
>>
>> The disable and polarity procedures now also follow the spec. The old
>> procedures would result in no change in signal when called.
> 
> I think you may want to adjust your commit title and message to more
> clearly describe what this change is doing. Perhaps something like:
> 
> pwm: kona: Modify settings application sequence
> 
> Update the driver so that settings are applied in accordance with the
> most recent version of the hardware spec.  The revised sequence clears
> the trigger bit, waits 400ns, writes settings, sets the trigger bit,
> and waits another 400ns.  This corrects an issue where occasionally a
> requested change was not properly reflected in the PWM output.
> 
> Otherwise, this patch looks reasonable so
> 
> Reviewed-by: Tim Kryger <tim.kryger@gmail.com>

Fine with me. Same with two comments below. Will re-spin when I can see
Thierry's modification to use pwmchip_add_with_polarity() instead of
pwmchip_add_inversed().

Thanks.

> 
>>
>> Reviewed-by: Arun Ramamurthy <arunrama@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> Tested-by: Scott Branden <sbranden@broadcom.com>
>> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
>> ---
>>  drivers/pwm/pwm-bcm-kona.c |   47 +++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 38 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
>> index 32b3ec6..c87621f 100644
>> --- a/drivers/pwm/pwm-bcm-kona.c
>> +++ b/drivers/pwm/pwm-bcm-kona.c
>> @@ -76,19 +76,36 @@ static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
>>         return container_of(_chip, struct kona_pwmc, chip);
>>  }
>>
>> -static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
>> +/*
>> + * Clear trigger bit but set smooth bit to maintain old output.
>> + */
>> +static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
>> +       unsigned int chan)
>>  {
>>         unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
>>
>> -       /* Clear trigger bit but set smooth bit to maintain old output */
>>         value |= 1 << PWM_CONTROL_SMOOTH_SHIFT(chan);
>>         value &= ~(1 << PWM_CONTROL_TRIGGER_SHIFT(chan));
>>         writel(value, kp->base + PWM_CONTROL_OFFSET);
>>
>> +       /*
>> +        * There must be a min 400ns delay between clearing enable and setting
>> +        * it. Failing to do this may result in no PWM signal.
>> +        */
>> +       ndelay(400);
>> +}
> 
> Since it doesn't function as an enable, please call it the trigger bit.
> 
>> +
>> +static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
>> +{
>> +       unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
>> +
>>         /* Set trigger bit and clear smooth bit to apply new settings */
>>         value &= ~(1 << PWM_CONTROL_SMOOTH_SHIFT(chan));
>>         value |= 1 << PWM_CONTROL_TRIGGER_SHIFT(chan);
>>         writel(value, kp->base + PWM_CONTROL_OFFSET);
>> +
>> +       /* PWMOUT_ENABLE must be held high for at least 400 ns. */
>> +       ndelay(400);
>>  }
> 
> Same here.
> 
>>
>>  static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
>> @@ -133,8 +150,14 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>                         return -EINVAL;
>>         }
>>
>> -       /* If the PWM channel is enabled, write the settings to the HW */
>> +       /*
>> +        * Don't apply settings if disabled. The period and duty cycle are
>> +        * always calculated above to ensure the new values are
>> +        * validated immediately instead of on enable.
>> +        */
>>         if (test_bit(PWMF_ENABLED, &pwm->flags)) {
>> +               kona_pwmc_prepare_for_settings(kp, chan);
>> +
>>                 value = readl(kp->base + PRESCALE_OFFSET);
>>                 value &= ~PRESCALE_MASK(chan);
>>                 value |= prescale << PRESCALE_SHIFT(chan);
>> @@ -164,6 +187,8 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>>                 return ret;
>>         }
>>
>> +       kona_pwmc_prepare_for_settings(kp, chan);
>> +
>>         value = readl(kp->base + PWM_CONTROL_OFFSET);
>>
>>         if (polarity == PWM_POLARITY_NORMAL)
>> @@ -175,9 +200,6 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>>
>>         kona_pwmc_apply_settings(kp, chan);
>>
>> -       /* Wait for waveform to settle before gating off the clock */
>> -       ndelay(400);
>> -
>>         clk_disable_unprepare(kp->clk);
>>
>>         return 0;
>> @@ -207,13 +229,20 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>>  {
>>         struct kona_pwmc *kp = to_kona_pwmc(chip);
>>         unsigned int chan = pwm->hwpwm;
>> +       unsigned int value;
>> +
>> +       kona_pwmc_prepare_for_settings(kp, chan);
>>
>>         /* Simulate a disable by configuring for zero duty */
>>         writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
>> -       kona_pwmc_apply_settings(kp, chan);
>> +       writel(0, kp->base + PERIOD_COUNT_OFFSET(chan));
>>
>> -       /* Wait for waveform to settle before gating off the clock */
>> -       ndelay(400);
>> +       /* Set prescale to 0 for this channel */
>> +       value = readl(kp->base + PRESCALE_OFFSET);
>> +       value &= ~PRESCALE_MASK(chan);
>> +       writel(value, kp->base + PRESCALE_OFFSET);
>> +
>> +       kona_pwmc_apply_settings(kp, chan);
>>
>>         clk_disable_unprepare(kp->clk);
>>  }
>> --
>> 1.7.9.5
>>
