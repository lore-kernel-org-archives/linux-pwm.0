From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 6/6] [media] Only descend into directory when CONFIG_MEDIA_SUPPORT is set
Date: Fri, 06 Jan 2017 00:12:13 +0100
Message-ID: <32595176.b3HvexHCfd@wuerfel>
References: <20170105210158.14204-1-afd@ti.com> <4225650.R96pl5clWf@wuerfel> <f29ea3de-efb1-a406-db3e-b048e677f3a8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f29ea3de-efb1-a406-db3e-b048e677f3a8-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lauro Ramos Venancio <lauro.venancio-430g2QfJUUCGglJvpFV4uA@public.gmane.org>, Aloisio Almeida Jr <aloisio.almeida-430g2QfJUUCGglJvpFV4uA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Thursday, January 5, 2017 4:35:33 PM CET Andrew F. Davis wrote:
> On 01/05/2017 03:42 PM, Arnd Bergmann wrote:
> > On Thursday, January 5, 2017 3:01:58 PM CET Andrew F. Davis wrote:
> >> @@ -109,7 +109,8 @@ obj-$(CONFIG_SERIO)         += input/serio/
> >>  obj-$(CONFIG_GAMEPORT)         += input/gameport/
> >>  obj-$(CONFIG_INPUT)            += input/
> >>  obj-$(CONFIG_RTC_LIB)          += rtc/
> >> -obj-y                          += i2c/ media/
> >> +obj-y                          += i2c/
> >> +obj-$(CONFIG_MEDIA_SUPPORT)    += media/
> >>  obj-$(CONFIG_PPS)              += pps/
> >>  obj-y                          += ptp/
> >>  obj-$(CONFIG_W1)               += w1/
> >>
> > 
> > This one seems wrong: if CONFIG_MEDIA_SUPPORT=m, but some I2C drivers
> > inside of drivers/media/ are built-in, we will fail to enter the directory,
> > see drivers/media/Makefile.
> 
> Not sure if I see this, it looks like everything in drivers/media/
> depends on CONFIG_MEDIA_SUPPORT (directly or indirectly). If
> CONFIG_MEDIA_SUPPORT is =m then all dependents should be locked out of
> being built-in.
> 
> Any bool symbol that controls compilation of source that depends on a
> tristate symbol is broken and should be fixed anyway.

I don't think it's this easy, we have a couple of cases where that doesn't
work. I have not looked at the media example in detail, but at least it
looks intentional.

Note that drivers/media is rather creative with expressing dependencies.

	Arnd
