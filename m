From: Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH] pwm: bcm2835: Allow building for ARCH_BRCMSTB
Date: Mon, 30 Dec 2019 11:33:04 -0800
Message-ID: <73451521-a4d3-d945-2c86-cceef4cc6781@broadcom.com>
References: <20191209232503.7252-1-f.fainelli@gmail.com>
 <20191210065229.hopmnq5qlwtl7gzw@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210065229.hopmnq5qlwtl7gzw@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On 12/9/19 10:52 PM, Uwe Kleine-König wrote:
> On Mon, Dec 09, 2019 at 03:25:03PM -0800, Florian Fainelli wrote:
>> BCM7211 is supported using ARCH_BRCMSTB and uses this PWM controller
>> driver, make it possible to build it.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/pwm/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index bd21655c37a6..0bb8a40c8d6c 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -100,7 +100,7 @@ config PWM_BCM_KONA
>>  
>>  config PWM_BCM2835
>>  	tristate "BCM2835 PWM support"
>> -	depends on ARCH_BCM2835
>> +	depends on ARCH_BCM2835 || ARCH_BRCMSTB
> 
> It would be nice to allow this driver to be compiled with COMPILE_TEST,
> too. But also without this:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Krysztof just submitted a patch doing that [1], which will conflict with
this one. Thierry would you be able to resolve that conflict while applying?

[1]:
https://lore.kernel.org/linux-arm-kernel/20191230172113.17222-2-krzk@kernel.org/
-- 
Florian
