From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Wed, 26 Feb 2014 10:40:16 +0530
Message-ID: <CAKohpon44tVo7K-tPQns1yfs4pBNy9-vY5UPocrHfSPbQ7M5_A@mail.gmail.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
	<000d01cf328f$687d54b0$3977fe10$%han@samsung.com>
	<CAKohpo=xbZ4RNLDtdP3PokQwQksiKRBnuOTPL5z_zywwyOJC3w@mail.gmail.com>
	<000501cf32af$3ad0ecf0$b072c6d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:46733 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbaBZFKR (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 00:10:17 -0500
Received: by mail-oa0-f47.google.com with SMTP id h16so321720oag.6
        for <linux-pwm@vger.kernel.org>; Tue, 25 Feb 2014 21:10:16 -0800 (PST)
In-Reply-To: <000501cf32af$3ad0ecf0$b072c6d0$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>

On 26 February 2014 10:27, Jingoo Han <jg1.han@samsung.com> wrote:
> On Wednesday, February 26, 2014 1:49 PM, Viresh Kumar wrote:
>> On 26 February 2014 06:39, Jingoo Han <jg1.han@samsung.com> wrote:
>> > The site-specific OOM messages are unnecessary, because they
>> > duplicate the MM subsystem generic OOM message.
>> >
>> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>> > ---
>> >  drivers/pwm/pwm-spear.c |    4 +---
>> >  1 file changed, 1 insertion(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
>> > index 8ad26b8..b4f6d0d 100644
>> > --- a/drivers/pwm/pwm-spear.c
>> > +++ b/drivers/pwm/pwm-spear.c
>> > @@ -179,10 +179,8 @@ static int spear_pwm_probe(struct platform_device *pdev)
>> >         u32 val;
>> >
>> >         pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
>> > -       if (!pc) {
>> > -               dev_err(&pdev->dev, "failed to allocate memory\n");
>>
>> Can you please pin point which/file line will print similar message ?
>
> (+cc Joe Perches, Andrew Morton)
>
> Sorry, I cannot pin point the exact file line.
> As far as I know, the similar message will be printed,
> because k.alloc and v.alloc failures use dump_stack().

I have tried tracing calls here and I am unable to find
any such prints from these routines for majority of
failure paths. So its better somebody tells me that I am
wrong here :)
