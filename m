Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794789710;
	b=2TM4VRlexhwlocedaGIIh0zPwlo8+mElJtRzb2h+w3YQR+axK+cePfOFhODY+Pfz/npp
	 18ACYWuFd7yVPJ6quFLDA2o4zviai4oTiKITj6fNYKympbdJ7mDVkk/b/Stlf6tds84La
	 mPHbuZoru5CQpCwDZLbgAxqKexXp2ffmn2ZegzmhKXLBg1C3tQHnz2wvGovNmirNGRw2a
	 0AG8xcyE+rxJg/Joky2ldrW2XEWH4ILZqOF7KvcCANLr1EsmJlS88ct3d3HZ9Fcw+j2+F
	 bGPLB9tas+8cfo7qIYZQRsFZKbi9lNFFAspVqbEzKWtwdIj72jQX4K9BuP7iuqhBWtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794789710;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=IsW7atzSQ2E7F85ASunl7GLsIyH64EFl27HfndOmRKU=;
	b=XjrUnKXCqV4hkh3fuozH3J6Ij3SoK72tBqq2ZmHsunpvZ2Dli8BlDjetww3Tc54St6bF
	 nodC9JgW7FgJQHgaUlVzeVJ9a93tQJgwHxQfCQJ03y+TTRzoYOEmBQIWEYMyiEDLL5FxN
	 t/Bnlga7bvt7auY9kF18jfEGJCShgSeLYV/VMtzqCvWgjSzhZK1eW9V6aHPITuYaM1Yua
	 QDVZtJtnaEjGuonmtkid+mVpHxsvEgNl5OtzY3t59F+H9QQIZkkdDSqbM2nu19GO5T7g+
	 g2Rwa4RL7L4WZAgFJWV7A49wYjBGV/8UNaxjC9bgrox7+ntaWs0qtdlL3bfcrxNYBOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=vnPowUs9;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51421606A323
	for <linux-pwm@vger.kernel.org>; Mon, 16 Nov 2026 00:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51421606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=vnPowUs9
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id SgMIxuPDWAR1iSkn8xUgEO; Mon, 16 Nov 2026 00:41:50 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Skn7x9eIl3nNNSkn7xYDL9; Mon, 16 Nov 2026 00:41:49 +0000
X-Authority-Analysis: v=2.4 cv=TuLmhCXh c=1 sm=1 tr=0 ts=6afa514d
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10
 a=ydwNUxKNuv6kypV7TxIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=IsW7atzSQ2E7F85ASunl7GLsIyH64EFl27HfndOmRKU=; b=vnPowUs9wTU8
	B79yjVoUVUrbx2/ujA8AXHNkPyruHCMpsIN3AKu+e1D871DV5GbIOdnwL/4mFDNJSFMohdL5VqVzY
	BV4POrSQfqkGW9qJXO2PM/V2GExnZrk90XLOjCPPLT0krp00lslks5TbB88BFFpdmfoD3378vQu7I
	wEH2GHOuAyxh2kzd4KpAbgOR+mX9uqNA/WGulFftKZTEqHiuotrJ9/IDzGR6tyAQK4TVFAG34P5Cf
	nyPUm0uBU0RLQD6ATW2DaTvnzk/c4N6jARp0O8R9v/gv4ACutw2pkbWM2t7D5tE6Xo80n/MDwRoU6
	DtlPAWNe9DX7nIe2I8VpYQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47236)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xSkn6-00000001htp-3vOy;
	Mon, 16 Nov 2026 06:11:49 +0530
Message-ID: <68615d41-eedf-4178-ac0f-8d9599f24e12@roeck-us.net>
Date: Sun, 15 Nov 2026 16:41:47 -0800
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
 <62350363-b796-4637-a102-c668037bbbdd@roeck-us.net> <avo1IWkXBQ2fHgKx@dsg.is>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <avo1IWkXBQ2fHgKx@dsg.is>
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
X-Exim-ID: 1xSkn6-00000001htp-3vOy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:47236
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 6
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGlZMtDrCRjLZC2C5RM8e5B7mneA9Q2yE9gtD5Wg85hMg4/24LGiaaU4gaXYgaWhfi6Qcsk76RjRqSHDxASottvD+LTOaznyzfPLmSv1dO8U580R8itH
 uNZq3zyAtjsSqHzMuoVu6h1h2u4mw4k4tBCbjmfip2O0ceh0qwFW2xbRN79JpAcu9LXxUPh1GGHhoePcCHOvZ8BL3l5OpAIIR4JcmloIuW9A5MLoI0RY4fiC

On 11/15/26 14:41, Davíð Steinn Geirsson wrote:
...
> Apologies if that's how it came off, that was not the intent. I
> understand your earlier guidance that new drivers need to use the hwmon
> subsystem lock for this kind of thing. The reason I mentioned those
> other drivers was to try to explain why I believe this is a novel issue
> other hwmon drivers have not hit before.
> 

The pwm maintainer (Wolfgang) insists that all chips with pwm output,
including fan controllers like this one, register with the pwm subsystem
as pwm controllers. I resisted that for a long time because I find that
it adds pointless complexity, but that time is gone. People now find
reasons, such as claiming that they want to connect LEDs instead of fans,
to those pwm outputs. This results in recursive calls into the hwmon
subsystem, for example if such a pwm output is indeed connected to a fan
and the pwm-fan driver is used to control it. Yes, this is novel. I never
imagined that this would ever be the case. That happens when new and
more complex use cases are introduced into a system.

...

> 
>>
>> Anyway, you want to add the complexity of getting the pwm subsystem and
>> the pwm-fan driver involved, even though this could as well be handled
>> in the adt7475 driver, so you'll have to suffer the consequences.
> 
> I have no attachment to this implementation, in truth I just expected an
> adt7475 driver registering cooling devices itself would be rejected. If

It appears that you had no problems finding examples for drivers not (or rather
not yet) using the hardware monitoring subsystem lock. Yet, it seems that you
had trouble finding hardware monitoring drivers which also register cooling
devices (besides pwm-fan). Here are some for reference.

$ git grep devm_thermal_of_child_cooling_device_register
amc6821.c:              return PTR_ERR_OR_ZERO(devm_thermal_of_child_cooling_device_register(dev,
aspeed-pwm-tacho.c:     cdev->tcdev = devm_thermal_of_child_cooling_device_register(dev, child,
emc2305.c:              devm_thermal_of_child_cooling_device_register(dev, fan_node,
gpio-fan.c:     fan_data->cdev = devm_thermal_of_child_cooling_device_register(dev, np,
max6650.c:              cooling_dev = devm_thermal_of_child_cooling_device_register(dev, dev->of_node,
npcm750-pwm-fan.c:      cdev->tcdev = devm_thermal_of_child_cooling_device_register(dev, child,
pwm-fan.c:              cdev = devm_thermal_of_child_cooling_device_register(dev, dev->of_node,
qnap-mcu-hwmon.c:               cdev = devm_thermal_of_child_cooling_device_register(dev, to_of_node(hwm->fan_node),
tc654.c:                cdev = devm_thermal_of_child_cooling_device_register(dev, dev->of_node,

Of those, amc6821, emc2305 and max6650, are quite similar to adt7475.

Anyway, I instructed my AI agent to look into the problem and fix it,
so I'll send a patch to fix the problem shortly.

Thanks,
Guenter

