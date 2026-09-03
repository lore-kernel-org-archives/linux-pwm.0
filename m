Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6C650C299
	for <linux-pwm@vger.kernel.org>; Thu,  3 Sep 2026 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466320; cv=none; b=i1x4jlUCu1esTmO1vqa7nZ/8r2fRNJcYO9wS/tvpYNfs9QnIdt0l5l2oK3nPf2WlP+Vsa3m9xIjqiQhMp1zy6Hebs6eIxZceqsYqsfeG602ZNb2/lFWaYkjl12tHbQPcfGC1/fCF/Q9n7rdWEX1pQ8u6FTJcohw6afIRk+dhDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466320; c=relaxed/simple;
	bh=2x3Fg80qrgO1JMvyRsoWryYQdJjCtQvS1HZl+tKOeMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TVvv5Q+uKWZILKBawz4yMXRlB5RWyBIR4wd6wg6ReKwN21BVbAmnfTEP6l+zAZNS7ZMfI1ETGr6FtrvCJSEHXn2dEUI7U7BRd5I+BOwo3fYUO/GgkYwXBQD466xgUXDv0dJuMyrygJMpTfnYiWW2DSu0/x2Wb0XwIbMnRd07X90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IxBApYry; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IxBApYry"
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-7466771f1caso96455137.0
        for <linux-pwm@vger.kernel.org>; Thu, 03 Sep 2026 13:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788466307; x=1789071107;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=130lNonfXTPzQR8jeTPo2lF/JuVtb2EqoFtB3DFAlj4=;
        b=F1gtF5Gl0sacwcnjjwPs7ZkxYwtXXYYU+IC7UhhlP0PQnj7hT3D3UgoUwM4Y0RVygW
         8BI+oayRj7LfxUQP9fAsz6S6zAzOlRLUay5wIX1nYLeN2biokS5216zLs3Hnj2DR1i0E
         0mLz4A/nSM/E67WV9VL/SCzRCsKMamlPGehnHQ+y6LEa9jAqA1CBvRIZKWeYDsZ6jjT+
         anl0Rf0PD+xw8rxjp5C7y+AleA5tMjb68fsgmJ7f56+990Tiji9Ra39A0aeYezBAJ0dw
         V4YTQCwMD9cFalYs0FxRKCsOFfP0CI7d4kY4Xmh8KauDyQKvpKX7X9tWmlj+kGxL35D2
         3VSw==
X-Forwarded-Encrypted: i=1; AKwUvBzJu/NEk9N9/0TPr3fekYD9M/FfnUNdF0YZRoBT4AzjqVyy7S2IyOJpR/7J7gsWgJ5SQpGjJ0dO8V0=@vger.kernel.org
X-Gm-Message-State: AFuF++n7TG17Z6ZqwnBCYW5ovhYFXz6VSKNCO4FvdYhbP8DaSjpY8E0G
	V0bvNxZYBsAB8X/eTxXIHwTBIDz5lMnbCdRfbaomd0XPb0+/T8wZDvwYvz/nVD8dJlu8d43krnd
	SyjLrowRZ7u4rUIm8FyMbpsl80cHfRp3Q98lwCwaDqcuP4Ab2xU9esj3sF9D8Qg9QM9rel6eZAy
	ZYiPqMU8gnrYmCBmT6wsGDj68WVhI5ucufadk2E3KYaixdoQIsTnkBiVCJhlT7C+ZLQstktWjTN
	YQ7VcJKTT1RDn22zIVD
X-Gm-Gg: AYBFou2+v73Mt3sOmH6OM2rAym3MHX2jSquuhBMoR56HGUQOqLDGzRsQKaX38gC7+jg
	twXuHA4w+ODnjbMvaFQz9ERPmK4PBP8G9mMMjEC7zJJdcBVAJDWApZtl3GfqK7EHa+2z/Wigi9C
	sWDPcm7ltLZMMrp71pzUfn2WCGfMwYF2wptZBlxf4Ed3UCTOUl6zamw120Apre9jCVbpuSuHnMv
	A8zJ602tp6z4/h9hBzGt2LZOMzJltCge2hm/WeF2e4coDuAjQuGI/CRTteTfrIdOg4SdXjng5B/
	8Qghc04aapOHa6RWxlGC1533MC86jPuyvlAZAqO2P8791LecCTx1EWS2XJcr+WV1lygsEb5BI/z
	hAW/qjvVsu4j4wyEjLnblNmyN3kEjp1ehfXfOeLBuFLX3GQzEq7BAnzIqL5+AcgIpXARnMcU5rI
	bGjkCJWsecOp52qETQCZhLjVWEE5SUVdkBHxZB3dGx
X-Received: by 2002:a05:6102:38c7:b0:777:4e99:6f84 with SMTP id ada2fe7eead31-78a4a727bccmr84286137.1.1788466307172;
        Thu, 03 Sep 2026 13:11:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-9808eb912f0sm59086241.1.2026.09.03.13.11.46
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 13:11:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e5fc4c7e9so26036685a.3
        for <linux-pwm@vger.kernel.org>; Thu, 03 Sep 2026 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788466306; x=1789071106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=130lNonfXTPzQR8jeTPo2lF/JuVtb2EqoFtB3DFAlj4=;
        b=IxBApYrySYMAETAe4+Bm9eRkwGYZUDu5bngMYt2j2f0brZS3VcQ/g16THiJQwlEQdv
         7+Qbdee0eqAL7VuQba7nbAFsOls2FZVkefB9JBe6VlTE/mYeNcKYfhvL9u/zHU00GfMv
         zmbw2M75xkyD2sJbzp4q7F7yn6x/97rwicGrM=
X-Forwarded-Encrypted: i=1; AKwUvBxTWEUDdPhMrto4eY8YAjruDRr2wWavMzuqyEj3yNQBLQfvzocsqloGi8L8ZsCwSVWuoBV7ouA7a/o=@vger.kernel.org
X-Received: by 2002:a05:620a:4887:b0:939:6de9:208c with SMTP id af79cd13be357-93980586029mr97446985a.49.1788466306368;
        Thu, 03 Sep 2026 13:11:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4887:b0:939:6de9:208c with SMTP id af79cd13be357-93980586029mr97442185a.49.1788466305792;
        Thu, 03 Sep 2026 13:11:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9ee9fbsm51700885a.1.2026.09.03.13.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 13:11:45 -0700 (PDT)
Message-ID: <be3aac0c-3475-4f48-aaef-765aadcc6b75@broadcom.com>
Date: Thu, 3 Sep 2026 13:11:41 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] Add RP1 PWM controller support
To: Andrea della Porta <andrea.porta@suse.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Naushir Patuck <naush@raspberrypi.com>,
 Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com,
 Sean Young <sean@mess.org>, Julian Braha <julianbraha@gmail.com>
References: <cover.1784539788.git.andrea.porta@suse.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <cover.1784539788.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 7/20/26 02:44, Andrea della Porta wrote:
> This patchset adds support for the PWM controller found on the
> Raspberry Pi RP1 southbridge. This is necessary to operate the
> cooling fan connected to one of the PWM channels.
> 
> The tachometer pin for the fan speed is managed by the firmware
> running on the RP1's M-core. It uses the PHASE2 register
> to report the RPM, which is then exported by this driver via
> syscon registers. A subsequent patch will add a new device
> and driver to read the RPM and export this value via hwmon.
>   
> Subsequent patches will also add the CPU thermal zone, which
> acts as a consumer of the PWM device.
> 
> Best regards,
> Andrea

Uwe, how do we go about applying these patches? Do you want to take 
patch #2 and I take patches #1 and #3 through the Broadcom ARM SoC tree(s)?
-- 
Florian
