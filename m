From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH v2] pwm: kconfig: enable kona pwm to be built for cygnus
 arch
Date: Wed, 21 Nov 2018 11:07:03 -0800
Message-ID: <dcadd42d-1ef6-732b-400c-8008bc4fcd0a@broadcom.com>
References: <20181121123508.25119-1-peron.clem@gmail.com>
 <29dc5815-e897-ca7d-0e26-668faa635938@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <29dc5815-e897-ca7d-0e26-668faa635938@broadcom.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <florian.fainelli@broadcom.com>, =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


On 2018-11-21 11:00 a.m., Florian Fainelli wrote:
>
> On 11/21/2018 4:35 AM, Clément Péron wrote:
>> The Cygnus architecture use a Kona PWM. This is already present
>> in the device tree but can't be built actually. Hence, allow the
>> Kona PWM to be built for Cygnus arch.
>>
>> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Scott Branden <scott.branden@broadcom.com>

>
> The "default ARCH_BCM_CYGNUS" could arguably cover ARCH_BCM_MOBILE as
> well, but this is not probably worth a respin just to address that.
Yes, it's fine as is.
>
>> ---
>>   drivers/pwm/Kconfig | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 27e5dd47a01f..982f4059f4e8 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -88,7 +88,9 @@ config PWM_BCM_IPROC
>>   
>>   config PWM_BCM_KONA
>>   	tristate "Kona PWM support"
>> -	depends on ARCH_BCM_MOBILE
>> +	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
>> +	depends on HAVE_CLK && HAS_IOMEM
>> +	default ARCH_BCM_CYGNUS
>>   	help
>>   	  Generic PWM framework driver for Broadcom Kona PWM block.
>>   
>>
