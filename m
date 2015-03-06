From: Matt Porter <mporter@konsulko.com>
Subject: Re: [PATCH] pwm: imx-pwm: add explicit compatible strings and
 required clock properties
Date: Fri, 6 Mar 2015 11:37:21 -0500
Message-ID: <20150306163721.GL19577@beef>
References: <1425654554-7849-1-git-send-email-mporter@konsulko.com>
 <CAL_JsqJ+NL+0Hfu-La=NwzvOEHf0xE-D6EakJv6gnYYOS1oYrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38844 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352AbbCFQhY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Mar 2015 11:37:24 -0500
Received: by igbhl2 with SMTP id hl2so5074315igb.3
        for <linux-pwm@vger.kernel.org>; Fri, 06 Mar 2015 08:37:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ+NL+0Hfu-La=NwzvOEHf0xE-D6EakJv6gnYYOS1oYrA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Mar 06, 2015 at 09:16:44AM -0600, Rob Herring wrote:
> On Fri, Mar 6, 2015 at 9:09 AM, Matt Porter <mporter@konsulko.com> wrote:
> > The imx-pwm binding contains language indicating compatible
> > strings to be used that is not valid for all supported parts
> > e.g. Should be "fsl,<soc>-pwm". Fix this by enumerating the
> > valid compatible strings that represent the two versions of
> > this peripheral in use.
> >
> > The binding is also missing the clocks/clock-names properties
> > so document these,the two required ipg and per clocks, and add
> > add these properties to the example.
> >
> > Signed-off-by: Matt Porter <mporter@konsulko.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/imx-pwm.txt | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > index b50d7a6d..30d2b82 100644
> > --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> > @@ -1,10 +1,16 @@
> >  Freescale i.MX PWM controller
> >
> >  Required properties:
> > -- compatible: should be "fsl,<soc>-pwm"
> > +- compatible :
> > +  - "fsl,imx1-pwm" for PWM compatible with the one integrated on i.MX1
> > +  - "fsl,imx27-pwm" for PWM compatible with the one integrated on i.MX27
> 
> This should be one of these and a more specific value as the example
> below shows.

Ok, yes, I wasn't sure if that was expected to be explicit in the bindings
or not as others don't seem to represent that properly. What about this?

- compatible: should be "fsl,<soc>-pwm" and one of the following
              compatible strings:
	      	"fsl,imx1-pwm" for an iMX1 compatible PWM
	      	"fsl,imx27-pwm" for an iMX27 compatible PWM

> >  - reg: physical base address and length of the controller's registers
> >  - #pwm-cells: should be 2. See pwm.txt in this directory for a description of
> >    the cells format.
> > +- clocks : Clock specifiers for both ipg and per clocks.
> > +- clock-names : Clock names should include both "ipg" and "per"
> > +See the clock consumer binding,
> > +       Documentation/devicetree/bindings/clock/clock-bindings.txt
> >  - interrupts: The interrupt for the pwm controller
> >
> >  Example:
> > @@ -13,5 +19,8 @@ pwm1: pwm@53fb4000 {
> >         #pwm-cells = <2>;
> >         compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
> >         reg = <0x53fb4000 0x4000>;
> > +       clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
> > +                <&clks IMX5_CLK_PWM1_HF_GATE>;
> > +       clock-names = "ipg", "per";
> >         interrupts = <61>;
> >  };
> > --
> > 1.8.4
> >
