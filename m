From: Ralph Sennhauser <ralph.sennhauser-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 0/4] gpio: mvebu: Add PWM fan support
Date: Thu, 13 Apr 2017 09:49:04 +0200
Message-ID: <20170413094904.4fdd9b89@gmail.com>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
 <20170412171656.GC11964@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170412171656.GC11964-EkSeR96xj6Pcmrwk2tT4+A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 12 Apr 2017 19:16:56 +0200
Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Sun, Apr 09, 2017 at 08:09:26PM +0200, Ralph Sennhauser wrote:
> > Hi Therry,
> > 
> > Resending this as v5 with some minor changes since v4. What is
> > missing is an ACK from you so Linus can merge the driver and
> > Gregory the dts changes. For this driver to make it into 4.12 it
> > would be nice to have it in next soon. I hope you can make some
> > room in your schedule to have another look at this series.
> > 
> > Thanks
> > Ralph
> > 
> > ---
> > 
> > Notes:
> > 
> >   About npwm = 1:
> >     The only way I can think of to achieve that requires reading the
> >     GPIO line from the device tree. This would prevent a user to
> >     dynamically choose a line. Which is fine for the fan found on
> > Mamba but let's take some development board with freely accessible
> > GPIOs and suddenly we limit the use of this driver. Given the
> > above, npwm = ngpio with only one usable at a time is a more
> > accurate  
> 
> I think "accurate" is perhaps not the word I'd choose. "npwm" is
> defined as "number of PWMs controlled by this chip", and that's
> effectively just the one. It's implied that all PWMs exposed by a
> chip can be used concurrently.

I'm not native English so some terms might be off a tad in how I use
them, replace accurate with what you think I meant ;).

The "it's implied" sounds like a contract and EBUSY a violation thereof.

> 
> Anyway, I can see how npwm = ngpio might be more convenient, and if
> that is what you want to do, I don't feel strongly enough to object.

The goal is a pwm-fan driver for Mamba. So npwm=1 would work just fine
from that stand point. It's indeed the sysfs case I had in mind which
would be hampered. Whether to consider that one valid / desirable I
don't want to judge. For me it's a hypothetical use case for others it
might be real.

For this series I want just this one device to work and getting the
bindings right to not prevent others extending the driver later when
they need.

The driver which is under rework here is in use for 2 years, so I went
with the feature set provided by it which is more than I need. It's a
one of it's kind driver and I only have this single use case, so really
your call.

Thanks
Ralph
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
