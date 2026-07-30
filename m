Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452C3D7D82
	for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447427; cv=none; b=QfTggcpzKOvCHgX4BtGv9TOVFrRC9pwo02qr1tGrbjW0/PJLqpY8c+pN2+aBhJ/Dp1hJ23MkEf+pe0wPn/maoS+4MTUpv0jo7hwqCfK0DdRqGMt2rTKBSENXn4ojcrojFTv7jKvaRRDx/x+2DqMFXVmeEBltMz3FMKW7308+hCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447427; c=relaxed/simple;
	bh=fM7PaKr6XzDRd6cI4tRma1U64Zu7/4eg+yorapGDp/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCChTIdIpuSUK6OFLD9qon95aPH7zlnC6aoYSK0Qz8XeieTSu+BjgR+XxTO52kRmglL+d/6ASPbPtcyl7dtrAC1z3e6LF1cuLGKY19N9Dlz06re8dJgCEi3CUpUSNNO/gF6Ogu4NsyIBY1EV0D0T7c+hhE6Un/mD/h/wcRinrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oA959Lo2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oA959Lo2"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848761b5897so269544b3a.3
        for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785447424; x=1786052224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fM7PaKr6XzDRd6cI4tRma1U64Zu7/4eg+yorapGDp/s=;
        b=oA959Lo2Apfw+AY8c9t4Shj2Qhldk+p/lv8RUTBJByCiYqRXK5unGVP6dFsMWPthUO
         X6t6U1Taz2QL3y3yfmmffXwXf3yqbg2JYEhPDaMJfxyL2baQpnvG9PlyQW7Dw9FnCUQX
         86T+JBLW+l986zP/4wyeaFSCXmjEslrTZRqKrLMdXNugShbiBmjSHczhpXMrSLeV2so6
         aCoD1uDh2SzQgx+KSRAdGVWUX1T6v1T88OdaKklAIdhqmWPKh//KMr2p4bxSMq49gJA7
         3RXht8+GMtytex+qZjtKZleD8Xfe/YC5fksYjoGqNEohpnoUjb4yMI9bfxq1izICsemz
         NMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785447424; x=1786052224;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fM7PaKr6XzDRd6cI4tRma1U64Zu7/4eg+yorapGDp/s=;
        b=h5XRGzAaE4PbH0D+aflsxWAk68riDYAMwdPe1KRXKPiotGrdqk+/7PNDiDIeLaWqAz
         pgpWWlAa8zE7S7gQ1Y4VtkhuxQxyqMBPLxicxjmBQFOgIV8EmbvY+vqsy80woNZ8SZvf
         CFQExlwtzV+TEg+Oa1tkHu/C6v4+9Mixzi/xnhwqVKRdV6py8VgOe25v1cSF484Rmg8u
         7JqyDkoY2fsMGvzDmWr5H9S+1O439LKhe4BI/Izzo+7ovhhmZDHaKCNAbTCVVKSgbJg6
         cs7sYBqqMvRhOy0YTeJJYQF8i6pT3yZOsFEu7qno6UKHB3sBGbW5R94k3WZq6XsqXMiw
         Mn4w==
X-Forwarded-Encrypted: i=1; AHgh+RrDl4mtCtf4lnoXtond3swwP4rThzAc58D6W+Na1DCWgg00h5EuWm2dkfqnyTs+xEJfp7SJ4Anu3gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJG1cMZQBcameqq+dN5isj55hRHe2CdTs5ArLRyFVPyjbhUUz
	nsOxveYd6xdxf4JlcR5leQ6KQxCc3JLoUrkkTbHiPkS8wYTiOJGw0KSs
X-Gm-Gg: AR+sD12b7+AvwMgUprkIqrw6KrPnK2fpr8k6VkHA3R8qUsQZDtAap/J3sZKJjefbza7
	6hca1rLjag4UKjzU6ppgtvUdvOc9mwpM82vlNf8iaIJfqL5nGDGhfV2Sb+bNXiEMk+wKvD/+kKL
	GKh368fouI50qkgyrj8USQq0HNAg2woZGVleIOebjcY432T5/JbN9yZi73rR5SHjquobkBFnwWi
	JdYu3RsFgJAqhtlKnabuiB16wSY9R9kg4zAFt1ANbSeapCSsGbuifipGaBPR3Xuen67eJdd18dr
	OvlrivTyibgq963+hiKH6LHY9ScYN1YEcQg2c9P2fNjL8QNU1AM0zTDUcZVyfRC94VYKYW6aDFr
	TWw/s+pyPcAqsFOZL+ajOni57+C5547I1H2ND1q56h00nxlSjFGX3SrrP/pZH2Rd/bfORzo10Y7
	g8lbF5TQpFbXyPbUORE4fmlqTCOjZwMkyoVF9nH+RtdjlFeigrM2kss8EJxYHMnSoOBW/rOd6WP
	FGiBH5yAH1rIlsvIGPShhgcbjg0+BCAvawT1w==
X-Received: by 2002:a05:6a00:cc6:b0:848:4c0c:59b4 with SMTP id d2e1a72fcca58-84ebc43dadamr4018399b3a.64.1785447424012;
        Thu, 30 Jul 2026 14:37:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03ccc92sm3638074b3a.58.2026.07.30.14.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 14:37:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a447e67e-ac2c-4b8c-bb96-b469d2a2d61a@roeck-us.net>
Date: Thu, 30 Jul 2026 14:37:01 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [hwmon-next PATCH v3 1/4] dt-bindings: hwmon: adi,adt7470
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
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
 <6cc03c4c-2d88-46f2-aee4-adb769d10cbd@kernel.org>
 <05b7f116-25a9-49b3-a31c-15eb4e6ec838@roeck-us.net>
 <CAJq09z5GL16qQ6smjEHsiYxpXn6MaBkibwsvSR66cJ4kEx1M6Q@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAJq09z5GL16qQ6smjEHsiYxpXn6MaBkibwsvSR66cJ4kEx1M6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/26 14:11, Luiz Angelo Daros de Luca wrote:
the architecture, while I looked at the `emc2305` approach,
> delegating the actual fan management to the time-proven `pwm-fan`
> driver allows us to avoid reinventing the wheel (like cooling device
> registration and state management) inside the adt7470 driver. It also
> keeps the standard PWM consumer/provider relationship clear in the DT.
> It still feels strange that emc2305 declares #pwm-cells and its
> subdriver fans pwm properties and they do not work as a pwm
> controller. Other drivers, like aspeed-g6-pwm-tach (with similar

That is your opinion. #pwm-cells and pwms exists because it is mandated
by DT maintainers for configuring pwm properties. That does not have to
reflect the implementation: DT property guidance explicitly states
that properties must describe the hardware, not the implementation.
There is no mandate how to implement a specific driver (such as a fan
controller driver) because a specific binding exists. It is perfectly
valid to describe pwm properties of a fan controller using #pwm-cells
and pwms without modeling it as pwm controller (which actually mandates
support of the pwm subsystem or no good reason other than "because").

While you may consider the emc2305 approach inferior, I happen to
disagree. That is your personal opinion. For my part I consider it
inferior and overly complex having to involve another subsystem (pwm)
and another driver (pwm-fan) just to make the chip's pwm outputs
visible to the thermal subsystem as cooling devices.

Guenter

