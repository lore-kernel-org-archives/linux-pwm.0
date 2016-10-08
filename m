From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH v2] pwm: add COMPILE_TEST and default y for brcm-iproc-pwm
Date: Sat, 8 Oct 2016 13:49:39 -0700
Message-ID: <2fbed3ee-0e88-7937-61fd-1c8bbf573532@broadcom.com>
References: <1475948189-6402-1-git-send-email-scott.branden@broadcom.com>
 <377829f9-05b3-6407-477c-52c23f623368@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <377829f9-05b3-6407-477c-52c23f623368@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
List-Id: linux-pwm@vger.kernel.org

Hi Ray,

On 16-10-08 01:20 PM, Ray Jui wrote:
> Hi Scott,
>
> On 10/8/2016 10:36 AM, Scott Branden wrote:
>> Enable COMPILE_TEST for broader compile coverage.
>> Default y for IPROC PWM driver for IPROC SoCs.
>> This allows you to turn it on simply by selecting CONFIG_PWM.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/pwm/Kconfig | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 80a566a..68cd13d 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -76,7 +76,8 @@ config PWM_ATMEL_TCB
>>     config PWM_BCM_IPROC
>>       tristate "iProc PWM support"
>> -    depends on ARCH_BCM_IPROC
>> +    depends on ARCH_BCM_IPROC || COMPILE_TEST
> Would be nice to also add a dependency on COMMON_CLK here.
will add depends on COMMON_CLK
>
>> +    default ARCH_BCM_IPROC
>>       help
>>         Generic PWM framework driver for Broadcom iProc PWM block. This
>>         block is used in Broadcom iProc SoC's.
>
> Thanks,
>
> Ray

Regards,
  Scott
