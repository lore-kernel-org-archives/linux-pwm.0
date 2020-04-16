From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Date: Thu, 16 Apr 2020 16:36:45 +0200
Message-ID: <20200416143645.GN657811@lunn.ch>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
 <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
 <20200416135039.GL657811@lunn.ch>
 <20200416142944.GH25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200416142944.GH25745-QEMnZ+CodIVURfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux admin <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe Kleine-Konig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

> I said in the cover message "The cooling maps are experimental".
> They work reasonably well for me with the fan I have (a noctua fan)
> but other people may find them to be problematical, so one of the
> reasons for sending it as RFC is to get people to test and see how
> well it works.

Hi Russell

Maybe split the PWM parts from the cooling maps? I don't see any
reason not to merge the PWM parts.

Maybe sometime later I might take a closer look at the maps. I have a
wrt1900ac, which is Armada XP based. It has a fan on a GPIO pin. I
currently have a userspace daemon controlling the fan based on hwmon
device data. Getting the kernel to do it all would be nice.

       Andrew
