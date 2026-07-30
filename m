Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8528331EDD;
	Thu, 30 Jul 2026 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785392298; cv=none; b=dlmMBXONq6FL4vFXFGIBi64tXHI0svf5qGQG2wtv8PRUHgPoq+BTWeEtiGlSS6CTrkuR6CEhN53oNzGnkFftWLy3gLno8fUzD+IipJ2Ulb5bEUh9eIwpTkeO7cn0SZHyQtgxIHQ8vNTQiBhcDF4LHZdzI8EsktoCcZNFefCTIJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785392298; c=relaxed/simple;
	bh=l62V11cowrqeI8BnXl99ue73qOhyR2JHYebtAXEeqAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+vjqxBj6jpkvYtlhhTn5AF4Jcb+kS+mEBojrHBmhzuSpZQnfH2beXx1gcpqlSyYckkE19UTX8tRkFl28KmqtLIDBvQeYB4qL/u2ZvMr3xfF9/zozGVNzlkkWFjzKKgyeYah8MW/qyTnhRhRcSBy5TrGQUJZLl4KM11Cqroypto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fzzop7oK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fzzop7oK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA261F000E9;
	Thu, 30 Jul 2026 06:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785392285;
	bh=Jp+eBZgiwD0pRTnxUq82s1K5W+2JyXhDd+iXNbrfcvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Fzzop7oKjJ0Rqj2Dgo594sxMQB/hn3b1TZ+1TdWBybJ72SFytz1AdKjyJhnTNA2EM
	 M1Rt4ksHmDUFR/hWfUAfYpyWmmgbPTPCpw5oWRGMQXFyLQzCt5AVkCPDNPIhsGNz3o
	 f0wCn2gR3mCJqUtWAjLLqcAd7S2y1iPGfP3CdpMe0Mn23Qc3Ca4xMINGywzX5nuYS5
	 mLSwxLiJ/3vTMygoFRCcIcEBaIWLQ3ksMlreqnOrkHy688wkW9Yv/e+CmDmOfjGHvd
	 x95Qq15fHfq7clRzqrgHmXvqsN9e7O8UtI4NeqhRTYibcTUF+4UwWyRAoPDzy+59Bq
	 Qu1jvQeLrwr7g==
Message-ID: <6cc03c4c-2d88-46f2-aee4-adb769d10cbd@kernel.org>
Date: Thu, 30 Jul 2026 08:17:57 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [hwmon-next PATCH v3 1/4] dt-bindings: hwmon: adi,adt7470
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Darrick J. Wong" <djwong@us.ibm.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com>
 <20260728-adt7470_thermalzone-v3-1-d4586478cdba@gmail.com>
 <20260728-meteoric-quixotic-sunfish-0de2cb@quoll>
 <CAJq09z5CQgzzFahoiteh9ykjdbsYpP=QZ2AugzY4tQ79RpA-cg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <CAJq09z5CQgzzFahoiteh9ykjdbsYpP=QZ2AugzY4tQ79RpA-cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/07/2026 06:45, Luiz Angelo Daros de Luca wrote:
> Hi Krzysztof,
> 
> Thanks for the review.
> 
>> On Tue, Jul 28, 2026 at 12:07:09AM -0300, Luiz Angelo Daros de Luca wrote:
>>> The Analog Devices ADT7470 is a multichannel temperature sensor and
>>> PWM fan controller. It supports monitoring up to 10 external
>>> temperature sensors and controlling up to 4 fans.
>>>
>>> Add the device tree binding documentation for it. This includes
>>> support for the thermal framework by defining the "#thermal-sensor-cells"
>>> property, and models the fan control lines as PWM channels by
>>> defining the "#pwm-cells" property.
>>>
>>> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
>>> ---
>>>  .../devicetree/bindings/hwmon/adi,adt7470.yaml     | 55 ++++++++++++++++++++++
>>>  1 file changed, 55 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
>>> new file mode 100644
>>> index 000000000000..bb2375a4a490
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
>>> @@ -0,0 +1,55 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/hwmon/adi,adt7470.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Analog Devices ADT7470 hwmon sensor
>>> +
>>> +maintainers:
>>> +  - Luiz Angelo Daros de Luca <luizluca@gmail.com>
>>> +
>>> +description:
>>> +  Multi-channel temperature monitor and PWM fan controller.
>>> +  It supports monitoring up to 10 external temperature sensors and
>>> +  controlling up to four fans. The fan control lines are modeled
>>> +  as standard PWM channels.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: adi,adt7470
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  "#pwm-cells":
>>> +    const: 3
>>> +    description:
>>> +      See Documentation/devicetree/bindings/pwm/pwm.yaml for the
>>> +      generic PWM binding description.
>>
>> Drop description.
>>
>> You OTOH, miss ref to pwm schema. Referencing here in description should
>> raise you questions... And then use unevaluatedProperties.
> 
> I will drop the description and change to `unevaluatedProperties: false`.
> 
> Regarding the reference to the PWM schema, adding `$ref:
> /schemas/pwm/pwm.yaml#` enforces the `$nodename` to match
> `^pwm(@.*|-([0-9a-f]+))?$`. Since the ADT7470 is primarily a hardware
> monitor, its node is typically named `sensor@...`,
> `fan-controller@...` or `hwmon@...`. Importing `pwm.yaml` causes
> `dtbs_check` to fail on existing node names because of this mismatch.

If it is a fan-controller then it should use common fan schema, because
you might be missing several properties.

Device having PWM outputs alone does not make it a fan controller, though.

> 
> Since we cannot override the `$nodename` from an imported schema, what
> is the preferred approach here? Should I skip the `$ref` to `pwm.yaml`
> in this specific case, or is there an accepted workaround for sensors
> acting as PWM providers?

You can skip the pwm.yaml in such case.

> 
>> You most likely miss ref to thermal-sensor.yaml as well, but that would
>> change the ABI since hwmon would fail on missing cells, right?
> 
> Yes, you are right. It would require #thermal-sensor-cells and the
> device might not have a thermal sensor connected if it is used as a
> pure fan controller. Likewise, it can also be used as a simple
> analog-to-digital temperature adapter, with no fans connected (and
> "#pwm-cells" might be missing).
> 
> To address this without breaking the ABI, we could add the ref
> conditionally if "#thermal-sensor-cells" is present.
> 
> allOf:
>  - if:
>      required:
>        - "#thermal-sensor-cells"
>    then:
>      $ref: /schemas/thermal/thermal-sensor.yaml#
> 
> I just don't know if it is ok to ref thermal-sensor but not pwm.

Feels ok.


Best regards,
Krzysztof
