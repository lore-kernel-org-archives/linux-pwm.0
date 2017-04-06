From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH V4 4/4] pwm: tegra: Add support to configure pin state
 in suspends/resume
Date: Thu, 6 Apr 2017 22:10:47 +0530
Message-ID: <58E66F8F.1030802@nvidia.com>
References: <1491488461-24621-1-git-send-email-ldewangan@nvidia.com> <1491488461-24621-5-git-send-email-ldewangan@nvidia.com> <e6eef15a-45e4-002b-dd45-38c268070241@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14602 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbdDFRCA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Apr 2017 13:02:00 -0400
In-Reply-To: <e6eef15a-45e4-002b-dd45-38c268070241@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, thierry.reding@gmail.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

Oops, it was actually v2.

On Thursday 06 April 2017 08:47 PM, Jon Hunter wrote:
> On 06/04/17 15:21, Laxman Dewangan wrote:
>> In some of NVIDIA Tegra's platform, PWM controller is used to
>> control the PWM controlled regulators. PWM signal is connected to
>> the VID pin of the regulator where duty cycle of PWM signal decide
>> the voltage level of the regulator output.
>>
>> The tristate (high impedance of PWM pin form Tegra) also define
>> one of the state of PWM regulator which needs to be configure in
>> suspend state of system.
>>
>> Add support to configure the pin state via pinctrl frameworks in
>> suspend and active state of the system.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>> ---
>> Changes from v1:
>> - Use standard pinctrl names for sleep and active state.
>> - Use API pinctrl_pm_select_*()
>>
>>   drivers/pwm/pwm-tegra.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
>> index e9c4de5..af1bd4f 100644
>> --- a/drivers/pwm/pwm-tegra.c
>> +++ b/drivers/pwm/pwm-tegra.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/of_device.h>
>>   #include <linux/pwm.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pinctrl/consumer.h>
>>   #include <linux/slab.h>
>>   #include <linux/reset.h>
>>   
>> @@ -256,6 +257,22 @@ static int tegra_pwm_remove(struct platform_device *pdev)
>>   	return pwmchip_remove(&pc->chip);
>>   }
>>   
>> +#ifdef CONFIG_PM_SLEEP
>> +static int tegra_pwm_suspend(struct device *dev)
>> +{
>> +	pinctrl_pm_select_sleep_state(dev);
> Why not return the error code here?

As the pin state in suspend is optional, I dont  want to return error if 
the sleep state is not available.

However, it seems pinctrl take care of retuning success if there is no 
sleep state. By seeing code.
Let me test this on different condition and it it works fine then we can 
return the return of pinctrl_pm_select_*()


BTW, it should be OK to have pwm_tegra_resume/suspend wrapper, not 
directly use the pinctrl_pm_select_* in pm ops suspend/resume. The 
prototype matches.



>
> By the way, do you plan to include patches to populate the bindings for
> the pwm devices?

I am planning to populate the GPU regulator which is PWM based. This 
will only populate the regulator.
