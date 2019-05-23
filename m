Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from www3345.sakura.ne.jp ([49.212.235.55]:64124 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbfEWCw3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 22 May 2019 22:52:29 -0400
References: <1558575210-28112-1-git-send-email-cv-dong@jinso.co.jp>
 <878suyuejo.wl-kuninori.morimoto.gx@renesas.com>
From: Cao Van Dong <cv-dong@jinso.co.jp>
Message-ID: <519f8d16-da5e-1904-ec02-ce9331f2b223@jinso.co.jp>
Date: Thu, 23 May 2019 11:52:25 +0900
MIME-Version: 1.0
In-Reply-To: <878suyuejo.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2] pwm: renesas-tpu: Add suspend/resume function
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, thierry.reding@gmail.com, horms+renesas@verge.net.au, geert+renesas@glider.be, broonie@kernel.org, linux-pwm@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com, h-inayoshi@jinso.co.jp, na-hoan@jinso.co.jp

Dear Morimoto-san,

Thank for your feedback!

On 2019/05/23 11:02, Kuninori Morimoto wrote:
> Hi
>
>> +static int tpu_pwm_suspend(struct device *dev)
>> +{
>> +	struct tpu_device *tpu = dev_get_drvdata(dev);
>> +	struct pwm_chip *chip = &tpu->chip;
>> +	struct pwm_device *pwm;
>> +	int i;
>> +
>> +	for (i = 0; i <= 3; i++) {
>> +		if ((pwm_get_chip_data(&chip->pwms[i])) != NULL) {
>> +			pwm = &chip->pwms[i];
>> +			if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>> +				return 0;
>> +		}
>> +	}
> why 3 ?
According to Hardware manual, 16-Bit Timer Pulse Unit (TPU)
supports four 16-bit timers for both R-car GEN2 and GEN3.
> About code, how about this ?
>
> 		pwm = &chip->pwms[i];
> 		if (pwm_get_chip_data(pwm)) {
> 			...
>
> Can we use chip->pwms at driver ? I'm not sure but pwm.h say
>
> 	struct pwm_chip {
> 		...
> =>		/* only used internally by the PWM framework */
> 		struct list_head list;
> 		struct pwm_device *pwms;
> 	};
As described in the header: "@pwms: array of PWM devices allocated by 
the framework"
Therefore, we can not use chip->pwms and must specify the device that 
will be used.
Otherwise the compilation will fail.
>> +
>> +	pm_runtime_put(dev);
>> +
>> +	return 0;
>> +}
> Do we need to call pm_runtime_xxx here ?

"pm_runtime_put(dev);" function is called for runtime idle operations.

>> +static int tpu_pwm_resume(struct device *dev)
>> +{
>> +	struct tpu_device *tpu = dev_get_drvdata(dev);
>> +	struct pwm_chip *chip = &tpu->chip;
>> +	struct pwm_device *pwm;
>> +	int i;
>> +
>> +	pm_runtime_get_sync(dev);
>> +
>> +	for (i = 0; i <= 3; i++) {
>> +		if ((pwm_get_chip_data(&chip->pwms[i])) != NULL) {
>> +			pwm = &chip->pwms[i];
>> +			tpu_pwm_restart_timer(pwm);
>> +		}
>> +	}
> ditto

Thank you,

Dong
