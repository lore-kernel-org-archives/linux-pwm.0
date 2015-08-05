From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: Re: [PATCH 2/2] DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation
Date: Wed, 05 Aug 2015 20:13:00 -0300
Message-ID: <55C2987C.2000109@vanguardiasur.com.ar>
References: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>	<1437972345-16444-3-git-send-email-ariel@vanguardiasur.com.ar>	<CAGhQ9Vyy+oUAWm0q2+NV0D9RVf5qyED8Tn54-cGzbDc-EZR4yw@mail.gmail.com>	<CAAEAJfApE8=cAue-bc5xPD_XAtV8qzur12C4okF-uLJ-__reBA@mail.gmail.com>	<CAGhQ9VwudkK=bo5Qk79O7fmdEEm1KEWxUhLO14ucCJ+FbhqQqw@mail.gmail.com>	<CAAEAJfA22JA0AWB1FCiDVYEy5BqasDror_Ejpd=b3s14BWpORw@mail.gmail.com>	<CAGhQ9VyCNrH_J6rP+L+6OkV-PCgemOzhznuFRg07YxPpLX_nig@mail.gmail.com> <CAAEAJfBjr2wxn-x1RiEj+ezoHA0aWNqCFfpYLM3RzhTrnHDyWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35383 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbbHEXNH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Aug 2015 19:13:07 -0400
Received: by qgj62 with SMTP id 62so16503287qgj.2
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2015 16:13:06 -0700 (PDT)
In-Reply-To: <CAAEAJfBjr2wxn-x1RiEj+ezoHA0aWNqCFfpYLM3RzhTrnHDyWw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Joachim Eastwood <manabian@gmail.com>
Cc: linux-pwm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thierry Reding <thierry.reding@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

Ezequiel, Joachim:

El 31/07/15 a las 15:09, Ezequiel Garcia escibi=C3=B3:
> Joachim,
>=20
> On 30 July 2015 at 20:30, Joachim  Eastwood <manabian@gmail.com> wrot=
e:
>> On 29 July 2015 at 15:47, Ezequiel Garcia <ezequiel@vanguardiasur.co=
m.ar> wrote:
>>> +devicetree guys
>>>
>>> On 28 July 2015 at 20:22, Joachim  Eastwood <manabian@gmail.com> wr=
ote:
>>>> On 29 July 2015 at 00:45, Ezequiel Garcia <ezequiel@vanguardiasur.=
com.ar> wrote:
>>>>> On 28 July 2015 at 19:37, Joachim  Eastwood <manabian@gmail.com> =
wrote:
>>>>>> On 27 July 2015 at 06:45, Ariel D'Alessandro <ariel@vanguardiasu=
r.com.ar> wrote:
>>>>>>> Add the devicetree binding document for NXP LPC18xx PWM/SCT.
>>>>>>>
>>>>>>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>>>>>>> ---
>>>>>>>  .../devicetree/bindings/pwm/lpc1850-pwm.txt          | 20 ++++=
++++++++++++++++
>>>>>>>  1 file changed, 20 insertions(+)
>>>>>>>  create mode 100644 Documentation/devicetree/bindings/pwm/lpc18=
50-pwm.txt
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/pwm/lpc1850-pwm.=
txt b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>>>>>>> new file mode 100644
>>>>>>> index 0000000..3055429
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>>>>>>> @@ -0,0 +1,20 @@
>>>>>>> +* NXP LPC18xx Pulse Width Modulator driver
>>>>>>> +
>>>>>>> +Required properties:
>>>>>>> +  - compatible: Should be "nxp,lpc1850-pwm"
>>>>>>> +  - reg: Should contain physical base address and length of pw=
m registers.
>>>>>>> +  - clocks: Must contain an entry for each entry in clock-name=
s.
>>>>>>> +    See ../clock/clock-bindings.txt for details.
>>>>>>> +  - clock-names: Must include the following entries.
>>>>>>> +    - pwm: PWM operating clock.
>>>>>>> +  - #pwm-cells: Should be 3. See pwm.txt in this directory for=
 the description
>>>>>>> +    of the cells format.
>>>>>>> +
>>>>>>> +Example:
>>>>>>> +  pwm: pwm@40000000 {
>>>>>>> +    compatible =3D "nxp,lpc1850-pwm";
>>>>>>
>>>>>> I would prefer "nxp,lpc1850-sct" for a couple of reasons. SCT is=
 the
>>>>>> name of hardware block as described in the user manual and while=
 PWM
>>>>>> is the most obvious usage for this block on Linux, the hardware =
is not
>>>>>> limited to just doing that. So as a bit of future proofing if so=
meone
>>>>>> wants to use this block for more than PWM I would prefer SCT.
>>>>>>
>>>>>
>>>>> Shouldn't we use something like "nxp,lpc1850-sct-pwm"?
>>>>>
>>>>> Sounds like the word PWM should be in the compatible as it descri=
bes
>>>>> not only the device, but the device used in a certain way.
>>>>>
>>>>> Otherwise, how would we use "nxp,lpc1850-sct" to distinguish a PW=
M from
>>>>> e.g. a clocksource/clockevents (we can also use SCT for that)?
>>>>
>>>> I not sure how to best handle dt bindings with such flexible hardw=
are blocks.
>>>>
>>>> But are you suggestion to have multiple drivers for the same hw bl=
ock?
>>>> ie.: "nxp,lpc1850-sct-pwm" for PWM and for example
>>>> "nxp,lpc1850-sct-clocksource" for clocksource and then use/enable =
one
>>>> or the other.
>>>>
>>>
>>> Yup, I'm suggesting just that. If the hardware is capable, I can't =
see
>>> why we can't have different drivers for it.
>>
>> Well, I think it would be nice if we could have one driver per hw
>> block. But then you need a way to select whether you want to use the
>> counter in the SCT block for PWM or, for example, clocksource. Sort =
of
>> mode selection I guess.
>>
>> But then again if someone has some very custom and application
>> specific usage for the SCT block that maybe better served by a
>> standalone driver anyway.
>>
>=20
> Technically speaking, I believe we can use "nxp,lpc1850-sct" to expos=
e
> both a PWM interface and a clocksource in a single driver. Not too
> clean, though.
>=20
> Alternatively, we should be able to have a multifunction device (MFD)=
 to mux
> the SCT resources to be consumed by different kind of drivers.
>=20
> Given there's no counter API to feed SCT, and given we use the other
> timer hw block to feed clocksource and clockevents for the LPC18/43xx=
,
> I think currently the simplest choice is to have "nxp,lpc1850-sct-pwm=
"
> describing this PWM SCT driver.
>=20
> If we later want to change completely the PWM SCT driver, we can do
> that without any bindings change.
>=20
>> So for now I am fine with "nxp,lpc1850-sct-pwm". I shouldn't be too
>> hard to change the bindings if we see other users of this block, I
>> believe.
>>
>=20
> Well, that would break DT backward compatibility, so it's not an idea=
l.
> Like I said, "nxp,lpc1850-sct-pwm" seems to be specific enough to
> describe this driver.
>=20
> I'd like to know what Thierry thinks here.
>=20

OK then. Until we have a better idea, I'll set the compatible string to
"nxp,lpc1850-sct-pwm".
