Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9971552FD
	for <linux-pwm@vger.kernel.org>; Sat, 14 Mar 2026 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773505195; cv=none; b=sTPBQe47KnR8XZqkHAZ2xE54jGvWwpVPOOX9Y5+TFqhbF/30DkM7l5AVFAa+qDxrzrjmBsFx41/nUZ4LdwRbVypkR92HZWNT0Nqs3JbFK3wIHk5IsfLE/GKEIYWRBGp1SEum6DOS4RommNSXiT0X6ML/ILWeTGzZ72x3rZwjacg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773505195; c=relaxed/simple;
	bh=KBkmFspCBI5UcLEf1cRd//2zKNdLHfEi9/AjCUQ/XiQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gDfm7t9vuQUsChyVH5KkihJarOdmwt8EJqtMH4fZxhwKlAd0He4Y8ALw8y3Zz3yaHGm8JbTLHirb8kY/K1ido+Y+gSAuYObJeQtMyTBRmkVO7FskVQNtCPW1f+ayZaD1szt36VjokoPeeFDFXuQwyHL/kT0fnUhissaYoBco8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UTlE6CIa; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UTlE6CIa"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-417c34b0509so1134981fac.1
        for <linux-pwm@vger.kernel.org>; Sat, 14 Mar 2026 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773505193; x=1774109993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KBkmFspCBI5UcLEf1cRd//2zKNdLHfEi9/AjCUQ/XiQ=;
        b=UTlE6CIakS2eeEyYdefN9JLGIAeYhImg5giLVCU1Jwn1SkdIs2yf9jTYEC3DucLtNP
         +4CtMvlqRY05xeMY9671JeIYMAHlL9UnjTq04Xw6NGdprq0U9qR1bXZKQg6Eu+sLf2/D
         HsD+apRTHc11ijvEOk3MfRcpkJTDnQAsaVUsMID6lu4qUm+8wc3KW3HfAjaWNiRrdM0C
         AoLf5KyL59/iBXG8HiwayLfUHaST8neln7L9cZvg5jExoNUkjR5j27PQmejhHLJXScil
         +vO2pfiAg3VdCKMVkDQveenO4TZq9FoBA/pi6WKthvseITlnsALJrCQQjdtTbBMz/Yty
         ukUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773505193; x=1774109993;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBkmFspCBI5UcLEf1cRd//2zKNdLHfEi9/AjCUQ/XiQ=;
        b=HM448UKYIfDoKUxgDhN/Jsylfe3mQLKlhKBUdZNBXo3K0Q3CcuXcczpMEMD11KgEZL
         J1wpmq/PjgAkLNqszlOn51ZyBATcWERpd7Lhzi771gzhH7vVgWt/8/xxKOOUqLb6z9SG
         EQg3/PqZs1WbTrUsaUdoKb6LrtHTGjMymIQZdUAcI6ucKq+CM2GWufK2Lvls3baIvm5g
         GKxWTb1Zz1EaD3WkG+W2fp6MCQTcy5YptKj163Rqq4iIG9t3Rqmdt+tx9w125DkGGh+H
         3QyVU+W47PgTDy2g3ag5WJvp5c7S8KLc6p9ysrV7Nj+wThYyuiKEtRRHOgM3TwASkM3w
         5KTA==
X-Forwarded-Encrypted: i=1; AJvYcCWBjTL8lCixXGCNvqhBCJDj2y1Flqbc7eo157q/vS/EW5MxL7oifmETMb6vefEeWWDZ+SE4ccKbyMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cTlq4nCPeRUq0doC5SlntV3rgSNSauCGsPYsgLdj7lfRggaP
	mHMSHyAhNBOKAtqTY4bCWMmOnxm2ahyAvoocnaAmCNuHzwcaeASJOPOpB24b5BVdiRo=
X-Gm-Gg: ATEYQzxgfK2E1TinW0GBY+3zdJ5lMxVgiAzMXNrJFVwQxAVwXfMcroU3zWAiZiR3jOF
	+gieaCXiYEcZuAm5IZWn88GLfjNMfBTJ/U8v1mEIKAeFwURGsWi275XSHgNmKfzzBsttoZ4E7Hz
	50Ynlc0BpTFO7Dh8dNgqrt8dJwhHQgfG5VQkyAPprdOrToCXoDC60ZJPpza3UoBNv1dtcJkcvHK
	2QH//7lrLm5dWdCTS+dR/SO9kQo18ZRVgP97Kl2R1eFiZ98kUHutmOlffxwn4J7gA5CTgXOhA52
	92WASdKhoQorwHsyKiIgrYTiiJEyDXvRyb2/dtj5ss9HCVeS9XVX3Zp0wc5Gi2hj8HleTabPO2o
	QzNSPjJ2Ud+yB5jTSmBF5vN/7Vuj+SoEyusujyPODWF+VCWx4fAEJNOaKkg2Lp1wWvvYTcZHRzc
	JR50GccYHkvMH9h2s3LFqnr1K+iK2zs8uRTQyqeYMzhanq0IZ+QRj331NqERe8M8I8+hN0G895O
	A==
X-Received: by 2002:a05:6870:510d:b0:417:1165:cf2e with SMTP id 586e51a60fabf-417b917197amr4017421fac.6.1773505192866;
        Sat, 14 Mar 2026 09:19:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm11940193fac.16.2026.03.14.09.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 09:19:52 -0700 (PDT)
Message-ID: <c158a12d-4855-40e7-9581-8078be4237fa@baylibre.com>
Date: Sat, 14 Mar 2026 11:19:51 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
From: David Lechner <dlechner@baylibre.com>
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
 <a1824f39-3925-4e94-ac98-52dcdfbaa0d2@baylibre.com>
Content-Language: en-US
In-Reply-To: <a1824f39-3925-4e94-ac98-52dcdfbaa0d2@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 10:29 AM, David Lechner wrote:
> On 3/13/26 5:07 AM, Radu Sabau via B4 Relay wrote:
>> From: Radu Sabau <radu.sabau@analog.com>
>>
>> Add DT bindings for the Analog Devices AD4691 family of multichannel
>> SAR ADCs (AD4691, AD4692, AD4693, AD4694).
>>

...

>> +
>> +properties:

More properties we can add: gpio-controller and #gpio-cells

It doesn't matter if the driver implements it or not. We want the
bindings to be as complete as possible and we know these are the
correct properties for ADCs with GPIOs.


