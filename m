From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
Date: Fri, 5 Jun 2020 09:34:35 -0700
Message-ID: <450ce146-bf9a-130a-78e5-4bcabf1b7063@roeck-us.net>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-5-michael@walle.cc>
 <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
 <8f042c2442852c29519c381833f3d289@walle.cc>
 <CAHp75VfY0BD4CFu6Thx1wE-U0Zt1q8uTOLxkWTMdFk0MBuhYFQ@mail.gmail.com>
 <871a4990-5b94-3a17-01d4-74998375f08b@roeck-us.net>
 <20200605140911.GO2428291@smile.fi.intel.com>
 <20200605150542.GA254229@roeck-us.net>
 <CAHp75VduUG=XkvyZwdZDNqBh3KE67MWZWgqBN67fN6StAa469w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VduUG=XkvyZwdZDNqBh3KE67MWZWgqBN67fN6StAa469w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>, "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On 6/5/20 9:04 AM, Andy Shevchenko wrote:
> On Fri, Jun 5, 2020 at 6:05 PM Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
>> On Fri, Jun 05, 2020 at 05:09:11PM +0300, Andy Shevchenko wrote:
>>> On Fri, Jun 05, 2020 at 06:52:00AM -0700, Guenter Roeck wrote:
>>>> On 6/5/20 3:50 AM, Andy Shevchenko wrote:
>>>>> On Fri, Jun 5, 2020 at 1:24 PM Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
>>>>>> Am 2020-06-05 10:14, schrieb Andy Shevchenko:
>>>>>>> On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
>>>
>>> ...
>>>
>>>>>>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>>>>>>>> +module_param(nowayout, bool, 0);
>>>>>>>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started
>>>>>>>> (default="
>>>>>>>> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT)
>>>>>>>> ")");
>>>>>>>> +
>>>>>>>> +static int timeout;
>>>>>>>> +module_param(timeout, int, 0);
>>>>>>>> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
>>>>>>>
>>>>>>> Guenter ACKed this, but I'm wondering why we still need module
>>>>>>> parameters...
>>>>>>
>>>>>> How would a user change the nowayout or the timeout? For the latter
>>>>>> there is
>>>>>> a device tree entry, but thats not easy changable by the user.
>>>>>
>>>>> Yes, it's more question to VIm and Guenter than to you.
>>>>>
>>>>
>>>> Has support for providing module parameters with the kernel command line
>>>> been discontinued/deprecated, or did it run out of favor ? Sorry if I
>>>> missed that.
>>>
>>> Latter according to Greg KH. One of the (plenty) examples [1].
>>>
>>> [1]: https://www.mail-archive.com/driverdev-devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org/msg96495.html
>>>
>> What is the suggested replacement ?
> 
> In some mails he suggested to use sysfs.
> 

Using sysfs specifically to defeat "nowayout" would defeat
its purpose, which is specifically to disable the possibility
to stop the watchdog. Using a module parameter (or rather boot
time parameter) is a bit different since that has to be done
consciously and is only valid for a given boot. The same is
true for the timeout parameter. If one can wait for sysfs (or
userspace) to be active, one can as well use the watchdog
daemon to update the timeout. The use case for the module
/ command line parameter or sysfs based timeout is to be
able to set it _before_ userspace is active.

So sysfs is not really an alternative.

Guenter
