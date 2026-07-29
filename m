Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9583DBD60
	for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2026 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356617; cv=none; b=tYfKkCXmFHDQD1TbDpCsxT5I0sG3cqqLzuCwt3Wnk4vzgpiH3wc5Vc3aBAD/dEo6wGj3qebbQWqi1MKxuUEtaQH3zGvCfBr/ZJbg4EnG0u9p/jzja/uvCL4ZvWOGvzylNCFNIF72a/vkmLZbhUYjcgXtosWUKl2aHV3/VdyVGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356617; c=relaxed/simple;
	bh=QsmgOTB0+XfW4IuMxTu+A2chFmz1GsdHM4/TOVX+xxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogpypGaypiz2WwMfkGJdOqYXgOMrhgqRWFJkc7TxJp5cNClIQNEX9xS1T2pYpjil2B908uPU5WdvP1weWSPVkA9vxjJDUujGNVY0F3JQk2FOZ8qCdb7hawVANg/3Gjr+7SXg9Dg42Eus+/0v7tTtze7qnUcxaj3F1Y5qBtghcGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUNqrcal; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUNqrcal"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso1079883a91.1
        for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2026 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785356614; x=1785961414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bH71fmWcaZmonfoK7tsPjNB22a63jGjEHObBS1Hv1i0=;
        b=mUNqrcalKwRTuc1DK9JfoWdINDQNXvf2R9PpmWxtzDuflK3AroWw923DGVkPQDaIv9
         hX2yM/UDYb68MV4JJ99ogmBosmhmNIrWyZwZ1wLk7LmtAVFlrp0ufU/hgkr4i4u/2j5V
         IVYvMkD2c3eSXjYobC4i6xjoMYC7c90CzuAgvckND9kezK0wmzy2HXPsYGdGej/MjA4o
         TTcCjscFF79GJ067stIjbUUgpOkBffe3T4oivy/WzJSJ0d4+etLzBDDVs/KuWkh0E2R/
         8/MP/mVCDe/P9goriiMBjjGN9DavCRCgmgjwOjGtaek4sItMZPLqrlugwV60CFb+YdLs
         OaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356614; x=1785961414;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bH71fmWcaZmonfoK7tsPjNB22a63jGjEHObBS1Hv1i0=;
        b=QDrHEn7kCF2kzt8eAnmabwcrNH5mJ77hUDmrh2qNQ3sqwKtRVWVCd4Jgh+NQ7I5ZuV
         FyJmDccMmp+kluciOdv6+gny1HJu+jTG5XYqWuWW+DsGDTgr786aX0XSqPtK6CzKIrYX
         oq0csmXImHTWBMBELG6RpBa6Me8HvaXx3l18dgDQ/FALxzY00NGOLqG6dLUtiB95ftru
         tzip1GVc/jBRlYfyAJcXBIO2tWNL2YmEgG8M0mGYJlhg36QjWsHLIh6lMvDpiKf8ULRu
         NbgCRLeHTMcbc/UdU42F0CaLi1ahzt0/7ExY5VR17WdBYDfH4SxGLB7cIwL50lYYSZYi
         L8Hg==
X-Forwarded-Encrypted: i=1; AHgh+RrvIATu0hfpDorOJTypmN9yR82Wl6uT+1t2SMwFKH0xq6jqgDGMHvQ4iq1wmWFcH/MMMUNL0p2BLcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2NpsF90htp9ZqpoMoBjyyEv91Ynk4C1MWJ0wXRTPdcsVB5cp6
	AD/XGw8rfPQLZj8NYSpdUxziKx6jrHS9I/k6rmJmH/NlYAbkawUJh077
X-Gm-Gg: AR+sD11UJAI4ygHlhbxPZRX8ENoegZBLDEBheYvhTGGZuBZjkrKtbpRS69SMT3EAzTP
	94gJU0arQKdsxW0fCAVyZbzwNR/zCVQCLwbJjoR0DoYVeTdr+OQ+vdjasJnBQ28Gw6bf2NOj9Wa
	WFd5tRWPz7W1rKhvwK/0eYj3dZcxFrR0iDZxLAoV+CsbWtYRnh2g85GarhJNjPC6k0dWlDOH72Y
	TIYq9mEL1u1XGnxv5BZhFLGWuSHkku/5fxjcn2VWj3mh4aJnhqa4i1gaUEb6ffUhboMP7ldmlhO
	JQjG7Bs/VWT+wNZBk7L2CUgawqHd+8266MycbVS1OoH6QiAwSRjAiJTqVoAgdj2gynG4zrXJ2+O
	8mOqlP6N3t0sk6ovy0VWgWtjshFk55JyJV92s1iHOerChzY+x05Ab5yU8BawQ/0jdmuEsdrKick
	O5DRt510tPgbtjBgW6W/P52ohvSKYUodWKTJwhCJfMTAPBN1Xq1dyUgBPszv3Kx0tD63KfRaffl
	7wvse9HG0UthoS6WAtdvEKA2r7xYJC7itiPgw==
X-Received: by 2002:a17:90b:3803:b0:381:6466:7160 with SMTP id 98e67ed59e1d1-38f99254a39mr301005a91.26.1785356614020;
        Wed, 29 Jul 2026 13:23:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72643a12sm19379339c88.5.2026.07.29.13.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 13:23:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d0625bd7-b5e0-4419-bcdd-9f7a5f8c38fa@roeck-us.net>
Date: Wed, 29 Jul 2026 13:23:31 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [hwmon-next PATCH v4 3/4] hwmon: (adt7470) Expose fan control via
 PWM framework
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Darrick J. Wong" <djwong@us.ibm.com>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20260729-adt7470_thermalzone-v4-0-c14039dfa0e6@gmail.com>
 <20260729-adt7470_thermalzone-v4-3-c14039dfa0e6@gmail.com>
 <12dfeaae-f806-4adc-95f1-97fe10ef748e@roeck-us.net>
 <amnoV4Vlxmc5QgVC@monoceros>
 <e535a9c5-28a5-470c-be21-95e1812e5e01@roeck-us.net>
 <CAJq09z5diKf9HpJ0B_7tyo2-2wPfojyG4pRY1qhRQ3fzx0Gr4A@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAJq09z5diKf9HpJ0B_7tyo2-2wPfojyG4pRY1qhRQ3fzx0Gr4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 12:05, Luiz Angelo Daros de Luca wrote:
> Hi Guenter, Uwe,
> 
> Thank you both for the detailed reviews. I hope I'll address all the
> points discussed in the next version.
> 
>>>> No, I won't accept this. It has to be either or. A pwm channel modeled as pwm
>>>> subsystem channel must not be visible via hwmon attributes.
>>>
>>> I didn't look in detail, but maybe my red line is a bit more lax. IMHO
>>> it's not OK to be able to modify a setting that results from pushing
>>> hwmon knobs using PWM operations or vice-versa. Switching between
>>> exclusive use at runtime is IMHO ok.
>>>
>> It is my call to make, and my call is either-or to avoid confusion.
> 
> Guenter, I agree and followed your strict "either-or" directive. If
> the device is bound via the PWM framework (i.e., #pwm-cells is present
> in the DT), the driver completely hides all legacy hwmon PWM
> attributes.
> 

Yes, that is what I am looking for, assuming it is per channel.
We do not want to unconditionally disable automatic fan control support
by the chip just because a single channel is used as generic PWM controller.

> One implementation detail: currently, the driver hides the hwmon
> attributes only if #pwm-cells is present and IS_REACHABLE(CONFIG_PWM)
> is true. If the DTS has #pwm-cells but the PWM framework is disabled
> in the kernel, it emits a dev_warn and falls back to exposing the
> hwmon attributes. Please let me know if you would prefer to
> unconditionally hide the hwmon attributes merely based on the presence
> of the DT property, regardless of the CONFIG_PWM state.
> 
No, that would be overkill.

Thanks,
Guenter

