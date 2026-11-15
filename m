Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.21.61.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782065;
	b=W3MUjfpz2hyZHVsIooYjSenz1HFX183GqoVrWVqyk4GihPoQntmaBtxRQ1AN1F2tkGGo
	 IoHUr65uHxtnMcCZJlKs58VBGvOmkci5cry9OMsuUFav8rqRCUNs0vfNUzLuQHA4BtErK
	 f1N/tPmtsf6Hh1eNodIKUjJGPPWA8ohnE90+PwefUyCt53ig0JvPFcW5dFlfC1p05cmQN
	 7JyOZEjhDVMX2RGQMfJm9wtDTaDVaeIJHiUJfil6Psss/cjAiWf5Xb8gUwM08uTzxVQzL
	 YsgkHah+zpJEREHYNBhHHmE4KFKtsU15vAwUP/SxUAFBJu3K+sTY1BnUeI63JqZcbxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782065;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Date:MIME-Version:User-Agent:
	 From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fryKUfiblkRf5EZy4DapCqcWujvmZ+UyUkaCr01AeDU=;
	b=JzEwmqgRgyY14MgdC4ELpUpLosgFfbB4pcWJ+oH2HzvLIc+vSJNi64c2uFqrFRfgDV3b
	 PfD3+Q+MKYmkIRarslD48uVkW/pJNAFhDLo6+T9PMaV2fJQBC+f5pQpRTiziwFYr47W+X
	 HfkxmLPq6WHPeLdMzuUTzd8qFJn+ByZEf4rqnuv1pCweUyrwUL/+zibmxroongxvnIYjM
	 q7miysywRepqhwJCYL2oNbFeXPLwMdjipawGUA6bOd8xfh8q+1k7eTZQonuzYbpC0BWpN
	 EuD0AlQdXpFfz5AJTGhKLsBdFwwz17hHCI1pgnDHW9MdF8F23QPZaIoHAod7ZkoTyJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aliel.fr;
	spf=pass smtp.mailfrom=aliel.fr;
	dkim=pass header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=OTu8FLy4;
	arc=none smtp.remote-ip=65.21.61.41
Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC4606A323;
	Sun, 15 Nov 2026 22:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ECC4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=aliel.fr header.i=@aliel.fr header.a=rsa-sha256 header.s=courrier-s1 header.b=OTu8FLy4
Message-ID: <6c03c104-a86d-4ddf-b519-793a1da7151e@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1794782062;
	bh=r7WkL7hnoxRmrnQQzh+AibupBsiHGW98gVTJzxJfnBE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=OTu8FLy4omu5a28TNtfvdyeXHr9qsC+pa9ZIoHaUjUqSJPqpymtxlEysJrWDTdt1f
	 yD1Zs9/FAg7EGkDfPHy2+V/tYUIb/oJoTq6xek5oDKBJiOtIGzTjJjxoLOnQESjQvX
	 0BoyrPCX3vaHjppBJM6y54J8UcfaRivtPgmNBOQU=
Date: Sun, 15 Nov 2026 23:34:20 +0100
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH v4 3/3] arm64: dts: amlogic: a1-c3-s4-t7: Add bus clock to
 PWM controller nodes
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20261001-add-t7-sys-pwm-clk-v4-0-8ed2b1e0cdfe@aliel.fr>
 <20261001-add-t7-sys-pwm-clk-v4-3-8ed2b1e0cdfe@aliel.fr>
 <CAFBinCCf2x3Ear_iOg9=KYXd5jbvAh2LdQb3uOME=Lry8Wm4HA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFBinCCf2x3Ear_iOg9=KYXd5jbvAh2LdQb3uOME=Lry8Wm4HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/15/26 23:20, Martin Blumenstingl wrote:
> On Thu, Oct 1, 2026 at 6:56 PM Ronald Claveau via B4 Relay
> <devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>>
>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> Describe the system clock of each PWM controller as a third clock,
>> and add the clock-names property expected by the updated binding:
>> "channel-a", "channel-b" and "bus".
>>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
>> ---
>>  arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 28 +++++++++++++++++++++-------
>>  arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 28 +++++++++++++++++++++-------
>>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi   | 12 +++++++++---
>>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi   | 20 +++++++++++++++-----
> note: a single patch per SoC is easier for me to review but we don't
> have a strict rule.

Thanks for your feedback, I will split them next time if I have a
similar one.

-- 
Best regards,
Ronald
