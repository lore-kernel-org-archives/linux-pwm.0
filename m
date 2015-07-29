From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: Re: [PATCH 2/2] DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation
Date: Wed, 29 Jul 2015 10:19:55 -0300
Message-ID: <55B8D2FB.8080305@vanguardiasur.com.ar>
References: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>	<1437972345-16444-3-git-send-email-ariel@vanguardiasur.com.ar> <CAGhQ9Vyy+oUAWm0q2+NV0D9RVf5qyED8Tn54-cGzbDc-EZR4yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34533 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbbG2NUA (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Jul 2015 09:20:00 -0400
Received: by qgeu79 with SMTP id u79so3982316qge.1
        for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2015 06:19:59 -0700 (PDT)
In-Reply-To: <CAGhQ9Vyy+oUAWm0q2+NV0D9RVf5qyED8Tn54-cGzbDc-EZR4yw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: linux-pwm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Thierry Reding <thierry.reding@gmail.com>

Joachim,

El 28/07/15 a las 19:37, Joachim Eastwood escibi=C3=B3:
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
[...]
>> +    reg =3D <0x40000000 0x580>;
>=20
> Please map the entire memory block as noted in the user manual, ie. 0=
x1000.

OK, I'll change that in v2.

>=20
>=20
> regards,
> Joachim Eastwood
>=20
