From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
Date: Fri, 5 Jun 2020 17:09:11 +0300
Message-ID: <20200605140911.GO2428291@smile.fi.intel.com>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-5-michael@walle.cc>
 <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
 <8f042c2442852c29519c381833f3d289@walle.cc>
 <CAHp75VfY0BD4CFu6Thx1wE-U0Zt1q8uTOLxkWTMdFk0MBuhYFQ@mail.gmail.com>
 <871a4990-5b94-3a17-01d4-74998375f08b@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <871a4990-5b94-3a17-01d4-74998375f08b-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>, "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 05, 2020 at 06:52:00AM -0700, Guenter Roeck wrote:
> On 6/5/20 3:50 AM, Andy Shevchenko wrote:
> > On Fri, Jun 5, 2020 at 1:24 PM Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
> >> Am 2020-06-05 10:14, schrieb Andy Shevchenko:
> >>> On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:

...

> >>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
> >>>> +module_param(nowayout, bool, 0);
> >>>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started
> >>>> (default="
> >>>> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT)
> >>>> ")");
> >>>> +
> >>>> +static int timeout;
> >>>> +module_param(timeout, int, 0);
> >>>> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
> >>>
> >>> Guenter ACKed this, but I'm wondering why we still need module
> >>> parameters...
> >>
> >> How would a user change the nowayout or the timeout? For the latter
> >> there is
> >> a device tree entry, but thats not easy changable by the user.
> > 
> > Yes, it's more question to VIm and Guenter than to you.
> > 
> 
> Has support for providing module parameters with the kernel command line
> been discontinued/deprecated, or did it run out of favor ? Sorry if I
> missed that.

Latter according to Greg KH. One of the (plenty) examples [1].

[1]: https://www.mail-archive.com/driverdev-devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org/msg96495.html

> nowayout has a configuration default. A module parameter is sometimes
> provided by drivers to be able to override it. The timeout provided
> via devicetree or on the command line is only the initial/default
> timeout, and the watchdog daemon can change it after opening the
> watchdog device as it sees fit.

Thanks for explanation.

-- 
With Best Regards,
Andy Shevchenko
