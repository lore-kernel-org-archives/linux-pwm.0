From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH 2/2] DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation
Date: Tue, 28 Jul 2015 19:45:22 -0300
Message-ID: <CAAEAJfApE8=cAue-bc5xPD_XAtV8qzur12C4okF-uLJ-__reBA@mail.gmail.com>
References: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>
	<1437972345-16444-3-git-send-email-ariel@vanguardiasur.com.ar>
	<CAGhQ9Vyy+oUAWm0q2+NV0D9RVf5qyED8Tn54-cGzbDc-EZR4yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37434 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbG1WpX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2015 18:45:23 -0400
Received: by wibud3 with SMTP id ud3so2334946wib.0
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2015 15:45:22 -0700 (PDT)
In-Reply-To: <CAGhQ9Vyy+oUAWm0q2+NV0D9RVf5qyED8Tn54-cGzbDc-EZR4yw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>, linux-pwm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thierry Reding <thierry.reding@gmail.com>

On 28 July 2015 at 19:37, Joachim  Eastwood <manabian@gmail.com> wrote:
> On 27 July 2015 at 06:45, Ariel D'Alessandro <ariel@vanguardiasur.com=
=2Ear> wrote:
>> Add the devicetree binding document for NXP LPC18xx PWM/SCT.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>> ---
>>  .../devicetree/bindings/pwm/lpc1850-pwm.txt          | 20 +++++++++=
+++++++++++
>>  1 file changed, 20 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-pw=
m.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt b=
/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>> new file mode 100644
>> index 0000000..3055429
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>> @@ -0,0 +1,20 @@
>> +* NXP LPC18xx Pulse Width Modulator driver
>> +
>> +Required properties:
>> +  - compatible: Should be "nxp,lpc1850-pwm"
>> +  - reg: Should contain physical base address and length of pwm reg=
isters.
>> +  - clocks: Must contain an entry for each entry in clock-names.
>> +    See ../clock/clock-bindings.txt for details.
>> +  - clock-names: Must include the following entries.
>> +    - pwm: PWM operating clock.
>> +  - #pwm-cells: Should be 3. See pwm.txt in this directory for the =
description
>> +    of the cells format.
>> +
>> +Example:
>> +  pwm: pwm@40000000 {
>> +    compatible =3D "nxp,lpc1850-pwm";
>
> I would prefer "nxp,lpc1850-sct" for a couple of reasons. SCT is the
> name of hardware block as described in the user manual and while PWM
> is the most obvious usage for this block on Linux, the hardware is no=
t
> limited to just doing that. So as a bit of future proofing if someone
> wants to use this block for more than PWM I would prefer SCT.
>

Shouldn't we use something like "nxp,lpc1850-sct-pwm"?

Sounds like the word PWM should be in the compatible as it describes
not only the
device, but the device used in a certain way.

Otherwise, how would we use "nxp,lpc1850-sct" to distinguish a PWM from
e.g. a clocksource/clockevents (we can also use SCT for that)?

--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
