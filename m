From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v8 1/2] mfd: add atmel-hlcdc driver
Date: Tue, 7 Oct 2014 13:41:12 +0200
Message-ID: <20141007134112.40179e8a@bbrezillon>
References: <1412603324-18789-1-git-send-email-boris.brezillon@free-electrons.com>
	<1412603324-18789-2-git-send-email-boris.brezillon@free-electrons.com>
	<20141007094427.GW25331@lee--X1>
	<20141007094727.GA12631@ulmo>
	<20141007095932.GY25331@lee--X1>
	<20141007100632.GA31575@ulmo>
	<20141007101743.GA25331@lee--X1>
	<20141007111304.GA1539@ulmo>
	<20141007113814.GA3693@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33238 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751056AbaJGLlQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 07:41:16 -0400
In-Reply-To: <20141007113814.GA3693@lee--X1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org

On Tue, 7 Oct 2014 12:38:14 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Tue, 07 Oct 2014, Thierry Reding wrote:
> 
> > On Tue, Oct 07, 2014 at 11:17:43AM +0100, Lee Jones wrote:
> > > On Tue, 07 Oct 2014, Thierry Reding wrote:
> > > 
> > > > On Tue, Oct 07, 2014 at 10:59:32AM +0100, Lee Jones wrote:
> > > > > On Tue, 07 Oct 2014, Thierry Reding wrote:
> > > > > 
> > > > > > On Tue, Oct 07, 2014 at 10:44:27AM +0100, Lee Jones wrote:
> > > > > > > On Mon, 06 Oct 2014, Boris Brezillon wrote:
> > > > > > > 
> > > > > > > > The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91sam9x5
> > > > > > > > family or sama5d3 family) exposes 2 subdevices:
> > > > > > > > - a display controller (controlled by a DRM driver)
> > > > > > > > - a PWM chip
> > > > > > > > 
> > > > > > > > The MFD device provides a regmap and several clocks (those connected
> > > > > > > > to this hardware block) to its subdevices.
> > > > > > > > 
> > > > > > > > This way concurrent accesses to the iomem range are handled by the regmap
> > > > > > > > framework, and each subdevice can safely access HLCDC registers.
> > > > > > > > 
> > > > > > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > > > > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > > Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
> > > > > > > > Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > > > > > > ---
> > > > > > > >  drivers/mfd/Kconfig             |   6 ++
> > > > > > > >  drivers/mfd/Makefile            |   1 +
> > > > > > > >  drivers/mfd/atmel-hlcdc.c       | 122 ++++++++++++++++++++++++++++++++++++++++
> > > > > > > >  include/linux/mfd/atmel-hlcdc.h |  85 ++++++++++++++++++++++++++++
> > > > > > > >  4 files changed, 214 insertions(+)
> > > > > > > >  create mode 100644 drivers/mfd/atmel-hlcdc.c
> > > > > > > >  create mode 100644 include/linux/mfd/atmel-hlcdc.h
> > > > > > > 
> > > > > > > Applied for v3.19.
> > > > > > 
> > > > > > Will you provide a stable branch that I can pull into the PWM tree?
> > > > > 
> > > > > I hadn't planned on it.  What do you need that for?
> > > > 
> > > > Because the PWM driver depends on this series. But if you prefer you
> > > > could also take the PWM driver through your tree.
> > > 
> > > Probably better to deal with that via Kconfig.
> > 
> > Do you have any suggestions? The PWM driver currently selects the
> > MFD_ATMEL_HLCDC symbol, which as I understand will cause a Kconfig error
> > if the latter isn't defined.
> 
> s/select/depends on/ for the desired effect.
> 

Don't forget the atmel-hlcdc.h header file which is referenced by both
the DRM and the PWM drivers.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
