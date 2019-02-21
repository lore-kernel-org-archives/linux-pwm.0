From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 5/8] iio/counter: add FlexTimer Module Quadrature decoder
 counter driver
Date: Thu, 21 Feb 2019 17:28:21 +0900
Message-ID: <20190221082758.GA3380@icarus>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-5-patrick.havelange@essensium.com>
 <20190220164154.00547a77@archlinux>
 <20190221010931.GA3471@icarus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190221010931.GA3471@icarus>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Esben Haabendal <esben@haabendal.dk>, Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Feb 21, 2019 at 10:09:54AM +0900, William Breathitt Gray wrote:
> On Wed, Feb 20, 2019 at 04:41:54PM +0000, Jonathan Cameron wrote:
> > On Mon, 18 Feb 2019 15:03:18 +0100
> > Patrick Havelange <patrick.havelange@essensium.com> wrote:
> > 
> > > This driver exposes the counter for the quadrature decoder of the
> > > FlexTimer Module, present in the LS1021A soc.
> > > 
> > > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > > Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> > Given you cc'd William, I'm guessing you know about the counter
> > subsystem effort.  I would really rather not take any drivers
> > into IIO if we have any hope of getting that upstreamed soon
> > (which I personally think we do and should!).  The reason is
> > we end up having to maintain old ABI just because someone might be using
> > it and it makes the drivers very messy.
> > 
> > I'll review as is though as may be there are some elements that will
> > cross over.
> > 
> > Comments inline.  William: Looks like a straight forward conversion if
> > it makes sense to get this lined up as part of your initial submission?
> > You have quite a few drivers so I wouldn't have said it needs to be there
> > at the start, but good to have it soon after.
> > 
> > Jonathan
> 
> I agree, we should try to merge this as part of Counter subsystem
> introduction rather than as another IIO Counter driver. As we determined
> when adding support for the STM32 timers, the existing IIO Counter API
> is fundamentally unsuitable for representing counter devices. So
> regardless of how a new Counter API is merged, the existing IIO Counter
> API must be deprecated.
> 
> Patrick, I apologize for the confusion this has caused. Would you be
> able to convert this driver to use the proposed Counter subsystem API
> from this patchset that I believe you encountered before:
> https://marc.info/?l=linux-arm-kernel&m=153229982404051
> 
> Although it was last updated in October, I believe you should be able to
> rebase that Counter subsystem introduction patchset cleanly on top of
> the IIO tree (if there are any merge conflicts send me an email). Take a
> look at the generic-counter.rst file under the Documentation/driver-api/
> directory for an overview of the API; the counter drivers under the
> drivers/counter/ directory also make good references.
> 
> If you have any difficulties understanding the API, or any other
> troubles, don't hesitate to ask. Hopefully, I've made the documentation
> clear enough to make the conversion of this driver quick and easy -- and
> if not, then it's something I need to fix, so let me know. :-)
> 
> William Breathitt Gray

Patrick,

It looks like there were some minor conflicts with the v9 patchset, so
I've rebased it on top of the latest iio tree testing branch and
resolved the conflicts in my personal repository. Please pull from my
personal repository at https://gitlab.com/vilhelmgray/iio.git and base
your patches on top of the generic_counter_v10 branch.

William Breathitt Gray
