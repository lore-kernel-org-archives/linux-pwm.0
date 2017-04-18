From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v4 1/1] pwm: pca9685: fix gpio-only operation.
Date: Tue, 18 Apr 2017 11:52:49 -0400
Message-ID: <CAGngYiWj1jBsgYAL31Qb2Ne+Te34vpjWD14xbV+u9vRS0i8kkQ@mail.gmail.com>
References: <1492088291-5215-1-git-send-email-svenv@arcx.com>
 <1492088291-5215-2-git-send-email-svenv@arcx.com> <1492506852.24567.54.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1492506852.24567.54.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, Mika Westerberg <mika.westerberg@linux.intel.com>, Sven Van Asbroeck <TheSven73@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

Thanks for the feedback Andy !!

> I would go with
>
> /* Wait for @sleep microseconds for the oscillator to be back up */
> if (sleep)
>  udelay(sleep);
>
> Otherwise int sleep is oddly here.
>
> Or
>
> bool sleep
>
> /* Wait 500us ... */
> if (sleep)
>  udelay(500);
>
>> +}

I think you may be getting confused between:
- the chip's SLEEP bit (int sleep)
- the amount of time to delay after chip comes _out of_ sleep.
(always 500 us)

If it's confusing for you, it might be confusing for others?
Perhaps change the parameter to 'bool sleep_bit' or 'bool do_sleep'
to make the distinction clearer?

> __maybe_unused and remove ugly #ifdef:ery.

If this works on non- CONFIG_PM systems, I'm all for it !
Grepping the drivers/ directory, I see that some drivers use
#ifdef CONFIG_PM, some use __maybe_unused for runtime_pm.

Mika and Thierry, thoughts ?
