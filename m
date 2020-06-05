From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
Date: Fri, 5 Jun 2020 13:50:43 +0300
Message-ID: <CAHp75VfY0BD4CFu6Thx1wE-U0Zt1q8uTOLxkWTMdFk0MBuhYFQ@mail.gmail.com>
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-5-michael@walle.cc>
 <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com> <8f042c2442852c29519c381833f3d289@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8f042c2442852c29519c381833f3d289-QKn5cuLxLXY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thom
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 1:24 PM Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
> Am 2020-06-05 10:14, schrieb Andy Shevchenko:
> > On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:

...

> >> +static bool nowayout = WATCHDOG_NOWAYOUT;
> >> +module_param(nowayout, bool, 0);
> >> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started
> >> (default="
> >> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT)
> >> ")");
> >> +
> >> +static int timeout;
> >> +module_param(timeout, int, 0);
> >> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
> >
> > Guenter ACKed this, but I'm wondering why we still need module
> > parameters...
>
> How would a user change the nowayout or the timeout? For the latter
> there is
> a device tree entry, but thats not easy changable by the user.

Yes, it's more question to VIm and Guenter than to you.

...

> >> +       if (status & WDT_CTRL_EN) {
> >> +               sl28cpld_wdt_start(wdd);
> >
> >> +               set_bit(WDOG_HW_RUNNING, &wdd->status);
> >
> > Do you need atomic op here? Why?
>
> I'd say consistency, all watchdog drivers do it like that. I just
> had a look at where this is used, but it looks like access from
> userspace is protected by a lock.

Okay then.

-- 
With Best Regards,
Andy Shevchenko
