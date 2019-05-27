Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from www3345.sakura.ne.jp ([49.212.235.55]:36530 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfE0CGp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 May 2019 22:06:45 -0400
References: <1558917399-7065-1-git-send-email-cv-dong@jinso.co.jp>
 <875zpwu2hz.wl-kuninori.morimoto.gx@renesas.com>
From: Cao Van Dong <cv-dong@jinso.co.jp>
Message-ID: <2cc62ae3-f378-f67b-ce78-d17a82248312@jinso.co.jp>
Date: Mon, 27 May 2019 11:06:40 +0900
MIME-Version: 1.0
In-Reply-To: <875zpwu2hz.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v4] pwm: renesas-tpu: Add suspend/resume function
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, thierry.reding@gmail.com, horms+renesas@verge.net.au, geert+renesas@glider.be, broonie@kernel.org, linux-pwm@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com, h-inayoshi@jinso.co.jp, na-hoan@jinso.co.jp

Dear Morimoto-san,

Thank for your feedback!

On 2019/05/27 10:24, Kuninori Morimoto wrote:
> Hi
>
>> This patch adds suspend/resume function support for Renesas the 16-Bit Timer
>> Pulse Unit (TPU) driver. This has been tested on the Salvator-XS board
>> with R-Car M3-N and H3 at renesas-drivers-2019-05-21-v5.2-rc1 tag.
>> I expect this to work on other SoCs.
> (snip)
>> +#ifdef CONFIG_PM_SLEEP
>> +static int tpu_pwm_suspend(struct device *dev)
>> +{
>> +	struct tpu_device *tpu = dev_get_drvdata(dev);
>> +	struct pwm_chip *chip = &tpu->chip;
>> +	struct pwm_device *pwm;
>> +	int i;
>> +
>> +	for (i = 0; i < TPU_CHANNEL_MAX; i++) {
>> +		pwm = &chip->pwms[i];
>> +		if (pwm_is_enabled(pwm)) {
>> +			if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>> +				return 0;
>> +			tpu_pwm_disable(pwm->chip,pwm);
>> +		}
>> +	}
> I'm not familiar with pwm driver, but pwm_is_enabled() and
> if (!test_bit(PWMF_REQUESTED, &pwm->flags)) can be happen in the same time ?
> In other words, can we enable pwm without PWMF_REQUESTED ?

Thank for your help!
Can. Perhaps the PWMF_REQUESTED check is not necessary. I will remove it.

>> +static int tpu_pwm_resume(struct device *dev)
>> +{
>> +	struct tpu_device *tpu = dev_get_drvdata(dev);
>> +	struct pwm_chip *chip = &tpu->chip;
>> +	struct pwm_device *pwm;
>> +	int i;
>> +
>> +	for (i = 0; i < TPU_CHANNEL_MAX; i++) {
>> +		pwm = &chip->pwms[i];
>> +		if (pwm_is_enabled(pwm)) {
>> +			if (!test_bit(PWMF_REQUESTED, &pwm->flags))
>> +				return 0;
>> +			tpu_pwm_enable(pwm->chip,pwm);
>> +		}
>> +	}
> Please use ${LINUX}/scripts/checkpatch.pl

Thanks for the prompt!

Thank you,
Dong

> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto
