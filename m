Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from www3345.sakura.ne.jp ([49.212.235.55]:51198 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731684AbfEXBzr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 May 2019 21:55:47 -0400
References: <1558659389-4397-1-git-send-email-cv-dong@jinso.co.jp>
 <87k1egr78w.wl-kuninori.morimoto.gx@renesas.com>
From: Cao Van Dong <cv-dong@jinso.co.jp>
Message-ID: <3b4441ed-7b0f-6f3a-7c45-b938f3274706@jinso.co.jp>
Date: Fri, 24 May 2019 10:55:44 +0900
MIME-Version: 1.0
In-Reply-To: <87k1egr78w.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v3] pwm: renesas-tpu: Add suspend/resume function
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, thierry.reding@gmail.com, horms+renesas@verge.net.au, geert+renesas@glider.be, broonie@kernel.org, linux-pwm@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com, h-inayoshi@jinso.co.jp, na-hoan@jinso.co.jp

Dear Morimoto-san,

Thank for your feedback!

On 2019/05/24 10:21, Kuninori Morimoto wrote:
> Hi Cao
>
> If you post v3 patches, you should post whole series
>
>> This patch adds suspend/resume function support for Renesas the 16-Bit Timer
>> Pulse Unit (TPU) driver. This has been tested on the Salvator-XS board
>> with R-Car M3-N and H3 at renesas-drivers-2019-05-21-v5.2-rc1 tag.
>> I expect this to work on other SoCs.
>>
>> Test procedure:
>>    - Enable TPU and pin control in DTS.
>>    - Make sure switches { SW29-[1-2] are switched off or
>>      SW31-[1-4] are switched off(only for Salvator-xs) }.
>>    - Exercise userspace PWM control for pwm[2,3]
>>      of /sys/class/pwm/pwmchip1/ .
>>    - Inspect PWM signals on the input side of { CN29-[58,60]
>>      or SW31-[1,2] (only for Salvator-xs) }
>>      before and after suspend/resume using an oscilloscope.
>>
>> Signed-off-by: Cao Van Dong <cv-dong@jinso.co.jp>
>> Tested-by: Cao Van Dong <cv-dong@jinso.co.jp>
>> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Drop my name from here, I'm not Acked yet.

I'm so sorry !!

>> +#ifdef CONFIG_PM_SLEEP
>> +static int tpu_pwm_restart_timer(struct pwm_device *pwm)
>> +{
>> +	if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>> +		return 0;
>> +
>> +	/* Restart timer */
>> +	tpu_pwm_disable(pwm->chip,pwm);
>> +	tpu_pwm_enable(pwm->chip,pwm);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tpu_pwm_suspend(struct device *dev)
>> +{
>> +	struct tpu_device *tpu = dev_get_drvdata(dev);
>> +	struct pwm_chip *chip = &tpu->chip;
>> +	struct pwm_device *pwm;
>> +	int i;
>> +
>> +	for (i = 0; i < TPU_CHANNEL_MAX; i++) {
>> +		if ((pwm_get_chip_data(&chip->pwms[i])) != NULL) {
>> +			pwm = &chip->pwms[i];
>> +			if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>> +				return 0;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int tpu_pwm_resume(struct device *dev)
>> +{
>> +	struct tpu_device *tpu = dev_get_drvdata(dev);
>> +	struct pwm_chip *chip = &tpu->chip;
>> +	struct pwm_device *pwm;
>> +	int i;
>> +
>> +	pm_runtime_get_sync(dev);
>> +
>> +	for (i = 0; i < TPU_CHANNEL_MAX; i++) {
>> +		if ((pwm_get_chip_data(&chip->pwms[i])) != NULL) {
>> +			pwm = &chip->pwms[i];
>> +			tpu_pwm_restart_timer(pwm);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +#endif /* CONFIG_PM_SLEEP */
> again
>
> 	pwm = &chip->pwms[i];
> 	if (pwm_get_chip_data(pwms)) {
>
> Why you "restart" at resume ?
> I think "disable" at suspend, and "enable" at resume is generic ?

This is a good idea.

> You call pm_runtime_get_sync() at resume,
> but removed pm_runtime_put() suspend ??

Very sorry for the inconvenience. I'm mistake. I will remove 
pm_runtime_get_sync() at resume.

Thank you,
Dong

> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto
