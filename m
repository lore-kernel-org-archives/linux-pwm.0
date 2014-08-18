From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv3 3/3] pwm: documentation: Add 'big-endian' property for
 FTM PWM.
Date: Mon, 18 Aug 2014 12:11:44 +0000
Message-ID: <63b1d7b52fda42e0b9bf09dac3f918aa@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1408332755-35102-1-git-send-email-Li.Xiubo@freescale.com>
 <1408332755-35102-4-git-send-email-Li.Xiubo@freescale.com>,<20140818095939.GE14559@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from [207.46.163.237] ([207.46.163.237]:26147 "EHLO
	na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750834AbaHRMNq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Aug 2014 08:13:46 -0400
In-Reply-To: <20140818095939.GE14559@leverpostej>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

[...]
>>  Freescale FlexTimer Module (FTM) PWM controller
>>
>> +For the same FTM PWM device, which on different SoCs will in
>> +differrent endian mode, using the same linux device driver need
>> +one boolean properties to distingush this.
>
> There is absolutely no need to mention Linux if this is truly a HW
> property.

Okay.

[...]
>> +
>> +For now the FTM PWM is only applied to the ARM SoCs which are all
>> +in LE mode.
>> +
>> +So the DT binding for FTM PWM device endian:
>> +SoC     |  FTM-PWM | 'big-endian' property is needed?
>> +--------|----------|---------------------------------
>> +Vybird  |    LE    |     No
>> +LS1     |    BE    |     Yes
>> +LS2     |    LE    |     No
>> +
>> +Please see "Documentation/devicetree/bindings/regmap/regmap.txt" for more
>> +detail about the endianness.
>
> Surely all we need is:
>
> The FTM PWM device can be integrated as little-endian or big-endian.
> This endianness differs per SoC:
>
> SoC     | FTM-PWM endianness
> --------+-------------------
> Vybrid  | LE
> LS1     | BE
> LS2     | LE

I'll follow your advice.

[...]
>> +- big-endian: One boolean property, for all the device registers, the BE mode
>> +  will be in use if it's present, or the LE mode will be in use.
>
>- big-endian: Boolean property, required if all the FTM_PWM registers
>  are big-endian rather than little-endian.
>

See the next version.

Thanks very much for you comment and advice.

BRs
XIubo



> Cheers,
> Mark.
