From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v4 4/4] misc: atmel_tclib: get and use slow clock
Date: Mon, 5 Oct 2015 18:58:16 +0200
Message-ID: <20151005165816.GI2694@piout.net>
References: <1439717026-30634-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1439717026-30634-5-git-send-email-alexandre.belloni@free-electrons.com>
 <20151005152706.GC17612@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151005152706.GC17612@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 05/10/2015 at 17:27:06 +0200, Thierry Reding wrote :
> On Sun, Aug 16, 2015 at 11:23:46AM +0200, Alexandre Belloni wrote:
> > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> > 
> > Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
> > hang") added a workaround for the slow clock as it is not properly handled
> > by its users.
> > 
> > Get and use the slow clock as it is necessary for the timer counters.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: linux-pwm@vger.kernel.org
> >  drivers/clocksource/tcb_clksrc.c | 10 +++++++++-
> >  drivers/misc/atmel_tclib.c       |  4 ++++
> >  drivers/pwm/pwm-atmel-tcb.c      | 26 +++++++++++++++++++-------
> >  include/linux/atmel_tc.h         |  1 +
> >  4 files changed, 33 insertions(+), 8 deletions(-)
> 
> This doesn't seem to apply anymore. Does it need to be rebased? Or do I
> need some other patch as a dependency?
> 

It will apply cleanly after [PATCH v4 3/4] clocksource: tcb_clksrc: fix
setup_clkevents error path

It already has Daniel's ack so you can also take it if you want. Else,
we can take it through at91.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
