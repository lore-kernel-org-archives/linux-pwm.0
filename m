From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH Resend 1/2] pwm: atmel: Remove redundant of_match_ptr helper
Date: Fri, 24 Jan 2014 14:34:32 +0530
Message-ID: <CAK9yfHy9_hj93ra+RDO=W_bCZDCvsCT0AxwsYOnrZafbyC8CcA@mail.gmail.com>
References: <1390474715-6587-1-git-send-email-sachin.kamat@linaro.org>
	<20140123124405.GA28527@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:37774 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbaAXJEd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jan 2014 04:04:33 -0500
Received: by mail-ob0-f175.google.com with SMTP id wn1so3285175obc.6
        for <linux-pwm@vger.kernel.org>; Fri, 24 Jan 2014 01:04:33 -0800 (PST)
In-Reply-To: <20140123124405.GA28527@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

Hi Thierry,

On 23 January 2014 18:14, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Thu, Jan 23, 2014 at 04:28:34PM +0530, Sachin Kamat wrote:
>> 'atmel_pwm_dt_ids' is always compiled in. Hence the
>> helper macro is not needed.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  drivers/pwm/pwm-atmel.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Hi Sachin,
>
> Sorry for taking so long to look at this, things have been pretty
> busy...

No problem. Sorry to bother you though.

>
>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>> index bf4144a14661..45f0fb793528 100644
>> --- a/drivers/pwm/pwm-atmel.c
>> +++ b/drivers/pwm/pwm-atmel.c
>> @@ -381,7 +381,7 @@ static int atmel_pwm_remove(struct platform_device *pdev)
>>  static struct platform_driver atmel_pwm_driver = {
>>       .driver = {
>>               .name = "atmel-pwm",
>> -             .of_match_table = of_match_ptr(atmel_pwm_dt_ids),
>> +             .of_match_table = atmel_pwm_dt_ids,
>>       },
>>       .id_table = atmel_pwm_devtypes,
>>       .probe = atmel_pwm_probe,
>
> Given that the driver doesn't depend on OF, I think the right thing to
> do here would be to #ifdef the atmel_pwm_dt_ids so it doesn't waste
> needless memory.

OK. Will update accordingly.


-- 
With warm regards,
Sachin
