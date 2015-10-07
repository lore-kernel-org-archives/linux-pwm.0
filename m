From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] pwm: fix Broadcom BCM7038 PWM driver
Date: Tue, 06 Oct 2015 17:51:30 -0700
Message-ID: <56146C92.7090606@gmail.com>
References: <1442274426-3507-1-git-send-email-f.fainelli@gmail.com> <20151005151415.GE27759@ulmo> <6796852.Ynn1zMqb4r@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:32992 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbbJGAvu (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2015 20:51:50 -0400
In-Reply-To: <6796852.Ynn1zMqb4r@wuerfel>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Thierry Reding <thierry.reding@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, ariel@vanguardiasur.com.ar

On 06/10/15 12:59, Arnd Bergmann wrote:
> The newly added pwm-brcmstb driver fails to build if CONFIG_PM_SLEEP
> is enabled:
> 
> drivers/pwm/pwm-brcmstb.c: In function 'brcmstb_pwm_suspend':
> drivers/pwm/pwm-brcmstb.c:309:42: error: 'dev' undeclared (first use in this function)
>   struct brcmstb_pwm *p = dev_get_drvdata(dev);
> 
> This changes the name of the function argument to match its user.

Thanks, maybe, to avoid similar issues in the future, we should start
removing the ifdef CONFIG_PM_SLEEP and instead annotate such functions
with __maybe_unused. I wonder if we could magically make that happen
with a coccinelle script that looks for SIMPLE_DEV_PM_OPS to know which
functions to annotate... humm.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> On Monday 05 October 2015 17:14:15 Thierry Reding wrote:
>> On Mon, Sep 14, 2015 at 04:47:04PM -0700, Florian Fainelli wrote:
>>> Florian Fainelli (2):
>>>   Documentation: dt: add Broadcom BCM7038 PWM controller binding
>>>   pwm: Add Broadcom BCM7038 PWM controller support
>>
>> I've applied both of these patches with a couple of stylistic changes.
> 
> As in the pwm-berlin driver, one of the fixups was broken.
> 
> diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
> index 083e3ef5b8e5..423ce087cd9c 100644
> --- a/drivers/pwm/pwm-brcmstb.c
> +++ b/drivers/pwm/pwm-brcmstb.c
> @@ -304,7 +304,7 @@ static int brcmstb_pwm_remove(struct platform_device *pdev)
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -static int brcmstb_pwm_suspend(struct device *d)
> +static int brcmstb_pwm_suspend(struct device *dev)
>  {
>  	struct brcmstb_pwm *p = dev_get_drvdata(dev);
>  
> @@ -313,7 +313,7 @@ static int brcmstb_pwm_suspend(struct device *d)
>  	return 0;
>  }
>  
> -static int brcmstb_pwm_resume(struct device *d)
> +static int brcmstb_pwm_resume(struct device *dev)
>  {
>  	struct brcmstb_pwm *p = dev_get_drvdata(dev);
>  
> 


-- 
Florian
