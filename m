From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv6 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM.
Date: Mon, 2 Dec 2013 07:17:56 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828E1A04@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-5-git-send-email-Li.Xiubo@freescale.com>
 <20131128213159.GE14689@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20131128213159.GE14689@mithrandir>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <Shawn.Guo@freescale.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

> 
> > +    "ftm0" (module clock),
> > +    "ftm0_counter" (counter clock),
> > +- clocks : Must contain a clock specifier for each entry in
> > +clock-names,
> > +  See clock/clock-bindings.txt for details of the property values.
> 
> Note that the order is significant here, at least from the way the driver
> currently implements this. You can probably make this more generic in the
> driver by using of_property_match_string() on the clock-names property to
> find the index of "ftm0_counter" and pass that index to the
> of_parse_phandle_with_args() function to cope with the situation where the
> device tree has the clocks in a different order.
> 

Yes, that's much better.

