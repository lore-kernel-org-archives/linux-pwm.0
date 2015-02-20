From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: add errata handling for sama5d4
Date: Fri, 20 Feb 2015 17:26:34 +0100
Message-ID: <54E7603A.5010309@atmel.com>
References: <1424447898-2791-1-git-send-email-nicolas.ferre@atmel.com> <20150220170613.424edbb5@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:50651 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019AbbBTQ0i (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Feb 2015 11:26:38 -0500
In-Reply-To: <20150220170613.424edbb5@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, thierry.reding@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Le 20/02/2015 17:06, Boris Brezillon a =E9crit :
> Hi Nicolas,
>=20
> On Fri, 20 Feb 2015 16:58:18 +0100
> Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>=20
>> sama5d4 SoC also has an errata on the HLCDC PWM. It is the same as t=
he sama5d3
>> that is forbidding the use of div1 prescaler.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>=20
> The "atmel,sama5d4-hlcdc" compatible string is not yet documented in
> the atmel-hlcdc MFD driver binding, but this shouldn't hurt, so

Yes, I'll document it when I'm submitting your patches that add the
compatibility strings to the drivers/mfd/atmel-hlcdc.c. (with
atmel,at91sam9x5-hlcdc as well).

> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Thanks, bye.

>> ---
>>  drivers/pwm/pwm-atmel-hlcdc.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-h=
lcdc.c
>> index 522f7075bb1a..fa5feaba25a5 100644
>> --- a/drivers/pwm/pwm-atmel-hlcdc.c
>> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
>> @@ -225,6 +225,10 @@ static const struct of_device_id atmel_hlcdc_dt=
_ids[] =3D {
>>  		.compatible =3D "atmel,sama5d3-hlcdc",
>>  		.data =3D &atmel_hlcdc_pwm_sama5d3_errata,
>>  	},
>> +	{
>> +		.compatible =3D "atmel,sama5d4-hlcdc",
>> +		.data =3D &atmel_hlcdc_pwm_sama5d3_errata,
>> +	},
>>  	{ /* sentinel */ },
>>  };
>> =20
>=20
>=20
>=20


--=20
Nicolas Ferre
