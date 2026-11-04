Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832990;
	b=49dJX4bPU7fGOJ9osvA6Gzt9ULnYcOmWYqOGYgp35JMbO5tkA57nYi4/LYCv92pse68Q
	 EyOpCXfmN8GnrJaaE1/uQGFOGQnQJDOMGr04IFIuG6IEAkfo4kcl8uNQjYfv3HbsAQ4gU
	 K6I+8JalRbeSDS7606n4hcrSuYAiAIbUS8y890QC0qBhCZo/61oDM0W8wFRtlh260n1TC
	 Zwrc1i+61yg4/SY4u2yzdX3IfjAnBJe4inS6rYRSEkZuF8d4qIA5x8RcsEWdNIAQm0QzK
	 FbpA9CWfTqyE2xfbwowFVGEJURwRsL16sJ8ThT7S681mTsn8RIL5hS7oH3p07qSEZQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832990;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=BVSlivO0NT5LNZI1ueIGCNvTYScZ1EWmEWcTYGB4ijY=;
	b=F/OTYsX6GDn5UfVxAP7QEEV8perjHsRfUcMjtH/F4e0kklrHsuXax/6dF/n+bVM3sWX5
	 0Rh3bzYghkA4NpS7iTxRhMoTQ03lhBonUkXlTPiv2epbBULk7G3i0ev6kQknZAr6mYJzq
	 Kj2786GTtRY+1wvRKltiyzM5scGEkUbiOKAsauOhSGXI51YCFZyJU5ntSDuvvF8Ndo87i
	 /MiRg0tFx96Q21tHMHGe/KDZOCx4OIF+jPit7QAWqXlF4mNmumk1E1+u9fq8rfg+EbeFI
	 E2Bsc1lkAxQiB5Fc5SmOTUaTEm1MxsHgZQ5zllZ7ESFZoZ11TFe0Bur/2wz8dZ+YXBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=k3wfvMt4;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF73E606A32D
	for <linux-pwm@vger.kernel.org>; Wed,  4 Nov 2026 22:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF73E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=k3wfvMt4
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id OZeuxXFGOVK9UOju9xJFyg; Wed, 04 Nov 2026 22:56:29 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Oju8xsr2GxqjjOju9xflGC; Wed, 04 Nov 2026 22:56:29 +0000
X-Authority-Analysis: v=2.4 cv=bZxrUPPB c=1 sm=1 tr=0 ts=6aebb81d
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=iox4zFpeAAAA:8 a=A5ctjimnlw7kqC9GiE4A:9 a=QEXdDO2ut3YA:10 a=LP3-5Lh9zdkA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=BVSlivO0NT5LNZI1ueIGCNvTYScZ1EWmEWcTYGB4ijY=; b=k3wfvMt43HLH
	o5IG+l01Z2G80GAZzp/PNoN/sIzKUSjCy4c4j0ca8xEsdSXfoydWJVjhMvt9ib1gkXxGnRuKR/xZY
	f/h5zhJuv8K4RfJRImTi68GLumWVPTGbK1gzcQx4UbxOlYHOqHngO09zT5G9Er9S54vxr1PH2v4z1
	v0a8EeYu9jTvOgvOjKZmNddYvfwICDLgMo+cEbFY+jobEvAT1F8SWk7XqSeIMe5KsifMege2KGx8f
	eU9xwGE8gA0ITVUtdDBbpQzbSI+tH9WGsiIks6bNznPpxnDsA/ZbkEtEmXLcT9gKUphc3VV5Dbw/u
	wx3owxMD58aIMaf7ay8wrQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54826)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOju5-00000001O41-43MB;
	Thu, 05 Nov 2026 04:26:26 +0530
Message-ID: <ae9a4df9-b1f2-4f00-ab86-d9cf8d9bc387@roeck-us.net>
Date: Wed, 4 Nov 2026 14:56:22 -0800
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
Subject: Re: [PATCH RFC 0/4] hwmon: Add fan tachometer support for Raspberry
 Pi RP1
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Gary Guo <gary@garyguo.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Gregor Herburger <gregor.herburger@linutronix.de>,
 Stanimir Varbanov <svarbanov@suse.de>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1792748690.git.andrea.porta@suse.com>
 <7df58d42-517c-4936-88b0-9d044d30882c@roeck-us.net>
 <auBzvB8TsvIK8Hik@apocalypse>
 <53a4b4bb-271c-4d2d-a9e4-cec4e0ce214b@roeck-us.net>
 <DMFPE71J8205.3FZKD5BKW3U7C@garyguo.net>
 <b02b4f0b-ad2c-453a-b69c-a0865a333d62@roeck-us.net>
 <auIotAwnOWKNApjp@apocalypse> <aus2Ra_sLySMZU1i@apocalypse>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <aus2Ra_sLySMZU1i@apocalypse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xOju5-00000001O41-43MB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54826
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 18
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFiUS7xm4SCXTtbCe9bqjg/Z6fAbSzwxeMyhHKtMtkpsI8llVlJTB4E5Wnb39GRyjDjUNktCfNInaXtmV5lG0qgJJZ5J4kVFFIl/DjdJQbn45n1JTa8s
 okdCoEH6JHZfhgEWizksjLLOySaJlxEUpAv0JXn96Yfw55d9Z6Zg5eqvgSNm2Fm292RFFmM1j/SsqQOptr+xiT58x41WE913hVv/+XvqTY5vKwp+bTMXG+vG

On 11/4/26 05:42, Andrea della Porta wrote:
> Hi,
> 
> On 17:54 Wed 28 Oct     , Andrea della Porta wrote:
>> On 09:13 Tue 27 Oct     , Guenter Roeck wrote:
>>> On Tue, Oct 27, 2026 at 10:51:15PM +0800, Gary Guo wrote:
>>>> On Tue Oct 27, 2026 at 9:48 PM CST, Guenter Roeck wrote:
>>>>> On Tue, Oct 27, 2026 at 10:49:48AM +0100, Andrea della Porta wrote:
>>>>>> Hi Guenter,
>>>>>>
>>>>>> Yes, I also proposed that in the cover letter because auxbus seems also a viable
>>>>>> solution.
>>>>>>
>>>>>> The current implementation is a consequence to the discussion about the companion
>>>>>> PWM driver, from here (and the revisions that followed):
>>>>>>
>>>>>> https://lore.kernel.org/all/cover.1775223441.git.andrea.porta@suse.com/
>>>>>>
>>>>>> To give a short and hopefully coherent view of the decisions, here's a breakdown:
>>>>>>
>>>>>> - first proposal: PWM driver + fan hwmon (to read the RPM), all in the same driver
>>>>>>
>>>>>> - V2: Uwe preferred to split the PWM driver from the hwmon one, so the hwmon was
>>>>>>    dropped from teh PWM driver in favor of a future (fan) driver. To accomplish this,
>>>>>>    I moved from readl/writel to regmap + syscon.
>>>>>>
>>>>>> - V8: Gary proposed to export a function to read the fan RPM as a viable
>>>>>>    solution. As a result, the regmap/syscon was dropped as it was no longer needed
>>>>>>    and the function has been exported from the PWM driver
>>>>>>
>>>>>> - new patchset for fan driver: the now independent hwmon moodle just call the
>>>>>>    exported function from thw PWM driver.
>>>>>>
>>>>>> If the auxiliary bus is indeed the preferred approach, I'd like to ensure we are
>>>>>> all aligned, as this would also require refactoring the PWM driver.
>>>>>>
>>>>>
>>>>> Let's say it that way: If you don't want to implement the auxiliary driver,
>>>>> and you insist using the exported function, I would prefer for you to go back
>>>>> to the first solution. The one thing I really dislike is conceptually broken
>>>>> code, and I consider the current approach broken. Your call, but the one thing
>>>>> I won't accept is the code with the exported function.
>>>>
>>>> I agree on the auxiliary driver part. However, I don't think EXPORT_SYMBOL_NS is
>>>> an issue, and regmap is not the right fit here:
>>>>
>>>> - Previous version of the PWM1 patch series publish regmap using
>>>>    of_syscon_register_regmap, but this cannot be undone -- which needs to happen
>>>>    on PWM device unbind (the RP1 PWM device is itself platform device, but RP1
>>>>    chip itself is PCIe device which must be removable).
>>>>
>>>> - The tachometer register is not its own separate register, but rather (re)using
>>>>    the phase control register. The phase control is not implemented in the RP1
>>>>    PWM driver on the list yet, so this is currently a simple register read -- I
>>>>    can see that RP1 PWM driver need to take special care to about the tachometer
>>>>    reading if the phase control is implemented.
>>>>
>>>>    For the two reasons above, I think the way that tachometer is read should
>>>>    really be an implementation detail of the PWM driver and not for the hwmon
>>>>    driver to worry about, so I suggested using EXPORT_SYMBOL_NS.
>>>>
>>>> - EXPORT_SYMBOL_NS is the documented way for exposing functionality from parent
>>>>    device to auxiliary drivers: https://docs.kernel.org/driver-api/auxiliary_bus.html
>>>>
>>>
>>> Let's agree to disagree, and keep the code in the pwm subsystem.
>>
>> And auxiliary bus it will be. I propose the following:
>>
>> - drivers/pwm/pwm-rp1.c: create an auxiliary device for the fan. The function to read
>>    the RPM will not be exported, but a function pointer will be passed through the
>>    private data to the fan driver. No need for regmap. To be taken by Uwe.
>>
>> - drivers/hwmon/rp1-hwmon.c: The auxiliary driver is probed against the device registered
>>    by the pwm driver. No imported function. To be taken by Guenter.
>>
>> In this way, we decouple the two drivers and we leverage the auxiliary bus paradigm.
>> Also, no DT node needed for the fan.
>>
>> Do we all agree on this approach?
> 
> A gentle reminder about this inquiry. Before refactoring both the PWM and the fan
> driver I'd like to be sure that the proposed approach is at least acceptable.
> 

This is just as bad as the exported symbol, as it creates a cross-module dependency
which I would strongly prefer to avoid. Given that this is actually suggested
in the guidance for auxiliary drivers (shiver), lets just keep the EXPORT_SYMBOL_NS
approach after all.

Guenter

