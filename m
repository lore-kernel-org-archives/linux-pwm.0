Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCCD3911AF
	for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445933; cv=pass; b=WO6ZghwBxe6Is0OlWX5isU4wJiKI3Tmn/1PTR08lsSUONRVN2UhvxxdLlN+tviqDPXanGk95Siw85p602MjYRTv+h2iowrgRlpGZr9OzIfYUK1Gz2pZiLva8LwJFbANe9e0apBn9khZhRVcEDHb9QK7e6y8nPPYL5lNiJVaa0Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445933; c=relaxed/simple;
	bh=iEk4wpw9FQcrEvdQXfSWeVmHqPtsb28Pgjf6F+uacz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0Ckb+fFl4NYCoXI3CeQOUdOIlBDoLR4MW+2Baxjsnoxmmkeepd570nQq4kuYDxLY2txHlKGUrPNb2oOYSOH94pcAEMjoNQjRfTTxXFJrKJpomc8gzTkc7q/jjKLpqICbEj8nMcbehcw2HcFLgUbeDVBmSG3Adn3eipgB49Cql4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDHdSGWU; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDHdSGWU"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so418060a12.3
        for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 14:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785445930; cv=none;
        d=google.com; s=arc-20260327;
        b=Ia+XpEptniwOmgRCUJ3qU9b54uK7Hw36l+duKvY5FpdquUmgJCuXY8h8gE1f6ZUfS/
         1caeKdirioBCplhE1tHIUEKJ1nmvnA4S4Ac0+lfAhnYK4bO8Uiz0elYLr2EWiWRXQh0K
         EZw7rs1C/qsv7dMxvsq26KbjSNHdWkPrBKLgYXlL7cUra6ik0vgRN0K2OA9OTE3IWBHG
         cptA+H4unqp8H2eV9XElBm0BkxQhcoiukLdiSJyxLJuXLiVJRHHx4yMLzhdkQArVBjJH
         xC9uxw1kmbBPI33XrcY31N1YWfV8bz4UnZUgxN/OUiIVUjkusJg4AQJ931i+mjCz//1A
         XVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5dc/ptklzYhJxPB/24UBcqyDH7hAbMtvydGT0r8k5oY=;
        fh=bvIUXM6cQHouJorHhOVv/plTw5JzhA1Hx5SRhC1RkCM=;
        b=rJUJXzYC6E7PAkDdrw8QHDpdhVrKZy0DtxmyI2yDthqhm2bMrTWLoXaeJBIfhoyQEJ
         IDIiyQQNBFGjlROb0kBwDpUSHTiHp/jqjNdeAts1B4WkHbdBCZRI9xLwrZMxGMip8LWD
         CspGHvTveNEe2vHD9gfh5YG7k5kuJ5Yny0qXWGUPq1+dG8XZjhwJ4G2qSdx2KRqna1o9
         5C9WHi1gn1PNPKVjo/YoCvpW8hRqHQUx4RCzp8XfgwtxR6CSS1LUAvF+0aeEAHKgjRUZ
         RrVubcAMzT2xex+nn4DHdlu1//81VILtzsqeZNLtn3CZ4QBVD4zHrcJShO1rs8/5/EpN
         IQ7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785445930; x=1786050730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5dc/ptklzYhJxPB/24UBcqyDH7hAbMtvydGT0r8k5oY=;
        b=XDHdSGWUjdgbK9XtauMeau0k5VXlRL5iUpIHnjb4TLgA9+tEh7OumZq5xH7NIfJOQl
         52pHqsLeJPynQvpbf8xjGfI2wEq2LvG2RF95Vj6LQ6eyLuEio6MgS28RZj/C7xDgkYTS
         zkUrgjo8lWqYr/xhnFNF4wScB9iH9JbuPfXHVAbD0qZJmYusr4U0hcZ6e01eJB+ngCyQ
         W4bF8jAKzN1bSZsJdfz3rsxa+eArP11uzSb1Jf4J7XfoOpHZD6dUGLETk5XAAPGRuIF+
         okBYtqHsWNep+W+GgGiKt+ia5jFXOKQ7R9a17u3m1wHK4UIQnquIbrQFb4l46m6m9g8B
         W8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785445930; x=1786050730;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5dc/ptklzYhJxPB/24UBcqyDH7hAbMtvydGT0r8k5oY=;
        b=oJUtucTED9c+TKKk4YmOU9gx+N6NSkzoowLQoG9NK5eYIb/AvgPRrR9BfhDkYiKe6m
         4Ikh6mUNmaxmCRN7pHAtHQ4eZNeTz7zILX4PTLl1w8n32cDXjGRockTaItLO4GhFYp1d
         yeAd+FNSh1N8dSUOyZxZUUePfwrVX4f2KcOt1sfaa0Ep0IVVK594b6E3ipW+YNswQi8F
         QTYHuttabLos9E4HjUBWep4xDvmJegvtPGiDi8gyaxRtUfTCYVrzuoIP8Y2qfxRntfQm
         NRFcPMQOvAyEE6c9NSJrLtyxC0LYBbW84uC0iEQg4VYBBHP2rSQX+fggpVdyfDYX/8o3
         z8oQ==
X-Forwarded-Encrypted: i=1; AHgh+RrY8BwyGdzRouavfgFzG+YL+aNfefKhMjU7OvpZ7MnNDC97DjQPavZ62R4WC3BpTCjjMWnN7wtjjpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7UjcnemPoyhWmhRNSBQ5yWHb2STsc1fwDhfXAK7pGnqWRB34
	S4ozOCOGkGrS4dhU3JMTadmXT5Dy61vs+TuaiOni3OAjn6A/xFpr35F+Qoce9tEG7ULcXmdbaMd
	bvCqb1LNW/KfPnRLrnxeEex5QmMIpZ9M=
X-Gm-Gg: AR+sD12iU7b163Utjmy+7vqQpSZu1zqnzmteqbL6ytlYAHoq44Ot2OS7B8NTW9GrW19
	riNpHliTLaAuIRt5vHOS+e9Ad/iFXm8hCJPdjeLu0bjK4DN+WkDeppsI4+a8X9zljURSlg065A9
	b8NzycYORc6KIFNyVxzzAHYBUOqneFtQT03UT7laIkM8Fvc4PO1cJQ5Q4U8y6DVQf8ttPPXe9i4
	VFFonzwuigyR364RUHZH83XnsOTsZ4wBiLg5szzHDW6wtB2Az4lKSTRhPsw5+xMqT9UvjqFspOn
	1N81bXaAeWrJOBzpyknBK+2ODuaQV5yRrH7TK07H/SuVh8V/Z9vGHXoYpu6JINt88BSiXBYbEvm
	9
X-Received: by 2002:a17:907:d0f:b0:c1c:3705:dde9 with SMTP id
 a640c23a62f3a-c1fa580990cmr214119066b.64.1785445929666; Thu, 30 Jul 2026
 14:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728-adt7470_thermalzone-v3-0-d4586478cdba@gmail.com>
 <20260728-adt7470_thermalzone-v3-1-d4586478cdba@gmail.com>
 <20260728-meteoric-quixotic-sunfish-0de2cb@quoll> <CAJq09z5CQgzzFahoiteh9ykjdbsYpP=QZ2AugzY4tQ79RpA-cg@mail.gmail.com>
 <6cc03c4c-2d88-46f2-aee4-adb769d10cbd@kernel.org> <05b7f116-25a9-49b3-a31c-15eb4e6ec838@roeck-us.net>
In-Reply-To: <05b7f116-25a9-49b3-a31c-15eb4e6ec838@roeck-us.net>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 30 Jul 2026 18:11:57 -0300
X-Gm-Features: AUfX_mz2XCdOnosHGQc59ddl9-gEcC1_EFpjzuEeLq-UVrlScXWGcDPbsI2vkYk
Message-ID: <CAJq09z5GL16qQ6smjEHsiYxpXn6MaBkibwsvSR66cJ4kEx1M6Q@mail.gmail.com>
Subject: Re: [hwmon-next PATCH v3 1/4] dt-bindings: hwmon: adi,adt7470
To: Guenter Roeck <linux@roeck-us.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Darrick J. Wong" <djwong@us.ibm.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em qui., 30 de jul. de 2026 =C3=A0s 12:38, Guenter Roeck
<linux@roeck-us.net> escreveu:
>
> On 7/29/26 23:17, Krzysztof Kozlowski wrote:
> > On 29/07/2026 06:45, Luiz Angelo Daros de Luca wrote:
> >> Hi Krzysztof,
> >>
> >> Thanks for the review.
> >>
> >>> On Tue, Jul 28, 2026 at 12:07:09AM -0300, Luiz Angelo Daros de Luca w=
rote:
> >>>> The Analog Devices ADT7470 is a multichannel temperature sensor and
> >>>> PWM fan controller. It supports monitoring up to 10 external
> >>>> temperature sensors and controlling up to 4 fans.
> >>>>
> >>>> Add the device tree binding documentation for it. This includes
> >>>> support for the thermal framework by defining the "#thermal-sensor-c=
ells"
> >>>> property, and models the fan control lines as PWM channels by
> >>>> defining the "#pwm-cells" property.
> >>>>
> >>>> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> >>>> ---
> >>>>   .../devicetree/bindings/hwmon/adi,adt7470.yaml     | 55 ++++++++++=
++++++++++++
> >>>>   1 file changed, 55 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adt7470.yam=
l b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..bb2375a4a490
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/hwmon/adi,adt7470.yaml
> >>>> @@ -0,0 +1,55 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/hwmon/adi,adt7470.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Analog Devices ADT7470 hwmon sensor
> >>>> +
> >>>> +maintainers:
> >>>> +  - Luiz Angelo Daros de Luca <luizluca@gmail.com>
> >>>> +
> >>>> +description:
> >>>> +  Multi-channel temperature monitor and PWM fan controller.
> >>>> +  It supports monitoring up to 10 external temperature sensors and
> >>>> +  controlling up to four fans. The fan control lines are modeled
> >>>> +  as standard PWM channels.
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    const: adi,adt7470
> >>>> +
> >>>> +  reg:
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  "#pwm-cells":
> >>>> +    const: 3
> >>>> +    description:
> >>>> +      See Documentation/devicetree/bindings/pwm/pwm.yaml for the
> >>>> +      generic PWM binding description.
> >>>
> >>> Drop description.
> >>>
> >>> You OTOH, miss ref to pwm schema. Referencing here in description sho=
uld
> >>> raise you questions... And then use unevaluatedProperties.
> >>
> >> I will drop the description and change to `unevaluatedProperties: fals=
e`.
> >>
> >> Regarding the reference to the PWM schema, adding `$ref:
> >> /schemas/pwm/pwm.yaml#` enforces the `$nodename` to match
> >> `^pwm(@.*|-([0-9a-f]+))?$`. Since the ADT7470 is primarily a hardware
> >> monitor, its node is typically named `sensor@...`,
> >> `fan-controller@...` or `hwmon@...`. Importing `pwm.yaml` causes
> >> `dtbs_check` to fail on existing node names because of this mismatch.
> >
> > If it is a fan-controller then it should use common fan schema, because
> > you might be missing several properties.
> >
> > Device having PWM outputs alone does not make it a fan controller, thou=
gh.
>
> It is a fan controller. The logic used here is the opposite:
> It has pwm outputs to control the fans, therefore it should be modeled as
> pwm controller and use pwm controller bindings (to clarify, this is not
> my logic, but both DT and PWM maintainers insist on it).

Hi Guenter, Hi Krzysztof,

Thanks for your review. You are both right about the nature of this
device. While the manufacturer markets the ADT7470 as a "PWM fan
controller" (and it does have internal closed-loop capabilities), the
physical pins are multi-functional. They can act as generic PWM
outputs or even GPIOs. Because of this flexibility, tying the binding
to `fan-common.yaml` would be too restrictive.

On my specific hardware (Edgecore switches), the vendor bypassed the
ADT7470's internal temperature sensors entirely. The fans must be
controlled by the main SoC's thermal zone (or any other userland
daemon/script).

Regarding the architecture, while I looked at the `emc2305` approach,
delegating the actual fan management to the time-proven `pwm-fan`
driver allows us to avoid reinventing the wheel (like cooling device
registration and state management) inside the adt7470 driver. It also
keeps the standard PWM consumer/provider relationship clear in the DT.
It still feels strange that emc2305 declares #pwm-cells and its
subdriver fans pwm properties and they do not work as a pwm
controller. Other drivers, like aspeed-g6-pwm-tach (with similar
bindings) do both: use a fan subdriver controlled by hwmon sysfs and
register itself as pwmchip. But this is exactly what Guenter asked me
to avoid.

> > Since we cannot override the `$nodename` from an imported schema, what
> > is the preferred approach here? Should I skip the `$ref` to `pwm.yaml`
> > in this specific case, or is there an accepted workaround for sensors
> > acting as PWM providers?
>
> You can skip the pwm.yaml in such case.

OK. Thanks.

> >> You most likely miss ref to thermal-sensor.yaml as well, but that woul=
d
> >> change the ABI since hwmon would fail on missing cells, right?
> >
> > Yes, you are right. It would require #thermal-sensor-cells and the
> > device might not have a thermal sensor connected if it is used as a
> > pure fan controller. Likewise, it can also be used as a simple
> > analog-to-digital temperature adapter, with no fans connected (and
> > "#pwm-cells" might be missing).
> >
> > To address this without breaking the ABI, we could add the ref
> > conditionally if "#thermal-sensor-cells" is present.
> >
> > allOf:
> >  - if:
> >      required:
> >        - "#thermal-sensor-cells"
> >    then:
> >      $ref: /schemas/thermal/thermal-sensor.yaml#
> >
> > I just don't know if it is ok to ref thermal-sensor but not pwm.
>
> Feels ok.

Thanks.

I'm sending v5 soon with the current approach. If needed I can revert
back to the subdriver/cooling device directly in the adt7470 (as in my
v1). In any case, both approaches share the same #pwm-cells but the
subdriver would require a new fans property.

Best Regards,

Luiz
