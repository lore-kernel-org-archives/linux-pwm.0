From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v4 0/4] pwm: add support for ChromeOS EC PWM
Date: Mon, 18 Jul 2016 11:45:33 -0700
Message-ID: <20160718184532.GA131404@google.com>
References: <1468625324-41229-1-git-send-email-briannorris@chromium.org>
 <20160718084928.GA17074@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160718084928.GA17074@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Enric Balletbo <enric.balletbo-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Randall Spangler <rspangler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Nematbakhsh <shawnn-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gwendal Grignou <gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jul 18, 2016 at 09:49:28AM +0100, Lee Jones wrote:
> On Fri, 15 Jul 2016, Brian Norris wrote:
> > As this touches MFD (sort of), drivers/platform/chrome/, and drivers/pwm/, I'm
> > still not sure who it should all go through: Lee, Thierry, or Olof?
> 
> I usually take this type of submission through the MFD tree, although
> it's too late in the day to make it into v4.8.
> 
> Which Acks are you missing?

I think I was only missing Thierry's. If he's planning to take it
through his tree, then that's fine. It's also fine if it waits for 4.9,
if that helps, although I agree it has practically zero chances of
regressions.

But most importantly, I think various parties would like patch 1, so if
it doesn't make 4.8-rc1, then it's probably important it makes it into a
branch others can pull from if necessary.

Regards,
Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
