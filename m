From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] drivers/pwm/Kconfig: Let PWM_CLPS711X depend on HAS_IOMEM
Date: Mon, 06 Oct 2014 21:07:48 +0800
Message-ID: <54329424.2020204@gmail.com>
References: <542FC27A.8050006@gmail.com> <20141006100842.GC25202@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141006100842.GC25202@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 10/6/14 18:08, Thierry Reding wrote:
> On Sat, Oct 04, 2014 at 05:48:42PM +0800, Chen Gang wrote:
>> PWM_CLPS711X needs HAS_IOMEM, so depend on it, the related error (with
>> allmodconfig under um):
>>
>>     MODPOST 1205 modules
>>   ERROR: "devm_ioremap_resource" [drivers/pwm/pwm-clps711x.ko] undefined!
>>   ERROR: "devm_ioremap" [drivers/net/phy/mdio-bcm-unimac.ko] undefined!
>>
>> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>> ---
>>  drivers/pwm/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 3865dfb..de1ffb5 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -82,7 +82,7 @@ config PWM_BFIN
>>  
>>  config PWM_CLPS711X
>>  	tristate "CLPS711X PWM support"
>> -	depends on ARCH_CLPS711X || COMPILE_TEST
>> +	depends on (ARCH_CLPS711X || COMPILE_TEST) && HAS_IOMEM
> 
> Applied, thanks. I modified this slightly and put HAS_IOMEM on a line of
> its own. This is in my opinion (slightly) more readable and matches what
> we already have for other drivers.
> 

It is OK to me, thank you for your work.


-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
