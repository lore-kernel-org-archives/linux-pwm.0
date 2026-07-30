Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D758373BEC
	for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425940; cv=none; b=pt/pNDGulRq40lt8ZhE4QLI0R0In38dRy5CzYG5m5++3e/W5RkXhGt4eu3pwVIGh11l+3uVYSNIMdd0ZuKCBn5rBXrVbrIw9hndb1YooeUUtKWyV5cANCGp4T2MnN2ihBXUPANBJlWVvb99AF3VE9hR8mnsHGMqZXwynRlNhJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425940; c=relaxed/simple;
	bh=qQ7RtlTQHMHHpvj83e3+ghCiBppCt64olewSD63Aaq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sx0k4amswxWrC70VQdxsIqFRdI90ux7HxgoZWt6zJtc/lk5NCDn2OsDsivKGUT7OusdOBYPLY5VtEPUrB4/q7c2nFtv/rYbPc3twq/pPOVXdiy5DOEqZoEaAgE/z9IHKKX78s2O6svwY0i4fG5Lj4ct58UyTBkOYQLb95qKKm24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afJ73mqq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afJ73mqq"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf41bab353so38865125ad.0
        for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785425938; x=1786030738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=le2uxJXCjEqMP45D/ueXFV/jxmIOCD7UYIlA5TE2iaQ=;
        b=afJ73mqqsrwan9DNuEDN4gqm0bcM8K1fvdiLp8fu2VPPgC1/i8zEt8hq3P9fYxMFl+
         lWgZAk8yDYu1G0G5H4mFZNnRXnLpe+rgLXXfP7QOmdS8nnsZWUsCeWxUTJFzS+FAQTGS
         Iehs/oPUJTiERKoAj0Kwz5/0aPmHi7wpzzSWfDYSh0Z5Og9loAlnto0JJrFzeA4BxB/T
         PLcXJtTrFYAJj0PvVL6hNbEo1CHbFtD7vXZuVM4my4nLq1luyhZLsRBZ1GKD5A6JFIDW
         uZkXhiCX10xGZEIE1jbhE8OjzfXMY61K+unP6ZfsjjRkjFMbOOLH7DGHjfu9yeqbtBPy
         nTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785425938; x=1786030738;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=le2uxJXCjEqMP45D/ueXFV/jxmIOCD7UYIlA5TE2iaQ=;
        b=r4QAThn/YDWzi5qHqlPsKi0bzOrp+wtdYidt4FN7F0JzA6YROHqRSEd42DHxTp7QHQ
         Np2u91UQQZIvQC3GupVQ5QLRwabJmKeOBa4CAHc4xkZ1kAjVxa6fF4AECEjQdq5irDQt
         pn8/Q9B53bElurkz9ozw21m/lw5qP/LEvJCcQP0kfMIa6tjW4LWVrII9RMOupsmzo04O
         6GRMaTzF4uET3Xyhpv2yNMxtqp6zQHnitw6A/TcCpzlCjjzptaw2scvPZmVXCVp2S3KR
         M/FEDiRqVeRxKpW/CBRZj5ee6PXKHbmK1nCJAfZefMFzAEkaS7W2czHfK3oWOsH6BE4d
         FO7w==
X-Forwarded-Encrypted: i=1; AHgh+Ro6B/gBElnyoy9bLALcTbjLEH4w/qqpy3TVdeJ0DyhY86pMBN4nOeX2D3acAYcMRyO8mV0EvKJi108=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/nKXw23UuoA2nEtHyV7I76k1vdz0bTTHEHKI71mCgEpj7i740
	day1Wu+/9mQmfQ+GUJMxNNsGYfElYAjla/pmhwodKBlpSY5rggtntcRi
X-Gm-Gg: AR+sD12+AkLyEzbWF/ZLc4Ru3NW3zebnNjq0dF+4gTSdLAulKivMJrbcU7CrLiM3ecj
	dOHwgzRUZadG39OM+FRf3TeW/u+i9ps9Q698x8OlB6X3Ocr+AZt1PIZ4jMADV8/u2JbR9uITWPm
	UTaeZTndwHyMF8ezuO4k9fmYBszAAq1IKT/Sa0IYpONrkQ7jffEgllhPHRvMb+FxADcqerLHmKU
	EP09bCexqa9HlryQrUN9lmKDyd/PD159lVy/dThdboCLHlEww7v/DZL2UBNu9Z8puYdeVAx42Sy
	5zxGmDBqFXEdUtKvQhdjoyCKK8AAgFlQOWJTS1lOSDqTOUSpUbDO5viDg2mPT5ieLrHlf7eNO9x
	M5xgwxVGV3AwI7Uz/X8fe9kyK2+HlXvsKn2cP1aWemXY5xtQbU50w3TUYGrewM1fYp6fBQ3MRIJ
	2uqnQVibt0RTfdM8mma4B4MwBbgwQ4SouxDOhz1EsP0eDhXBd4YTaRlNTxWvcbtlsKLYEBNJJIq
	Deb1QmIQ4d9aK1yPa/CmhPQndDVx96wbkMznw==
X-Received: by 2002:a17:902:d2d2:b0:2c9:e69f:edce with SMTP id d9443c01a7336-2d035d3be92mr34300745ad.44.1785425937429;
        Thu, 30 Jul 2026 08:38:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bf4747sm28410415ad.56.2026.07.30.08.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 08:38:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <05b7f116-25a9-49b3-a31c-15eb4e6ec838@roeck-us.net>
Date: Thu, 30 Jul 2026 08:38:55 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [hwmon-next PATCH v3 1/4] dt-bindings: hwmon: adi,adt7470
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
References: <20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com>
 <20260728-adt7470_thermalzone-v3-1-d4586478cdba@gmail.com>
 <20260728-meteoric-quixotic-sunfish-0de2cb@quoll>
 <CAJq09z5CQgzzFahoiteh9ykjdbsYpP=QZ2AugzY4tQ79RpA-cg@mail.gmail.com>
 <6cc03c4c-2d88-46f2-aee4-adb769d10cbd@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <6cc03c4c-2d88-46f2-aee4-adb769d10cbd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 23:17, Krzysztof Kozlowski wrote:
> On 29/07/2026 06:45, Luiz Angelo Daros de Luca wrote:
>> Hi Krzysztof,
>>
>> Thanks for the review.
>>
>>> On Tue, Jul 28, 2026 at 12:07:09AM -0300, Luiz Angelo Daros de Luca wrote:
>>>> The Analog Devices ADT7470 is a multichannel temperature sensor and
>>>> PWM fan controller. It supports monitoring up to 10 external
>>>> temperature sensors and controlling up to 4 fans.
>>>>
>>>> Add the device tree binding documentation for it. This includes
>>>> support for the thermal framework by defining the "#thermal-sensor-cells"
>>>> property, and models the fan control lines as PWM channels by
>>>> defining the "#pwm-cells" property.
>>>>
>>>> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
>>>> ---
>>>>   .../devicetree/bindings/hwmon/adi,adt7470.yaml     | 55 ++++++++++++++++++++++
>>>>   1 file changed, 55 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
>>>> new file mode 100644
>>>> index 000000000000..bb2375a4a490
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
>>>> @@ -0,0 +1,55 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/hwmon/adi,adt7470.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Analog Devices ADT7470 hwmon sensor
>>>> +
>>>> +maintainers:
>>>> +  - Luiz Angelo Daros de Luca <luizluca@gmail.com>
>>>> +
>>>> +description:
>>>> +  Multi-channel temperature monitor and PWM fan controller.
>>>> +  It supports monitoring up to 10 external temperature sensors and
>>>> +  controlling up to four fans. The fan control lines are modeled
>>>> +  as standard PWM channels.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: adi,adt7470
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  "#pwm-cells":
>>>> +    const: 3
>>>> +    description:
>>>> +      See Documentation/devicetree/bindings/pwm/pwm.yaml for the
>>>> +      generic PWM binding description.
>>>
>>> Drop description.
>>>
>>> You OTOH, miss ref to pwm schema. Referencing here in description should
>>> raise you questions... And then use unevaluatedProperties.
>>
>> I will drop the description and change to `unevaluatedProperties: false`.
>>
>> Regarding the reference to the PWM schema, adding `$ref:
>> /schemas/pwm/pwm.yaml#` enforces the `$nodename` to match
>> `^pwm(@.*|-([0-9a-f]+))?$`. Since the ADT7470 is primarily a hardware
>> monitor, its node is typically named `sensor@...`,
>> `fan-controller@...` or `hwmon@...`. Importing `pwm.yaml` causes
>> `dtbs_check` to fail on existing node names because of this mismatch.
> 
> If it is a fan-controller then it should use common fan schema, because
> you might be missing several properties.
> 
> Device having PWM outputs alone does not make it a fan controller, though.
> 

It is a fan controller. The logic used here is the opposite:
It has pwm outputs to control the fans, therefore it should be modeled as
pwm controller and use pwm controller bindings (to clarify, this is not
my logic, but both DT and PWM maintainers insist on it).

Also, to clarify: I do not like the idea of registering pwm outputs with
the pwm subsystem and require the pwm-fan driver to actually control the
fan. I prefer the mechanism used by, for example, then emc2305 driver,
which registers cooling devices with the thermal subsystem directly
and uses of_parse_phandle_with_args() to extract the pwm configuration.

However, the patch author claims that the pwm outputs are used for
non-fan-control purposes (such as controlling LEDs), making the two-driver
approach necessary.

Guenter

