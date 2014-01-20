From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: PWM...
Date: Mon, 20 Jan 2014 08:24:23 +0100
Message-ID: <20140120072423.GB19940@pengutronix.de>
References: <20140119164956.GR15937@n2100.arm.linux.org.uk>
 <CAOesGMi7g=PHjzhkuObkeu+P_c6kUz5uFcND7euafUW56CvsnQ@mail.gmail.com>
 <20140119193026.GS15937@n2100.arm.linux.org.uk>
 <201401192126.41543.arnd@arndb.de>
 <20140120001446.GD9752@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36975 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaATHYd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2014 02:24:33 -0500
Content-Disposition: inline
In-Reply-To: <20140120001446.GD9752@verge.net.au>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pwm@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "arm@kernel.org" <arm@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jan 20, 2014 at 09:14:46AM +0900, Simon Horman wrote:
> On Sun, Jan 19, 2014 at 09:26:40PM +0100, Arnd Bergmann wrote:
> > On Sunday 19 January 2014, Russell King - ARM Linux wrote:
> > > On Sun, Jan 19, 2014 at 11:11:41AM -0800, Olof Johansson wrote:
> > > > On Sun, Jan 19, 2014 at 11:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > > > Ah, yes, if you add a cell that can be done. There'll still be the
> > > > "dead" first cell that will always be 0, but that's alright.
> > > 
> > > Does it not mean that PWM specifications of:
> > > 
> > >         <&pwm1 0 n> <&pwm2 0 n>
> > > 
> > > would need to be converted to:
> > > 
> > >         <&pwm1 0 n 0> <&pwm2 0 n 0>
> > > 
> > > in every DT file referring to these PWMs - because isn't this just
> > > treated in DT as one single array of values?  (If DT knew how many
> > > were in each specification, we wouldn't need the #foo-cells...)
> > 
> > Right: if you change an existing dts file from #pwm-cells=<2> to
> > #pwm-cells=<3>, that requires changing all references to the pwm
> > controller at the same time. If both the per-soc .dtsi files
> > and the per-board .dts files contain references to the same pwm
> > controller, that can end up in significant work. I have not checked
> > if this is the case for i.MX though.
> 
> Would this change imply that old dtbs would no longer work with new kernels?

Not necessarily. With Lothars patch the driver works with pwm-cells=2
and pwm-cells=3. The only problem is that if you compile an old board
dts with a new SoC dtsi it will silently fail since the pwm-cells
setting doesn't match the atcual cells in the dts.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
