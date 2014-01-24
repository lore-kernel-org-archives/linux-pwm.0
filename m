From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH Resend 2/2] pwm: pxa: Use of_match_ptr helper
Date: Fri, 24 Jan 2014 14:35:19 +0530
Message-ID: <CAK9yfHy=AxqDuuoVEhb3rq54C1iT=kRnGXbqGr=yASTfH6Wz2Q@mail.gmail.com>
References: <1390474715-6587-1-git-send-email-sachin.kamat@linaro.org>
	<1390474715-6587-2-git-send-email-sachin.kamat@linaro.org>
	<20140123124759.GB28527@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:41253 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbaAXJFU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jan 2014 04:05:20 -0500
Received: by mail-oa0-f45.google.com with SMTP id i11so3484233oag.18
        for <linux-pwm@vger.kernel.org>; Fri, 24 Jan 2014 01:05:20 -0800 (PST)
In-Reply-To: <20140123124759.GB28527@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

On 23 January 2014 18:18, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Thu, Jan 23, 2014 at 04:28:35PM +0530, Sachin Kamat wrote:
>> Use the helper instead of defining NULL for CONFIG_OF
>> disabled case.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  drivers/pwm/pwm-pxa.c |    8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
>> index 8d995731cef8..685ae2c96b77 100644
>> --- a/drivers/pwm/pwm-pxa.c
>> +++ b/drivers/pwm/pwm-pxa.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/clk.h>
>>  #include <linux/io.h>
>>  #include <linux/pwm.h>
>> +#include <linux/of.h>
>>  #include <linux/of_device.h>
>>
>>  #include <asm/div64.h>
>> @@ -140,13 +141,12 @@ static struct of_device_id pwm_of_match[] = {
>>       { }
>>  };
>>  MODULE_DEVICE_TABLE(of, pwm_of_match);
>> -#else
>> -#define pwm_of_match NULL
>>  #endif
>>
>>  static const struct platform_device_id *pxa_pwm_get_id_dt(struct device *dev)
>>  {
>> -     const struct of_device_id *id = of_match_device(pwm_of_match, dev);
>> +     const struct of_device_id *id;
>> +     id = of_match_device(of_match_ptr(pwm_of_match), dev);
>
> Because of this, I find it actually more elegant to define pwm_of_match
> to NULL for non-DT.

OK. If you prefer so, will drop this patch then.



-- 
With warm regards,
Sachin
