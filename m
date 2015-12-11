From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] pwm: Avoid double mutex lock on pwm_enable
Date: Fri, 11 Dec 2015 13:23:42 +0900
Message-ID: <566A4FCE.2050303@samsung.com>
References: <1448038740-2811-1-git-send-email-linux.amoon@gmail.com>
 <564FF287.8000201@samsung.com>
 <CANAwSgSRT8KYr1gAYUvspzMaqT3-3W_c7taMq5YdMo4nB3oB2Q@mail.gmail.com>
 <CAJKOXPdejej2eo4M3fuV9jn7sMMwi7zADsvmvP0n60hW9ER_oQ@mail.gmail.com>
 <CANAwSgQZnUxRR_2077Hmj=qLzAz_UNUqVWmaiy5MxSCNrk=nJg@mail.gmail.com>
 <CAJKOXPc=607yqBRThcRm+342-pBq2PozEqiE9zyHcKztDXDeBA@mail.gmail.com>
 <CANAwSgQeQy4=V7fociFJ36KibyAvbBbqTOHty3bodaajKpOBNw@mail.gmail.com>
 <CAJKOXPdvA4ovVDFyOgaagT+0sOpkUArk9FzWB_Z7iptRCsSAcA@mail.gmail.com>
 <CANAwSgTuTWntpdCrry4KNe9_b9ekJTM_gT-7-bsY53nmorb-tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CANAwSgTuTWntpdCrry4KNe9_b9ekJTM_gT-7-bsY53nmorb-tw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-pwm@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Jonathan Richardson <jonathar@broadcom.com>
List-Id: linux-pwm@vger.kernel.org

On 11.12.2015 13:07, Anand Moon wrote:
> Hi Krzysztof,
> 
> On 22 November 2015 at 05:43, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> 2015-11-22 3:14 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
>>> Hi Krzysztof,

[...]

>> Yes, now you pasted the same warning I did...
>>
>> This is still the same issue. I already wrote it:
>>> 1. BUG: sleeping function called from invalid context
>>> 2. DEBUG_LOCKS_WARN_ON(in_interrupt())
>>
>> We can repeat it many times but that won't change anything...
>>
>> Best regards,
>> Krzysztof
> 
> Would you consider below changes to fix the above issue.
> I have tested this change by enabling CONFIG_DEBUG_ATOMIC_SLEEP
> And I don't observed issue.
> 
> 1. BUG: sleeping function called from invalid context
> 2. DEBUG_LOCKS_WARN_ON(in_interrupt())
> 
> Please share your thought on this changes.
> 
> root@odroidxu4:/usr/src/odroidxu3-4.y-devel# git diff drivers/pwm/core.c
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index d24ca5f..f3f6cf9 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -506,6 +506,9 @@ int pwm_enable(struct pwm_device *pwm)
>         if (!pwm)
>                 return -EINVAL;
> 
> +       if (!mutex_is_locked(&pwm->lock))
> +               return -EINVAL;
> +
>         mutex_lock(&pwm->lock);
> 
>         if (!test_and_set_bit(PWMF_ENABLED, &pwm->flags)) {

First of all, Thierry suggested way of fixing this:
"Any objections to simply removing it and make all users use a workqueue
or some such if they need to control a PWM as a result of an interrupt
trigger?"
what is wrong with his approach?

Second, you are writing something that looks like mutex-try-lock...
which will fail the pwm_enable(). IMHO this *hides* the real issue and
does not solve anything (except hiding also the warning).

Best regards,
Krzysztof
