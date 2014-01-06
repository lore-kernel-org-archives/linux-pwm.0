From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] pwm: Add CLPS711X PWM support
Date: Mon, 6 Jan 2014 16:27:29 +0000
Message-ID: <20140106162729.GH24664@e106331-lin.cambridge.arm.com>
References: <1388547821-10029-1-git-send-email-shc_work@mail.ru>
 <20140106161233.GB6721@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:65448 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754752AbaAFQ1f (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jan 2014 11:27:35 -0500
Content-Disposition: inline
In-Reply-To: <20140106161233.GB6721@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Jan 06, 2014 at 04:12:35PM +0000, Thierry Reding wrote:
> On Wed, Jan 01, 2014 at 07:43:41AM +0400, Alexander Shiyan wrote:
> > Add a new driver for the PWM controllers on the CLPS711X platform
> > based on the PWM framework.
> 
> I think you can drop the last part ("based on the PWM framework") of
> that sentence. Perhaps a good idea would be to mention some of the
> peculiarities of this controller (supports two channels, only 4 bits
> specifying the duty-cycle, fixed period, ...).
> 
> > diff --git a/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt b/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt
> > new file mode 100644
> > index 0000000..4caf819
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt
> > @@ -0,0 +1,16 @@
> > +* Cirris Logic CLPS711X PWM controller
> > +
> > +Required properties:
> > +- compatible: Should be "cirrus,clps711x-pwm".
> > +- reg: Physical base address and length of the controller's registers.
> > +- clocks: Phandle to the PWM source clock.
> 
> "phandle"

plus clock-specifier.

> 
> > +- #pwm-cells: Should be 1. See pwm.txt in this directory for a description of
> > +  the cells format.
> 
> Perhaps in this case it would be easier to simply mention that the cell
> specifies the index of the channel. pwm.txt isn't explicit about what a
> specifier of size 1 looks like (although it is sort of implied).

Yes please.

Thanks,
Mark.
