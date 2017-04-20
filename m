From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/1] pwm: pca9685: fix gpio-only operation.
Date: Thu, 20 Apr 2017 10:29:36 +0300
Message-ID: <CAHp75VdaDP8GZGz5ZkKpSDdszjRzA+Miw=K7d_g3aeKTN4Ce=A@mail.gmail.com>
References: <1492088291-5215-1-git-send-email-svenv@arcx.com>
 <1492088291-5215-2-git-send-email-svenv@arcx.com> <1492506852.24567.54.camel@linux.intel.com>
 <CAGngYiWj1jBsgYAL31Qb2Ne+Te34vpjWD14xbV+u9vRS0i8kkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34816 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbdDTH3j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Apr 2017 03:29:39 -0400
In-Reply-To: <CAGngYiWj1jBsgYAL31Qb2Ne+Te34vpjWD14xbV+u9vRS0i8kkQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Clemens Gruber <clemens.gruber@pqgruber.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sven Van Asbroeck <TheSven73@googlemail.com>

On Tue, Apr 18, 2017 at 6:52 PM, Sven Van Asbroeck <thesven73@gmail.com> wrote:
> Thanks for the feedback Andy !!

You're welcome.

>
>> I would go with
>>
>> /* Wait for @sleep microseconds for the oscillator to be back up */
>> if (sleep)
>>  udelay(sleep);
>>
>> Otherwise int sleep is oddly here.
>>
>> Or
>>
>> bool sleep
>>
>> /* Wait 500us ... */
>> if (sleep)
>>  udelay(500);
>>
>>> +}
>
> I think you may be getting confused between:
> - the chip's SLEEP bit (int sleep)
> - the amount of time to delay after chip comes _out of_ sleep.
> (always 500 us)
>
> If it's confusing for you, it might be confusing for others?
> Perhaps change the parameter to 'bool sleep_bit' or 'bool do_sleep'
> to make the distinction clearer?

Taking above into consideration perhaps sleep is not quite good word
at all. By functional description it sounds like latency tolerance to
me.

>> __maybe_unused and remove ugly #ifdef:ery.
>
> If this works on non- CONFIG_PM systems, I'm all for it !
> Grepping the drivers/ directory, I see that some drivers use
> #ifdef CONFIG_PM, some use __maybe_unused for runtime_pm.

This approach kinda new that's why you see variety of approaches.

> Mika and Thierry, thoughts ?

At the end it's Thierry's call, so, I'm not insisting.

-- 
With Best Regards,
Andy Shevchenko
