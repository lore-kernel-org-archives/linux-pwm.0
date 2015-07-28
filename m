From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH 2/2] DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation
Date: Wed, 29 Jul 2015 01:22:23 +0200
Message-ID: <CAGhQ9VwudkK=bo5Qk79O7fmdEEm1KEWxUhLO14ucCJ+FbhqQqw@mail.gmail.com>
References: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>
	<1437972345-16444-3-git-send-email-ariel@vanguardiasur.com.ar>
	<CAGhQ9Vyy+oUAWm0q2+NV0D9RVf5qyED8Tn54-cGzbDc-EZR4yw@mail.gmail.com>
	<CAAEAJfApE8=cAue-bc5xPD_XAtV8qzur12C4okF-uLJ-__reBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34461 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbG1XWZ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2015 19:22:25 -0400
Received: by lbbzr7 with SMTP id zr7so84762443lbb.1
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2015 16:22:23 -0700 (PDT)
In-Reply-To: <CAAEAJfApE8=cAue-bc5xPD_XAtV8qzur12C4okF-uLJ-__reBA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>, linux-pwm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thierry Reding <thierry.reding@gmail.com>

On 29 July 2015 at 00:45, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> On 28 July 2015 at 19:37, Joachim  Eastwood <manabian@gmail.com> wrote:
>> On 27 July 2015 at 06:45, Ariel D'Alessandro <ariel@vanguardiasur.com.ar> wrote:
>>> Add the devicetree binding document for NXP LPC18xx PWM/SCT.
>>>
>>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>>> ---
>>>  .../devicetree/bindings/pwm/lpc1850-pwm.txt          | 20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>>> new file mode 100644
>>> index 0000000..3055429
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>>> @@ -0,0 +1,20 @@
>>> +* NXP LPC18xx Pulse Width Modulator driver
>>> +
>>> +Required properties:
>>> +  - compatible: Should be "nxp,lpc1850-pwm"
>>> +  - reg: Should contain physical base address and length of pwm registers.
>>> +  - clocks: Must contain an entry for each entry in clock-names.
>>> +    See ../clock/clock-bindings.txt for details.
>>> +  - clock-names: Must include the following entries.
>>> +    - pwm: PWM operating clock.
>>> +  - #pwm-cells: Should be 3. See pwm.txt in this directory for the description
>>> +    of the cells format.
>>> +
>>> +Example:
>>> +  pwm: pwm@40000000 {
>>> +    compatible = "nxp,lpc1850-pwm";
>>
>> I would prefer "nxp,lpc1850-sct" for a couple of reasons. SCT is the
>> name of hardware block as described in the user manual and while PWM
>> is the most obvious usage for this block on Linux, the hardware is not
>> limited to just doing that. So as a bit of future proofing if someone
>> wants to use this block for more than PWM I would prefer SCT.
>>
>
> Shouldn't we use something like "nxp,lpc1850-sct-pwm"?
>
> Sounds like the word PWM should be in the compatible as it describes
> not only the device, but the device used in a certain way.
>
> Otherwise, how would we use "nxp,lpc1850-sct" to distinguish a PWM from
> e.g. a clocksource/clockevents (we can also use SCT for that)?

I not sure how to best handle dt bindings with such flexible hardware blocks.

But are you suggestion to have multiple drivers for the same hw block?
ie.: "nxp,lpc1850-sct-pwm" for PWM and for example
"nxp,lpc1850-sct-clocksource" for clocksource and then use/enable one
or the other.

So I am not sure how to best handle this, but I think we should at
least consider more than just PWM usage for this hw block. Note that
not against calling it "lpc1850-sct-pwm", I like that better than just
"lpc1850-pwm".


regards,
Joachim Eastwood
