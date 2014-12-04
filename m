From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2] pwm: atmel-hlcdc: add at91sam9x5 and sama5d3 errata
 handling
Date: Thu, 4 Dec 2014 14:29:23 +0100
Message-ID: <20141204142923.29eecfc6@bbrezillon>
References: <1416407589-8157-1-git-send-email-boris.brezillon@free-electrons.com>
	<20141204131229.GA7262@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:47398 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751370AbaLDN31 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Dec 2014 08:29:27 -0500
In-Reply-To: <20141204131229.GA7262@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Thierry

On Thu, 4 Dec 2014 14:12:31 +0100
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Nov 19, 2014 at 03:33:09PM +0100, Boris Brezillon wrote:
> > at91sam9x5 has an errata forbidding the use of slow clk as a clk source and
> > sama5d3 SoCs has another errata forbidding the use of div1 prescaler.
> > 
> > Take both of these erratas into account.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> > Hi Thierry,
> > 
> > I've addressed the "erratas stored in of_device_id data" part, but still
> > haven't modified the compatible strings of the HLCDC subdevices.
> > 
> > Please let me know if you really want to handle erratas through pwm
> > compatibles instead of parent device compatibles.
> > 
> > Regards,
> > 
> > Boris
> > 
> > Changes since v1:
> > - use data field in of_device_id to attach erratas to an IP revision
> > 
> >  drivers/pwm/pwm-atmel-hlcdc.c | 50 ++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> I applied this, but this was really much more difficult than I would've
> wanted. Since the MFD driver hasn't been merged into Linus' tree yet I
> wasn't able to actually build test this driver at all without manually
> pulling in the patches that add the MFD support. I went through this
> trouble this time because it's what we had agreed upon, but for the
> record, next time I'll request a stable branch that I can pull into the
> PWM tree to resolve this kind of dependency. Or patches will have to
> wait until the next merge window. I don't want to have to jump through
> hoops just to make sure the code in my tree actually compiles.

Thanks for doing that.
Just for my understanding, am I the one responsible for providing this
stable branch, or were you expecting Lee to provide it ?

> 
> Oh, and it's good that I do compile tests because...
> 
> > diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> [...]
> > +const struct atmel_hlcdc_pwm_erratas atmel_hlcdc_pwm_at91sam9x5_erratas = {
> > +	.slow_clk_errata = true,
> > +};
> > +
> > +const struct atmel_hlcdc_pwm_erratas atmel_hlcdc_pwm_sama5d3_erratas = {
> > +	.div1_clk_errata = true,
> > +};
> 
> ... these actually should be static.
> 
> Also I took the liberty of substituting "erratum" for "errata" and
> "errata" for "erratas".

Indeed, thanks for fixing those problems.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
