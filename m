From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 2/4] mfd: cros_ec: add EC_PWM function definitions
Date: Mon, 20 Jun 2016 10:56:39 -0700
Message-ID: <20160620175639.GA42842@google.com>
References: <1464916904-37554-1-git-send-email-briannorris@chromium.org>
 <1464916904-37554-3-git-send-email-briannorris@chromium.org>
 <20160616153817.GD21702@dell>
 <CAD=FV=X8eOQLbdAseL2_JwpOFNjSLDAi9hX=NrE=CfrrTZfAmA@mail.gmail.com>
 <20160617080635.GG21702@dell>
 <CAD=FV=UUJt4vBwHJrUYrKN56dv2YqdW3R7wah7-_PqyQ=YYr7Q@mail.gmail.com>
 <20160620080051.GJ21702@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160620080051.GJ21702@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Enric Balletbo <enric.balletbo-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Randall Spangler <rspangler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Shawn Nematbakhsh <shawnn-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gwendal Grignou <gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Lee,

On Mon, Jun 20, 2016 at 09:00:51AM +0100, Lee Jones wrote:
> On Fri, 17 Jun 2016, Doug Anderson wrote:
> > On Fri, Jun 17, 2016 at 1:06 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > >> Probably the reason for all of these non-kernel-isms is that this
> > >> isn't a kernel file.  From the top of the file:
> > >>
> > >>  * NOTE: This file is copied verbatim from the ChromeOS EC Open Source
> > >>  * project in an attempt to make future updates easy to make.
> > >>
> > >> So the source of truth for this file is
> > >> <https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h>.
> > >>
> > >> Someone could probably submit a CL to that project to make it a little
> > >> more kernel-ish and then we'd have to see if the EC team would accept
> > >> such changes...
> > >
> > > Hmmm... that kinda puts me in a difficult position.  Do I except
> > > non-kernel code, which does not conform to our stands?
> > 
> > What about if Brian made sure to just fully copy the latest version of
> > "cros_ec_commands.h" from the EC codebase and changed this commit
> > message to say:
> > 
> > Copy the latest version of "cros_ec_commands.h" from the Chrome OS EC
> > code base, which is the source of truth for this file.  See
> > <https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h>.
> > 
> > From the commit message it would be clear that this is an external
> > file linked into the kernel for convenience.
> > 
> > 
> > > Naturally I'd be happier if you could try to make the code more
> > > 'kernely'.  The practices I mention above are still good ones, even if
> > > you're not writing kernel specific code.
> > 
> > In general requesting that code from outside the kernel conform to
> > "kerneldoc" seems like a bit of a stretch.  In general having some
> > type of parse-able format for comments is nice, but I could see that
> > in the Chrome OS EC codebase it would be a bit overkill.
> 
> It's unfortunate that kerneldoc is named so, since I think it's a nice
> way to write structure/function headers regardless of code base and
> not overkill at all.  It's certainly harder to convince !kernel code
> to use the format, or at least easier for others to push back due to
> the fact that is has 'kernel' in the name.
> 
> > Also: it would be awfully strange if we suddenly started changing the
> > coding convention of this file or we had half the file in one
> > convention and half in another.  The rest of this file is in EC
> > convention and it seems sane to keep it that way...
> 
> Right.  It's also a shame we're only catching this now.  Really we
> should have had this discussion in the first instance.

Well, I see your sign-off on 2 of 4 patches to this file :)

> Taking into consideration that this file is already in the kernel and
> that it's current format is also represented, I'm willing to keep
> adding to it.

Thanks, that seems quite reasonable.

> I would like to see an internal request to adopt
> so-called kerneldoc.  Not because I am wish to blindly push our
> standards to other code-bases, but because I am an advocate of the
> format in general.

As mentioned in another branch of this thread, such a request has
already been made (and it's public, so feel free to follow if you're
so inclined):

https://bugs.chromium.org/p/chromium/issues/detail?id=621123

It seems as if the firmware authors have already agreed that adopting a
more consistent style like kerneldoc would be a net postive. So you
should expect to eventually see a patch to update this file. But in the
meantime, I think it would make things sanest if we update the file
incrementally until that is done.

Regards,
Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
