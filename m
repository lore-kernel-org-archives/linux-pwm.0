Return-Path: <B47053@freescale.com>
From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCH 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM
Date: Thu, 22 Aug 2013 02:55:42 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827D2244@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-5-git-send-email-Li.Xiubo@freescale.com>
 <1473340.OXSHEp7d4P@flatron>
In-Reply-To: <1473340.OXSHEp7d4P@flatron>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Guo Shawn-R65073 <r65073@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>

Hi Tomasz,

Thanks for your comments.


> > +- #pwm-cells: Should be 3. Number of cells being used to specify PWM
> > property.
> > +  First cell specifies the per-chip channel index of the PWM
> > to use, the
> > +  second cell is the period in nanoseconds and bit 0 in
> > the third cell is
> > +  used to encode the polarity of PWM output. Set bit
> > 0 of the third in PWM
> > +  specifier to 1 for inverse polarity & set to 0
> > for normal polarity.
>=20
> If the meaning of flags cell is the same as in generic, default PWM
> specifier format, then it should be noted here and generic PWM binding
> documentation mentioned.
>=20

OK, How about the following ?
- #pwm-cells: Should be 3. See pwm.txt in this directory for a
  description of the cells format.

I will replace it in v2.


> > +- fsl,pwm-clk-ps: the ftm0 pwm clock's prescaler,
> > divide-by 2^n(n =3D 0 ~ 7).
>=20
> Is it a hardware-specific property?

Yes, I will revise it in v2.=20

>=20
> > +- fsl,pwm-cpwm: Center-Aligned PWM (CPWM)
> > mode.
>=20
> Could you explain meaning of this property?
>=20

Well, this feature will be removed from the pwm core in v2.


> > +- fsl,pwm-number: the number of PWM devices, and is must equal to the
> > number +  of "fsl,pwm-channels".
>=20
> This is redundant, because you can simply count how many entries have
> been specified in fsl,pwm-channels.
>

Yes, I will revise it in v2.
And this would be renamed to " fsl,pwm-channel-number", which can be more
Readable and understood.

=20
> > +- fsl,pwm-channels: the channels' order which is be used for pwm in
> > ftm0 +  module, and they must be one or some of 0 ~ 7, because the
> > ftm0 only has +  8 channels can be used.
>=20
> Could you explain meaning of this property more precisely? I'm interested
> especially how is this related to the PWM IP block and boards.
>=20

Yes.
There are 8 channels most. While the pinctrls of 4th and 5th channels could=
 be
used by uart's Rx and Tx, then these 2 channels won't be used for pwm outpu=
t,
so there will be 6 channels available by the pwm.
Thus, the pwm chip will register only 6 pwms(6 channels) most("fsl,pwm-chan=
nel-orders
=3D {0 1 2 3 6 7}").And also the "fsl,pwm-channel-number" will be 6.

If hasn't any other problems, I will revise It in v2.
And this will be renamed to "fsl,pwm-channel-orders", which can be more rea=
dable
and understood.

> > +- for very channel, the revlatived the pinctrl should be at least two
>                            ^ typo?
>=20
> > state +  {"enN", "dsN"}, which "en" means "enable", "ds" means
> > "disable" and "N" +  means the order of the channel.
>=20
> I'd suggest a more readable naming convention, for example chN-active and
> chN-idle. These words seem to be more common across existing bindings.
>=20

That's a good idea, I will think it over and revise it in v2.


Thanks very much.
--
Best Regards,
Xiubo
