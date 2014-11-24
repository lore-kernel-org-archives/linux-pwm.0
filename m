From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: RE: [PATCH RESEND v4 2/4] DT: pwm: Add binding document for IMG PWM
 DAC
Date: Mon, 24 Nov 2014 11:26:02 +0000
Message-ID: <27E62D98F903554192E3C13AFCC91C3C2F52EE98@hbmail01.hb.imgtec.org>
References: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
 <1416621212-11701-3-git-send-email-Naidu.Tellapati@gmail.com>,<20141124101449.GC25912@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:4746 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbaKXL0H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Nov 2014 06:26:07 -0500
In-Reply-To: <20141124101449.GC25912@ulmo.nvidia.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, "naidu.tellapati@gmail.com" <naidu.tellapati@gmail.com>
Cc: "abrestic@chromium.org" <abrestic@chromium.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, James Hartley <James.Hartley@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arul Ramasamy <Arul.Ramasamy@imgtec.com>, Sai Masarapu <Sai.Masarapu@imgtec.com>

Hi Thierry,

Many thanks for your review comments.

> On Sat, Nov 22, 2014 at 07:23:30AM +0530, naidu.tellapati@gmail.com wrote:
>> From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>>
>> Add binding document for IMG Pulse Width Modulator (PWM) DAC present on the
>> Pistachio SOC. The PWM DAC has four channels.
>>
>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>> Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>
>> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>> No changes from v3.
>> ---
>>  Documentation/devicetree/bindings/pwm/img-pwm.txt |   23 +++++++++++++++++++++
>>  1 files changed, 23 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/img-pwm.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/img-pwm.txt b/Documentation/devicetree/bindings/pwm/img-pwm.txt
>> new file mode 100644
>> index 0000000..d3828dd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/img-pwm.txt
>> @@ -0,0 +1,23 @@
>> +*Imagination Technologies PWM DAC driver
>> +
>> +Required properties:
>> +  - compatible: Should be "img,pistachio-pwm"
>> +  - reg: Should contain physical base address and length of pwm registers.
>> +  - clocks: Must contain an entry for each entry in clock-names.
>> +     See ../clock/clock-bindings.txt for details.
>> +  - clock-names: input clock names.
>> +     Required elements: "pwm" and "sys".

> I think it'd be useful to explain at least what the "sys" clock is.
> "pwm" I'd assume that it clocks the IP block, but what does "sys" do?

OK. Will add the description in the next patch set.

The sys clock enables access to Internal configuration registers of PWM block.


> Thierry

Regards,
Naidu.
