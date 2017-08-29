From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH] pwm_bl: Fix overflow condition
Date: Tue, 29 Aug 2017 11:45:43 -0700
Message-ID: <CAGAzgsqp+ycY0Oj4OrfT=jq2OG82Efj2oQTuZhnzsZd-ApH8RQ@mail.gmail.com>
References: <20170828200033.40673-1-dbasehore@chromium.org> <20170829140534.GA18114@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35113 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbdH2Spp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Aug 2017 14:45:45 -0400
Received: by mail-wm0-f41.google.com with SMTP id a80so2791283wma.0
        for <linux-pwm@vger.kernel.org>; Tue, 29 Aug 2017 11:45:45 -0700 (PDT)
In-Reply-To: <20170829140534.GA18114@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jingoohan1@gmail.com, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org

On Tue, Aug 29, 2017 at 7:05 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Mon, Aug 28, 2017 at 01:00:33PM -0700, Derek Basehore wrote:
>> This fixes and overflow condition that happens with a high value of
>> brightness-levels-scale by using a 64-bit variable. The issue would
>> prevent a range of higher brightness levels from being set.
>>
>> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
>> ---
>>  drivers/video/backlight/pwm_bl.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
>> index 76311ec5e400..e7ffd2108acf 100644
>> --- a/drivers/video/backlight/pwm_bl.c
>> +++ b/drivers/video/backlight/pwm_bl.c
>> @@ -88,14 +88,17 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>>  static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
>>  {
>>       unsigned int lth = pb->lth_brightness;
>> -     int duty_cycle;
>> +     s64 duty_cycle;
>>
>>       if (pb->levels)
>>               duty_cycle = pb->levels[brightness];
>>       else
>>               duty_cycle = brightness;
>>
>> -     return (duty_cycle * (pb->period - lth) / pb->scale) + lth;
>> +     duty_cycle *= pb->period - lth;
>> +     do_div(duty_cycle, pb->scale);
>> +
>> +     return duty_cycle + lth;
>>  }
>
> I don't think your commit message accurately describes the change here.
> The overflow that you're preventing might happen with a large value of
> pb->period (or rather, in combination with a large value of duty_cycle)
> but it's unrelated to pb->scale.

I'm referring to the of property brightness-levels-scale. If there
aren't levels defined in a DTS, duty_cycle can be up to this value.
I'll change the CM to describe what's happening based on the variable
names from the function instead.

>
> Also, the semantics of do_div() are that it takes an unsigned dividend,
> so your duty_cycle should be a u64.

I'll change it.

>
> Thierry
