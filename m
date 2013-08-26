Return-Path: <B47053@freescale.com>
From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCH 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM
Date: Mon, 26 Aug 2013 05:35:53 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827E11AC@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
 <1377054462-6283-5-git-send-email-Li.Xiubo@freescale.com>
 <1473340.OXSHEp7d4P@flatron>
 <1DD289F6464F0949A2FCA5AA6DC23F827D2244@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130822062610.GR31036@pengutronix.de> <20130823073612.GB3535@ulmo>
 <5217B807.7020800@wwwdotorg.org>
In-Reply-To: <5217B807.7020800@wwwdotorg.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Guo Shawn-R65073 <r65073@freescale.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>

Hi Stephen,


> Subject: Re: [PATCH 4/4] Documentation: Add device tree bindings for
> Freescale FTM PWM
>=20
> On 08/23/2013 01:36 AM, Thierry Reding wrote:
> > On Thu, Aug 22, 2013 at 08:26:10AM +0200, Sascha Hauer wrote:
> >> On Thu, Aug 22, 2013 at 02:55:42AM +0000, Xiubo Li-B47053 wrote:
> >>> Hi Tomasz,
> >>>
> >>> Thanks for your comments.
> >>>
> >>>
> >>>> Could you explain meaning of this property more precisely?
> >>>> I'm interested especially how is this related to the PWM IP block
> >>>> and boards.
> >>>>
> >>>
> >>> Yes. There are 8 channels most. While the pinctrls of 4th and 5th
> >>> channels could be used by uart's Rx and Tx, then these 2 channels
> >>> won't be used for pwm output, so there will be 6 channels available
> >>> by the pwm. Thus, the pwm chip will register only 6 pwms(6 channels)
> >>> most("fsl,pwm-channel-orders =3D {0 1 2 3
> >>> 6 7}").And also the "fsl,pwm-channel-number" will be 6.
> >>
> >> If the chip has eight PWMs I would register all of them. If some of
> >> them are not routed out by the pinmux then just nothing happens if
> >> you use them. In a sane devicetree they won't be referenced anyway
> >> when they are not routed out of the SoC.
> >
> > In that case, shouldn't this be hooked up to the pinctrl subsystem as
> > well? As I understand the above, the logical thing would be for each
> > PWM channel's .request() operation to configure the pinmuxing
> > appropriately. And if it can't be configured as necessary then
> > .request() should return an error (or propagate the error from the
> > pinctrl subsystem).
>=20
> I think the pin-muxing should be static, i.e. set up when the PWM device
> as a whole probe()s, rather than being twiddled at request/free time.
> Certainly the pinmux support in the device core is now set up to acquire
> the default state right before probe(). I don't see a need to do anything
> custom here.

As we have tolk about this before in [PATCH 1/4]:
"
> > Why do you need to manipulate the pinctrl to en/disable a channel?
> >
>=20
> This is because in Vybrid VF610 TOWER board, there are 4 leds, and each
> led's one point(diode's positive pole) is connected to 3.3V, and the
> other point is connected to pwm's one channel. When the 4 pinctrls are
> configured as enable at the same time, the 4 pinctrls is low valtage, and
> the 4 leds will be lighted up as default, then when you enable/disable
> one led will effects others.
>=20
> These pinctrls are belong to pwm, and I don't think led or other customer
> could control them directly.
> So, here I authorize the 4 pinctrls to each channel controls.
>
"
For the reason above, I have to control the pinctrls separately.

If all the pinctrls set as default state, the 8 pinctrls must be controlled=
 together.
And the 4 leds will all be lighted up as default and will influence each ot=
her.

Thanks very much.

--
Best Regards.
Xiubo
