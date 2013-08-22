Return-Path: <t.figa@samsung.com>
From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 4/4] Documentation: Add device tree bindings for Freescale
 FTM PWM
Date: Thu, 22 Aug 2013 14:17:53 +0200
Message-id: <1889970.nK93apnFQd@amdc1227>
In-reply-to: 
 <1DD289F6464F0949A2FCA5AA6DC23F827D2539@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1522215.zHEjdiga8V@flatron>
 <1DD289F6464F0949A2FCA5AA6DC23F827D2539@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
List-ID: <linux-pwm.vger.kernel.org>
To: devicetree-discuss@lists.ozlabs.org
Cc: Xiubo Li-B47053 <B47053@freescale.com>, Tomasz Figa <tomasz.figa@gmail.com>, Guo Shawn-R65073 <r65073@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>

On Thursday 22 of August 2013 09:52:42 Xiubo Li-B47053 wrote:
> Hi Tomasz,
> 
> > > > If the meaning of flags cell is the same as in generic, default PWM
> > > > specifier format, then it should be noted here and generic PWM
> > > > binding documentation mentioned.
> > > 
> > > OK, How about the following ?
> > > - #pwm-cells: Should be 3. See pwm.txt in this directory for a
> > > 
> > >   description of the cells format.
> > 
> > I meant just the last cell, which stores flags, but actually this might
> > be a good idea, but with slightly extended description. Something among
> > those
> > 
> > lines:
> >  - #pwm-cells: Should be 3. The default three cell format specified by
> > 
> > generic PWM bindings are used. Refer to the documentation of generic
> > PWM
> > bindings for more information about the meaning of cells.
> 
> That's perfect.

OK.

> > > > > +- fsl,pwm-clk-ps: the ftm0 pwm clock's prescaler,
> > > > > divide-by 2^n(n = 0 ~ 7).
> > > > 
> > > > Is it a hardware-specific property?
> > > 
> > > Yes, I will revise it in v2.
> > 
> > I'd like to hear a bit more elaborate description of this property.
> > What
> > are the factors that decide what value should be used here?
> 
> Sorry, "the ftm0 pwm clock's prescaler" maybe also confuse you, it should
> be "the ftm pwm counter clock input prescaler".
> 
> The ftm's counter clock can be selected as :
> System clock,
> Fixed frequency clock,
> External clock.
> 
> And the ftm module clock has only system clock source.
> 
> The fixed frequency clock is an alternative clock source for the FTM
> counter that allows the selection of a clock other than the system clock
> or an external clock. This clock input is defined by chip integration.
> Due to FTM hardware implementation limitations, the frequency of the
> fixed frequency clock must not exceed 1/2 of the system clock frequency.
> 
> The external clock passes through a synchronizer clocked by the system
> clock to assure that counter transitions are properly aligned to system
> clock transitions.Therefore, to meet Nyquist criteria considering also
> jitter, the frequency of the external clock source must not exceed 1/4
> of the system clock frequency.
> 
> So, if the fixed frequency clock or external clock equal or exceed the
> system clock...

Can't the driver check the frequency of fixed or external clock and 
calculate optimal divisor value so that it is less than 1/4 of system clock 
frequency?

> > > > > +- fsl,pwm-number: the number of PWM devices, and is must equal
> > > > > to
> > > > > the
> > > > > number +  of "fsl,pwm-channels".
> > > > 
> > > > This is redundant, because you can simply count how many entries
> > > > have been specified in fsl,pwm-channels.
> > > 
> > > Yes, I will revise it in v2.
> > > And this would be renamed to " fsl,pwm-channel-number", which can be
> > > more Readable and understood.
> > 
> > I meant that you don't need to specify how many entries other property
> > has in another property, because device tree provides information about
> > sizes of all properties. So, in parsing code, you would be able to
> > simply get the size of "fsl,pwm-channels" property in bytes, divide
> > that by sizeof(u32) and get the numer of cells specified.
> 
> OK, I will revise it in v2.

As I noted below, it won't be needed anymore. I just commented on this as a 
side note.

> > > > > +- fsl,pwm-channels: the channels' order which is be used for pwm
> > > > > +in
> > > > > ftm0 +  module, and they must be one or some of 0 ~ 7, because
> > > > > the
> > > > > ftm0 only has +  8 channels can be used.
> > > > 
> > > > Could you explain meaning of this property more precisely? I'm
> > > > interested especially how is this related to the PWM IP block and
> > > > boards.
> > > 
> > > Yes.
> > > There are 8 channels most. While the pinctrls of 4th and 5th channels
> > > could be used by uart's Rx and Tx, then these 2 channels won't be
> > > used
> > > for pwm output, so there will be 6 channels available by the pwm.
> > > Thus, the pwm chip will register only 6 pwms(6 channels)
> > > most("fsl,pwm-channel-orders = {0 1 2 3 6 7}").And also the
> > > "fsl,pwm-channel-number" will be 6.
> > > 
> > > If hasn't any other problems, I will revise It in v2.
> > > And this will be renamed to "fsl,pwm-channel-orders", which can be
> > > more readable and understood.
> > 
> > As Sascha Hauer already suggested, you could get rid of both this and
> > "fsl,pwm-channel-number" properties and simply register all the
> > channels. This way you will have a deterministic 1:1 mapping of real
> > hardware channels to channels specified in device tree, which is
> > definitely the way to go.
> > 
> > Now as a safety measure, you could simply move the specification of
> > pinctrl states from SoC family or SoC level dtsi file to board level
> > dts, where only pinctrl states of channels used by a particular board
> > would be specified, so nothing could break operation of other devices
> > that share pin muxes with remaining channels.
> 
> Yes, I was also considering it, but not very be clear yet.
> Thanks very much for your and Sascha's help.
> I will try to implement it in v2.

OK, good.

Best regards,
Tomasz
