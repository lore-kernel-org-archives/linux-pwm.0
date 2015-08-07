From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH 2/2] DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation
Date: Fri, 7 Aug 2015 17:44:01 +0200
Message-ID: <CAGhQ9VyGYro=PZgj7cu+vP3QCZapL8cxYX-Zxp4+ZS9AtxznFw@mail.gmail.com>
References: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>
	<1437972345-16444-3-git-send-email-ariel@vanguardiasur.com.ar>
	<CAGhQ9Vyy+oUAWm0q2+NV0D9RVf5qyED8Tn54-cGzbDc-EZR4yw@mail.gmail.com>
	<CAAEAJfApE8=cAue-bc5xPD_XAtV8qzur12C4okF-uLJ-__reBA@mail.gmail.com>
	<CAGhQ9VwudkK=bo5Qk79O7fmdEEm1KEWxUhLO14ucCJ+FbhqQqw@mail.gmail.com>
	<CAAEAJfA22JA0AWB1FCiDVYEy5BqasDror_Ejpd=b3s14BWpORw@mail.gmail.com>
	<CAGhQ9VyCNrH_J6rP+L+6OkV-PCgemOzhznuFRg07YxPpLX_nig@mail.gmail.com>
	<CAAEAJfBjr2wxn-x1RiEj+ezoHA0aWNqCFfpYLM3RzhTrnHDyWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:33412 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113AbbHGPoE (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Aug 2015 11:44:04 -0400
In-Reply-To: <CAAEAJfBjr2wxn-x1RiEj+ezoHA0aWNqCFfpYLM3RzhTrnHDyWw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>, linux-pwm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thierry Reding <thierry.reding@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On 31 July 2015 at 20:09, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> Joachim,
>
> On 30 July 2015 at 20:30, Joachim  Eastwood <manabian@gmail.com> wrote:
>> On 29 July 2015 at 15:47, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
>>> +devicetree guys
>>>
>>> On 28 July 2015 at 20:22, Joachim  Eastwood <manabian@gmail.com> wrote:
>>>> On 29 July 2015 at 00:45, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
>>>>> On 28 July 2015 at 19:37, Joachim  Eastwood <manabian@gmail.com> wrote:
>>>>>> On 27 July 2015 at 06:45, Ariel D'Alessandro <ariel@vanguardiasur.com.ar> wrote:
>>>>>>> Add the devicetree binding document for NXP LPC18xx PWM/SCT.
>>>>>>>
>>>>>>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>>>>>>> ---
>>>>>>>  .../devicetree/bindings/pwm/lpc1850-pwm.txt          | 20 ++++++++++++++++++++
>>>>>>>  1 file changed, 20 insertions(+)
>>>>>>>  create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>>>>>>> new file mode 100644
>>>>>>> index 0000000..3055429
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>>>>>>> @@ -0,0 +1,20 @@
>>>>>>> +* NXP LPC18xx Pulse Width Modulator driver
>>>>>>> +
>>>>>>> +Required properties:
>>>>>>> +  - compatible: Should be "nxp,lpc1850-pwm"
>>>>>>> +  - reg: Should contain physical base address and length of pwm registers.
>>>>>>> +  - clocks: Must contain an entry for each entry in clock-names.
>>>>>>> +    See ../clock/clock-bindings.txt for details.
>>>>>>> +  - clock-names: Must include the following entries.
>>>>>>> +    - pwm: PWM operating clock.
>>>>>>> +  - #pwm-cells: Should be 3. See pwm.txt in this directory for the description
>>>>>>> +    of the cells format.
>>>>>>> +
>>>>>>> +Example:
>>>>>>> +  pwm: pwm@40000000 {
>>>>>>> +    compatible = "nxp,lpc1850-pwm";
>>>>>>
>>>>>> I would prefer "nxp,lpc1850-sct" for a couple of reasons. SCT is the
>>>>>> name of hardware block as described in the user manual and while PWM
>>>>>> is the most obvious usage for this block on Linux, the hardware is not
>>>>>> limited to just doing that. So as a bit of future proofing if someone
>>>>>> wants to use this block for more than PWM I would prefer SCT.
>>>>>>
>>>>>
>>>>> Shouldn't we use something like "nxp,lpc1850-sct-pwm"?
>>>>>
>>>>> Sounds like the word PWM should be in the compatible as it describes
>>>>> not only the device, but the device used in a certain way.
>>>>>
>>>>> Otherwise, how would we use "nxp,lpc1850-sct" to distinguish a PWM from
>>>>> e.g. a clocksource/clockevents (we can also use SCT for that)?
>>>>
>>>> I not sure how to best handle dt bindings with such flexible hardware blocks.
>>>>
>>>> But are you suggestion to have multiple drivers for the same hw block?
>>>> ie.: "nxp,lpc1850-sct-pwm" for PWM and for example
>>>> "nxp,lpc1850-sct-clocksource" for clocksource and then use/enable one
>>>> or the other.
>>>>
>>>
>>> Yup, I'm suggesting just that. If the hardware is capable, I can't see
>>> why we can't have different drivers for it.
>>
>> Well, I think it would be nice if we could have one driver per hw
>> block. But then you need a way to select whether you want to use the
>> counter in the SCT block for PWM or, for example, clocksource. Sort of
>> mode selection I guess.
>>
>> But then again if someone has some very custom and application
>> specific usage for the SCT block that maybe better served by a
>> standalone driver anyway.
>>
>
> Technically speaking, I believe we can use "nxp,lpc1850-sct" to expose
> both a PWM interface and a clocksource in a single driver. Not too
> clean, though.

Well, I don't think that is unclean way of doing it. But it's up to
the different subsystem maintainers if they want users outside their
normal directory as we would, for example, end of with a clocksource
under the pwm dir.

> Alternatively, we should be able to have a multifunction device (MFD) to mux
> the SCT resources to be consumed by different kind of drivers.

That is an other way of doing it.

But you would still need to a way to chose between either PWM or
clocksource since the SCT has a limited number of counters. (SCT can
be configured to have either two 16-bit timers or one 32-bit)

> Given there's no counter API to feed SCT, and given we use the other
> timer hw block to feed clocksource and clockevents for the LPC18/43xx,
> I think currently the simplest choice is to have "nxp,lpc1850-sct-pwm"
> describing this PWM SCT driver.
>
> If we later want to change completely the PWM SCT driver, we can do
> that without any bindings change.

Agreed. Let's keep it simple now and deal with it again if another
user for the SCT block turns up.


regards,
Joachim Eastwood
