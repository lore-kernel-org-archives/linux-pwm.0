Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20131008114901.GJ19633@ulmo.nvidia.com>
References: <1381050398-12565-1-git-send-email-Baohua.Song@csr.com> <20131008114901.GJ19633@ulmo.nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 8 Oct 2013 21:12:47 +0800
Message-ID: <CAGsJ_4zfsca=FS7M2p3J0BbCH_7ut-wr9oBWDvUZEy=0DBE7CQ@mail.gmail.com>
Subject: Re: [PATCH] pwm_backlight: avoid short blank screen while doing hibernation
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jg1.han@samsung.com>, linux-pwm@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Huayi Li <huayi.li@csr.com>, Barry Song <Baohua.Song@csr.com>

2013/10/8 Thierry Reding <thierry.reding@gmail.com>:
> On Sun, Oct 06, 2013 at 05:06:38PM +0800, Barry Song wrote:
>> From: Huayi Li <huayi.li@csr.com>
>>
>> Use SIMPLE_DEV_PM_OPS macro will initialize the member "freeze"
>> and "thaw" of pwm_backlight_pm_ops as below,
>>       .freeze = suspend_fn,
>>       .thaw = resume_fn,
>> then during the process of making hibernation snapshot, screen
>> will be blank at the moment of freezing, and then light at the
>> moment of thawing.
>> this is not the right user experience for suspending to disk.
>>
>> so this patch drops freeze and thaw callback, make the LCD is
>> always lighting before the final shutdown.
>>
>> Signed-off-by: Huayi Li <huayi.li@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  drivers/video/backlight/pwm_bl.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> My notebook seems to disable the backlight when snapshotting so I guess
> it provides the wrong user experience as well. What the commit message
> says makes some sense, so I think I'll apply this.

nice to hear that.

>I have one comment,
> though, see below.
>
>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
>> index 1fea627..f3b76cb 100644
>> --- a/drivers/video/backlight/pwm_bl.c
>> +++ b/drivers/video/backlight/pwm_bl.c
>> @@ -296,16 +296,23 @@ static int pwm_backlight_resume(struct device *dev)
>>       backlight_update_status(bl);
>>       return 0;
>>  }
>> +
>> +static const struct dev_pm_ops pwm_backlight_pm_ops = {
>> +     .suspend = pwm_backlight_suspend,
>> +     .resume = pwm_backlight_resume,
>> +     .poweroff = pwm_backlight_suspend,
>> +     .restore = pwm_backlight_resume,
>> +};
>>  #endif
>>
>> -static SIMPLE_DEV_PM_OPS(pwm_backlight_pm_ops, pwm_backlight_suspend,
>> -                      pwm_backlight_resume);
>>
>>  static struct platform_driver pwm_backlight_driver = {
>>       .driver         = {
>>               .name           = "pwm-backlight",
>>               .owner          = THIS_MODULE,
>> +#ifdef CONFIG_PM_SLEEP
>>               .pm             = &pwm_backlight_pm_ops,
>> +#endif
>
> Can we move the #ifdef inside of the pwm_backlight_pwm_ops so that we
> don't have to clutter the platform_driver here? What I mean is this:
>
>         static const struct dev_pm_ops pwm_backlight_pm_ops = {
>         #ifdef CONFIG_PM_SLEEP
>                 .suspend = pwm_backlight_suspend,
>                 .resume = pwm_backlight_resume,
>                 .poweroff = pwm_backlight_suspend,
>                 .restore = pwm_backlight_resume,
>         #endif
>         };
>
> That's consistent with what SIMPLE_DEV_PM_OPS() does.

agree.

>
> Thanks,
> Thierry

-barry
