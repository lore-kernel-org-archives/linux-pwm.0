Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794778811;
	b=GXmZ8elDZ8sXOviCHpSs0vR6kAveDZVkCdqnOLhVopueaCr+Qz5XFeAVm562/fJTgAsY
	 Vx68rtIRJZKv1Raqj0ExxR01oPZ6sgClEFq1qp41BwME0hF4hkTvSV95BgdHgo45R3DRR
	 MHMXTPKhlDfY6I8e94EIeeLNr/oE9HmXMtPrp0TmV2znpdW4n9IEuqWVX8dK0hvlRlzh8
	 an9clMQ0tw7fxCHhhWMwo5P1nnRN5zEzUuhLzfHoM2ZQiVgb373GRvzdcpBLq63fO3B6R
	 Mq80udtCyZMsYGaJxeE4qcH4khKHl7v3Oy8o/eI2HhQJwywJnpELDHVH6GGFRi8bLAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778811;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=KVX7vPJ9OTeTzfoMFASmwz/gzFZvz1nh0dPEPAyIr0I=;
	b=UPBw6M7RxMU3B1Fhx3LFNOHdFY7dFx2KWWaCR/Cv63EkSPThlwD2v2na7F/r2nNjqVxc
	 3y29AqH2CxvMfq+oSzEYazNYFwtjzeIN9dAHhDbdBYHCcU8GkrXxSHwMEc0cB5DGMxZsV
	 rXXAU8REytL/H5igthW5+0FHOCzFUhCBKjt+dG9bIdHpPFzykV7WGAczXURq+QchbwOxE
	 9msMwzU5J7b5ykJIDQQ5I1gGqUkqX0xk2gfNLkjkFWqrQSPgboJOciVSbpI5ZZcBSeNQu
	 A34Rv9lcSM4u2HVpQ+Hknjn6JhpHXNV4pSkKr+Kf7jjVWzV2Uj8Vt3ZHiiQouuo6/YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=YxtgJo2W;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D798606A323
	for <linux-pwm@vger.kernel.org>; Sun, 15 Nov 2026 21:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D798606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=YxtgJo2W
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id SJuuxIOzZ4vCDShxKx6Cjn; Sun, 15 Nov 2026 21:40:10 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id ShxJx56fn3nNNShxKxU6Nz; Sun, 15 Nov 2026 21:40:10 +0000
X-Authority-Analysis: v=2.4 cv=TuLmhCXh c=1 sm=1 tr=0 ts=6afa26ba
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10
 a=T8OswTi7en7Lat6lzKAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=KVX7vPJ9OTeTzfoMFASmwz/gzFZvz1nh0dPEPAyIr0I=; b=YxtgJo2WD6n0
	WmJugJPeVh5UlVsUmIS8e5Uyd3ctxtWEj5FuNKBl6gdX2sFInUqR3GphGv5cXNZ88vWiD3QE5gs5Z
	zSQqvxcG3YVBlpPgUch8bEShrjW7PeCAYfSAhQpT6JNlZbPLe69eVO1LzFNWtoYvzZSe1hoTv5Eww
	rAKxglVx4fEdEbGv1IUMhq42k22kHuPkoh3KUy/0hrHLq2N6ZohmfO2wIf+H3z3sjP9JpedudAF4f
	6AuyWAnDp82UyMlhSQ9NERocloE+PRFwt3zCNbaSWjTmnwIsfkVBDeROSkwKVO4Znb8+SYuWRb5wF
	BqVeYesa5vS1sVrvvIqKuA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:50662)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xShxJ-00000000Je9-288q;
	Mon, 16 Nov 2026 03:10:09 +0530
Message-ID: <62350363-b796-4637-a102-c668037bbbdd@roeck-us.net>
Date: Sun, 15 Nov 2026 13:40:08 -0800
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
Subject: Re: [PATCH 2/4] hwmon: (adt7475) Convert to
 hwmon_device_register_with_info()
To: =?UTF-8?Q?Dav=C3=AD=C3=B0_Steinn_Geirsson?= <david@dsg.is>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261114004110.328050-1-david@dsg.is>
 <20261114004110.328050-3-david@dsg.is>
 <d28f392e-82ea-44d6-83e5-9593b341a722@roeck-us.net> <avm-tbgWgTJNFTBj@dsg.is>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <avm-tbgWgTJNFTBj@dsg.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xShxJ-00000000Je9-288q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:50662
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 12
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBL9Q19/3DTydYOo52Eg79zv8XoNC9VcLl5hXBJ7Sf9hDfHVYMBnCeqnkxND8qE1SFuSvfy1Gtf19wqjD625WvliuPEH9/bVOu9ck+Ak2HGX5aDaNKpJ
 7hP7YJbRFqqqKkePGXXxF6fybgiZzR5GdZhf45oyneRbVAhXFkhu2t8FIHLbe5ji1nXI6TGSbcPunADf8p0t2BGy1yqDlBiXFTK86ZK3Gp3SO8/54gRPWLUM

On 11/15/26 06:16, Davíð Steinn Geirsson wrote:
> On Fri, Nov 13, 2026 at 10:07:53PM -0800, Guenter Roeck wrote:
>> On 11/13/26 16:41, Davíð Steinn Geirsson wrote:
>>> Convert the driver from hwmon_device_register_with_groups() to
>>> hwmon_device_register_with_info(). The standard voltage, temperature,
>>> fan and PWM attributes move to hwmon_ops. The chip-specific attributes
>>> stay driver-defined and are passed as extra groups: the automatic fan
>>> control points, temperature smoothing, PWM stall disable,
>>> pwm_use_point2_pwm_at_crit and the VID attributes.
>>>
>>> The driver keeps data->lock, although the hwmon core serialises the
>>> hwmon_ops callbacks. The attributes in the extra groups run outside that
>>> serialisation, and they share the register cache and its periodic update
>>> with the hwmon_ops callbacks. They do not take hwmon_lock() instead, to
>>> keep this conversion free of locking changes.
>>>
>>
>> I disagree here. If you don't want to change the locks to use the hwmon
>> subsystem lock in this patch, add another patch to change the code to
>> use it. The subsystem lock was not introduced to be ignored.
> 
> Understood. I did notice one issue while planning that change. Patch 4
> makes the chip a PWM provider, so its callbacks will also need the
> lock. If the consumer is pwm-fan, then when userspace writes pwm-fan's
> pwm attribute, the hwmon core holds pwm-fan's lock. pwm-fan then calls
> into the PWM core, which calls into adt7475, which then needs to take
> its own hwmon lock:
> 
>    hwmon_attr_store()              takes pwm-fan's hwmon lock
>      pwm_fan_write()
>        pwm_apply_might_sleep()
>          adt7475_pwm_write_waveform()
>            hwmon_lock()            takes adt7475's hwmon lock
> 
> As far as I can tell no driver does this today. adt7470 and
> aspeed-g6-pwm-tach are the other PWM providers I found in drivers/hwmon,
> and neither takes the subsystem lock in its PWM callbacks.
> 

Ah, the usual "someone else does (or does not) do it".

> I haven't written any code for this yet, so this is based on my read
> of the current code only. If correct, I think this would need a hwmon
> core change to give each hwmon device its own lockdep class.
> 

Hmm, if that is true (I'd like to see a lockddep warning), that will
need to be fixed anyway. The situation above will be more common with the
pwm subsystem maintainer pushing for that kind of architecture, so it will
need to be fixed. Introducing / maintaining another layer of locks is not
the solution.

Anyway, you want to add the complexity of getting the pwm subsystem and
the pwm-fan driver involved, even though this could as well be handled
in the adt7475 driver, so you'll have to suffer the consequences.

Thanks,
Guenter

> I'm not quite confident enough in my understanding of the core to
> commit to implementing such a change. But I'd appreciate your thoughts
> on this.
> 
>>
>> Thanks,
>> Guenter
>>
> 
> Thanks again,
> Davíð

