Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35A42980B
	for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557457; cv=none; b=YK4aVuSVAyPXYiiOzCBJTOzZslCJCIvAkDgXsC/CDkyalNj7keQknprHviWYw5p5fZKNBDNlQ0a2Gj3F76A8KKknavFTOswV4TbzNAraD0fAPLOEVYjxeHRdWbRCLVusIkL7PbvNtoQ8yFM07/7Cq+oiI7SXfQt1+IQQKZ89SNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557457; c=relaxed/simple;
	bh=CP+gtt+HOG+Rgpr0fnB+mb+3WTuTlJC8GQyWgEkqERk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ituhZIdt3Z3H1anDSZ6Ex8d3o1UHBRwZkq+7k9di2hxBOS/MbqRPBYOGFFwD0De0Sm8DKOGvzUbjnIcZ5KL3kt5WvCrK1CLOpH7VxSQKH3FPrBaIMwHWf7AQkcpbQtH4GmX3sUs5S832djV08Ac7+DcmvJSA1VejghHptqAn+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXuQBj0W; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXuQBj0W"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc97653887so111453045ad.1
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2026 07:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784557454; x=1785162254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EpL1CNsT3je57Fwq8JftS8mNRsIjVSAHBGRcgmodJUA=;
        b=aXuQBj0Wf5nTl3ShwIgd0/L57ZVwHAPf96vKtV1fUoceeXuj1h+D+t8/DwIxvAenm0
         mvP/MS67e83MjocP59GHLgLyVtJHvc4urdn83q6wbaCj0M2O6TwX0nG7pAJ//3Gy9YXq
         IyPDP2VMy+8yBcMh4apcg1+OjAbYU2FxnFs7ZupMnLV0UPyQ28JVLkVB1nS6BUnfEONe
         VtQL6d1ccCwl567xFgzJPeqXby1dF5AXTbBMyOdLTKFByjfarK5gP0Hxy5chWMf926Gu
         lVIO7XvEBHGeHMkm3j31fT7iy1VvGsV5sQCWrofZheZdYScfHONZXRSFfEsXhFufNIcg
         ABKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784557454; x=1785162254;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EpL1CNsT3je57Fwq8JftS8mNRsIjVSAHBGRcgmodJUA=;
        b=lXIdGDCkHULdbKI4wLu2upDhmHOk3A5ZaDKyWFhsF8EaHt5NHY0yxB5+oGCq2GHvRt
         Yz7rgqPyBiumc7q6tkmum8qv37EttUk+K9CeTkWE+GyG/Plg7UyP3600a9EUIrUdzlAp
         4TJtSSp7i2u/vlL5c4nL47Z1IlVkcnXVLf0QW/y6OAKzhzdaqAqeFFxKcuT8diEsHadZ
         RoVUy69ra3kDe10bGOD1bppwJ05pT1dKZZSlcM1GqOCvum1oU02vQ/TPgocSq1CzylkY
         xtrDPV5S0JwwJ7zixZhVklcRdzvebKJy1FN1N7R+GaDh0PIe74rtCpYpX7iPgyqu8ZPZ
         CVEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYxQB4XqPpeHnXBs3mr4Lp5cq6ZhfPiXhaQqqOaZAe3bgX346k61toQLtF2MB2nPyK+GA+zWhuTy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWpdg9rsfutvW3j7y8VwEjDkfMjA901h8umdOccqkf0SdsmJ4
	4/HpHunAMWFIVHVDBhGZvlm9neWyW9KlTvZeSZv2cyu7ITOvYJy7lI4W
X-Gm-Gg: AfdE7cnZ6GaGT4BEtMNwcQ2SBbajcIt0PGdOL6zMK+Y2MFA4nFl2ORXDDOwY/bjv4XO
	0aR+QR+YciJJVKOSFPmdJD1E5J7y+uuUQRq4F5i4eqeau20A5eOveQal1vc/hiUkebCcYaHPeMa
	FiMtKFBscJ3yyiaejgcGx/BdkLfF3ebWle3+w265T6T01mmVY6q4V+S28md8E2dVSA1hEgX8vK9
	iacgtJt9f11hYjhe11gSXtS/oZYeqQxO1GrDeBJynhxLz00PNVAVQ8MnhRiU5l0XZ+UYw1NjxK5
	f+phL6+/whUafShUlIQAzaPh9Z+nzr+3MFmDLuOs8f30ypkuqQwOUv11MFLzQXsyH4hWHLSKem3
	OKaiq+g5k87wfPbhXFogw+X1tHn+re9OoDBTJN1g3l1c/9AsIapURpeLOD9o4kbBQrbAn2qPd4y
	X9ziTUfnqwZvMpRva4u2EthW0zPiLNgTEmOAuBtUt/iPYOcsan0Es=
X-Received: by 2002:a05:6a21:d8c:b0:3c3:91f5:82cf with SMTP id adf61e73a8af0-3c3ad94bb70mr15785688637.46.1784557453546;
        Mon, 20 Jul 2026 07:24:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdcaefsm36660793eec.10.2026.07.20.07.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 07:24:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a8fba49c-bb72-4b3b-b598-4972304e0b4c@roeck-us.net>
Date: Mon, 20 Jul 2026 07:24:11 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: hwmon: add binding for adi,adt7470
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Darrick J. Wong" <djwong@us.ibm.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
 <20260717-adt7470_thermalzone-v2-1-a55147958fad@gmail.com>
 <20260720-placid-fanatic-shrimp-d2bcd2@quoll>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260720-placid-fanatic-shrimp-d2bcd2@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/19/26 23:47, Krzysztof Kozlowski wrote:
> On Fri, Jul 17, 2026 at 05:59:14PM -0300, Luiz Angelo Daros de Luca wrote:
>> The Analog Devices ADT7470 is a temperature monitor and PWM fan
>> controller. It supports up to 10 external temperature sensors and
>> up to 4 PWM fan outputs.
> 
> A nit, subject: drop second/last, redundant "binding for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
> 
>>
>> Add the YAML device tree binding documentation for it. This includes
> 
> s/YAML//
> There is no YAML in Devicetree.
> 
>> support for the thermal framework by defining the "#thermal-sensor-cells"
>> property, and support for the PWM subsystem by defining the "#pwm-cells"
>> property.
>>
>> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
>> ---
>>   .../devicetree/bindings/hwmon/adi,adt7470.yaml     | 62 ++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
>> new file mode 100644
>> index 000000000000..14bb6359c91f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
>> @@ -0,0 +1,62 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/adi,adt7470.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Analog Devices ADT7470 hwmon sensor
>> +
>> +maintainers:
>> +  - Luiz Angelo Daros de Luca <luizluca@gmail.com>
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +  The ADT7470 is a temperature monitor and multiple PWM outputs.
>> +  It supports monitoring up to 10 external temperature sensors and controlling
>> +  up to four fans.
> 
> "controling fans" is confusing and suggests this is a fan controller, so
> you would need to reference proper schema for that. It is just PWM
> output, no? PWM output could also go to LEDs or motors (well, fan is a
> motor).
> 
 From the datasheet: "The ADT74701 controller is a multichannel
temperature sensor and PWM fan controller and fan speed monitor".

It is a fan controller which happens to use pwm signals to control
fan speeds. It is not a PWM controller, and its pwm outputs are not
intended to be used for anything but controlling fan speeds.

Technically it is _possible_ to use the pwm outputs to control
something else. But that does not mean that chip is a pwm controller.
It is still a fan controller. I don't mind modeling outputs as
non-fan-control pwm channels if that is what they are used for,
but that must be clearly distinguished in both the driver code
and the bindings.

Guenter

