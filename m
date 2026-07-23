Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EF242A96
	for <linux-pwm@vger.kernel.org>; Thu, 23 Jul 2026 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784774914; cv=pass; b=CzhxbXNuhHjAduTlc3r7TyFf5EhFhXa7hmccK1+BP2dlpa8IYvMzqYNfdUB58NGPieCH2+M9nkF/iyVUwEdeNbLb/aIeb85hDLTwi9RejGTZoS7NVl+I+IZrMxl9U7uM0xhrn2wDHvOwavQE/wnGiOSW88+0MTrtE9kyjg0J4Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784774914; c=relaxed/simple;
	bh=ke7GuAFVu437cGSyxYRHXKBdtjCTY1U8R29Cxj1Ke88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgG6Kff48QO2m1yId3ZuHNRTKbhuIHhSJXvExicet9oLgVPSDxr5xwWtFrHlMpxxSOUUFox+R77baZfuJ09AHXENiF3X6ljXKbCtT7UmdAEJNfSezh1HrFgiIbNPkC5qZtgx74gZ1FUEAeC9i65/2bIEXDUUWwR9Of+SwhqdYWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/naGK3a; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/naGK3a"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1670dad7a8so28937866b.3
        for <linux-pwm@vger.kernel.org>; Wed, 22 Jul 2026 19:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784774911; cv=none;
        d=google.com; s=arc-20260327;
        b=D7G4CjOeFLXXR0+D4rF60ICeHRrHe8jaMrxC5uSJAeVZomrN5PbIZrOSfZ1b7JIAl7
         0X4LCzzOU0MIF/pxpkmWoRDLFY8cmSvo5GPMnHlkEwiGm0w2nj9EdFURsgjLOPoaIRrM
         qdCeKHwJPwtxMf54xIgm3FOMRSEM/olxjV4Q+koBV/4+qa7Li/vBjdEoHkYVcDwOIE7l
         FNjgtmiTU9UhCS+rkPgeJrJcX8qhe2k7tYYNan1/FE9n/pigVYLzkdkqeoJi+Mcbq/sw
         VFOCKES5j5HdMR9ETQAVh54rVm3Gb/tYZDASZsHHKA5qWbmvOGprYzcCGrEh2RqXpc3v
         qqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YXTUY4hlZVOZQ6Ng/x5Zh4USeJPKiqRMjOwBWZGBJKI=;
        fh=lqMocv5bwHIvqJW7T9ftq8wOrWcAWN7uuqt+odVl3ho=;
        b=AixDMjNdw/ucEeirwnNk3ys0ahmb3/GL+YQRd6dIxBpBXPCPT4ohqfDut7zOZxr8+Q
         hZstJ4zz+cMblHMhpO6hVVPybK4f8+xjpF6Ao/UE6WztyTbsZ0TjGk5M0qWXWNM84xOa
         aEEZZJfsXX0DdTtNw4xW1HJfE9IFCfkvxVSK98JsGuWt0G8p8YzCm1UgeHpxf78lkgW5
         gCkmV6QItJvwuFQgnS6BfmqqaGKGP0syUJDeyBIStcFArMwxg8xHMBkMdJzOeHZJm1cQ
         Zpw/ViUYKOEokjritJLnkZrsNF3+8exS6qatl/+wZGiDO+77K7XfPLUQDUR2QpVscXli
         FZ4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784774911; x=1785379711; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YXTUY4hlZVOZQ6Ng/x5Zh4USeJPKiqRMjOwBWZGBJKI=;
        b=g/naGK3avTabE5114tTgCShzUmBWRcbzEf+vhG+zFbs3JPuqAPtNOvwKI60HCMrU0O
         vNjPm7lomimMBIFMTWQV3VxKgJDGOQBOu4Q+IIANY7VlQ5LTyDdl6uk9qW0vRVGnsIVb
         bQM7vZVKfcvmatIYoQXBWwl81u77XEMyY0oFnt02WS6r49b8sH77X183w0xiHx17CxBs
         IQZCi6cWSR1GbxTac28wbhvutGyVblXecNe+vaJ4IDizddNdYR8RllEWdJgPamIVk7QY
         EImkhuA/5rVbHoXpNtOCXXJXb21kCuTCh9UKH5JrS+ub9GN8ReOl8HjWpRPqkK5Mk09c
         iPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784774911; x=1785379711;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YXTUY4hlZVOZQ6Ng/x5Zh4USeJPKiqRMjOwBWZGBJKI=;
        b=j1HzI+SC1ONmRB33TB+z823UK3Jvr6Lr/581G4KO8K24p7jrutpEmnAOomxydtAnbN
         IC1fK5yJtWiYD9ezu1XNjkzGIM326LUQs0pwuUZRVRZLbCWlCon9ItcO7itDtkeQqiRS
         M8Tet4IFRJ+XhavpIJW8vp/fP7mqJjm2ZNlr9thuvwxPr5RzcNAjPM2MXTqivbqk4OUf
         oWc37IfhsE5j3Peib3l2rCX1eX++AVAibjeNgRw0rtgP2F//n2bgrOxbe/Xjsiv6cG6+
         lETCB5E+rrV3LhenrOWqDC9Ic3CaoWKZvHAdOb+/oWV2MhAh5YibgtcW/TMlghkglH84
         TkTw==
X-Forwarded-Encrypted: i=1; AHgh+RozOVWxU2Eeb3tQSEBU4uCnlk+6D6zZB/XEhf2CDKaBydjQC/beN5mW+Tb8lmeGVmTosoSqIIY6QMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYnzpG0WYP8PwAhjvzfN799Qkt96yhVwp17CszmyPNZJ4sfNHL
	HLMfzLP7A56OD9eitION7hi2VpDai9HQZNqgFYwBW3g/elYFcOBMDd6UiqozyTDp9a9oqa1PxC5
	OLX5/QK5NABqpfFGJFZ7FxuhIxHuu7ew=
X-Gm-Gg: AR+sD10aWzwTPPZe+cOpMR4WQzgBb6oHfZyXqCwqSBwSHywHViF5MfMSeoyeaCPTu+Q
	1VaZo3DvnBzLxniZvzLpjmGqBbxYkZkvuNaTkGOjhQUFHjM5PuOfSbzdxA3Fpt1lwR86YXW3o/Z
	jnRWN+ctOknLOsf4jEZKaiwBKueR1b6f+4ZvYXD+rjqVAj+l7hr1s8wtveucEX/tUgtSGTNVrMB
	tY/ReVdZcZ2lxfwaPuNx0btHNFpM8fbfh4qyP9WBlJKvGyeAYgLHvtrQ0Nd8wueS2RRn2zw4Yi9
	685Q2/qKKEd3UIYtlYv4
X-Received: by 2002:a17:907:a4d:b0:c16:2dc0:e1ed with SMTP id
 a640c23a62f3a-c1c5092a1e9mr61858566b.4.1784774911324; Wed, 22 Jul 2026
 19:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-adt7470_thermalzone-v2-0-a55147958fad@gmail.com>
 <20260717-adt7470_thermalzone-v2-1-a55147958fad@gmail.com> <al3yFHvlzQuIywEj@monoceros>
In-Reply-To: <al3yFHvlzQuIywEj@monoceros>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 22 Jul 2026 23:48:19 -0300
X-Gm-Features: AUfX_mzkrTPcnkr7ItIXKDS6UZlJkREqRBtsmkpKmefnqjNZVsCZyHSowWgwH7Q
Message-ID: <CAJq09z7z13hO33xpfQNYc=eHec3yN3H2yVy=oqXhuvhRZhvX3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: hwmon: add binding for adi,adt7470
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Darrick J. Wong" <djwong@us.ibm.com>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Uwe,

> On Fri, Jul 17, 2026 at 05:59:14PM -0300, Luiz Angelo Daros de Luca wrote:
> > +  "#pwm-cells":
> > +    const: 2
> > +    description: |
> > +      Number of cells in a PWM specifier.
> > +      - The first cell is the PWM channel (0 to 3).
> > +      - The second cell is the PWM period in nanoseconds.
>
> Please use #pwm-cells = <3> and $ref: pwm.yaml#

Thanks for the review. I already switched to #pwm-cells = <3> for
the next version, so that part is settled.

Regarding $ref: /schemas/pwm/pwm.yaml#, it doesn't quite work here.
When I added it and ran
dt_binding_check, it started rejecting the example node:

hwmon@2f (adi,adt7470): $nodename:0: 'hwmon@2f' does not match
'^pwm(@.*|-([0-9]|[1-9][0-9]+))?$'

It turns out pwm.yaml also constrains $nodename as part of the
allOf, so referencing it forces the node name into the pwm@...
pattern. That's not right for this device: the ADT7470 is primarily a
hwmon chip (10 temperature inputs, 4 fan/PWM outputs), and the PWM
channels are just one of the interfaces it exposes, so hwmon@2f is
the correct node name here, not pwm@2f.

So, for the next version, I'm declaring #pwm-cells and
#thermal-sensor-cells directly in the binding instead of pulling in
pwm.yaml via $ref, and pointing to pwm.yaml only in the description
for context:

"#pwm-cells":
const: 3
description:
See Documentation/devicetree/bindings/pwm/pwm.yaml for the
generic PWM binding description.

Let me know if you'd rather see this handled differently (e.g. keeping
the $ref and accepting the pwm@ node name), but I think keeping the
node name aligned with the device's primary function is the more
correct approach.

Regards,

Luiz
