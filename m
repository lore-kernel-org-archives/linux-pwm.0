From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH v3] pwm: add depends, COMPILE_TEST and default y for
 brcm-iproc-pwm
Date: Tue, 20 Dec 2016 11:32:21 -0800
Message-ID: <b75e58ab-7078-1a1a-8a79-b5482afad874@broadcom.com>
References: <1475960045-19313-1-git-send-email-scott.branden@broadcom.com>
 <8b29ebaa-eaaa-2f77-6408-a476af3aaa84@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8b29ebaa-eaaa-2f77-6408-a476af3aaa84@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

Could you pick up this patch?

On 16-10-08 02:02 PM, Ray Jui wrote:
>
>
> On 10/8/2016 1:54 PM, Scott Branden wrote:
>> - Add depends on COMMON_CLK for PWM_BCM_IPROC
>> - Enable COMPILE_TEST for broader compile coverage.
>> - Default y for IPROC PWM driver for IPROC SoCs.
>> This allows you to turn it on simply by selecting CONFIG_PWM.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  drivers/pwm/Kconfig | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 80a566a..3eb1b6b 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -76,7 +76,9 @@ config PWM_ATMEL_TCB
>>
>>  config PWM_BCM_IPROC
>>      tristate "iProc PWM support"
>> -    depends on ARCH_BCM_IPROC
>> +    depends on ARCH_BCM_IPROC || COMPILE_TEST
>> +    depends on COMMON_CLK
>> +    default ARCH_BCM_IPROC
>>      help
>>        Generic PWM framework driver for Broadcom iProc PWM block. This
>>        block is used in Broadcom iProc SoC's.
>>
>
> Looks good to me!
>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
