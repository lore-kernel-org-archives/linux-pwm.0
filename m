Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793031871;
	b=nOWXZG3VMjv6c7bVGfKcDG83ZysfN7dwNStKjY9qKvnKVn47bbllbsSsM1GPxCzqbKiu
	 9N+pEM1MpJA0FkOcTJUwRIJCzMiD5aXvrY8DBvaWhFZtbdiBPvu9go2BErOGRN8QQcM1Y
	 UdW2x15g+ZqfCfHGBTV89q6OoljVcZQZwjdU5AFSUWACI60z/Me0sZn6p1lMxvZk4Bd/4
	 S+JW6yEql2cc/+QHJcz+Gi7GFb80w5rgKFWMos69apDB1Qa8j/sIajAoQQxWKwvpmR4VO
	 kjMIqk6SAj636gq7vi9pQ7qzOlfYyuHPeifGK8QXPebs/DwjIrRCwr2gjJuLDQDX05Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793031871;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=DajPTuRGlwcD4J4PQkOl0tYDfpyADr1jZ7qC3/V/b3M=;
	b=wtSaUUxN4xifLI4DAO16whdvdGmRPryv/vM/eBJ0XHU4IyyxRAniCVZk4g8NP9UddFUD
	 RTvE32VZKJQFIBkXiaxGChx9tJn+0Fk+gwCWv35kkIclQxUxC2T57XKhHK0H6mtRhp4OP
	 QyCVr5E7O9i2qxkTTz0dvZ2QgTEnLAVd+sy4c97yCKOp82uYs8rxPVGJSCO5lGXRsz/Vu
	 ZZDYlB6VTkDhJEXVMsY7xXDqA/ovmSBfr5Q7/0bupZyBYnmKKO4pdu5uJzH5NFouuO85a
	 dQv3FtcpoOSF1IV2BOTj7DAbOc8XPCCNZYXHmPi2YUsMPcmjIIkhlBBxsRNVamsVebA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=lsNrZREB;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476BE606A329
	for <linux-pwm@vger.kernel.org>; Mon, 26 Oct 2026 16:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 476BE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=lsNrZREB
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id LNFExjSJjusRSLNUmxsi8U; Mon, 26 Oct 2026 16:24:24 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LNUlxKZ2o7CfWLNUmxj5Tc; Mon, 26 Oct 2026 16:24:24 +0000
X-Authority-Analysis: v=2.4 cv=Z8HsHGRA c=1 sm=1 tr=0 ts=6adf7eb8
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=iox4zFpeAAAA:8 a=tt6zo4tp7eAlrjPKee4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=DajPTuRGlwcD4J4PQkOl0tYDfpyADr1jZ7qC3/V/b3M=; b=lsNrZREBaNyV
	34I/2MbZZFS63thif2qT+LwMsLC5dLGoqiCLbUJia0eyD7/PVaTnwaZHHWBpIRHUpZ+kP/A9qlsnH
	LqSVDEQc4PwHDdqZElYdGktKtpvwrnoiWjROMvd4FIMmyEezANBlLwMHzae7YjSJjqa2NJ5umz4wc
	+NYwr866ZOiDKLpxuf7nDfNXJm6ykgXrQNvHi5lixAMBJC6/MC9cpSZc1vt4cFDy7cGaWf7O/RPLN
	UDkdRAa2PNjqUHhh3tLciDF5bwZZUKJjwIEzW3utdUXbkZoSkLtEUaSrtcIUnP+M2iPZOOkdGWCNC
	LOnjiQRDB+ichCBDvYCJDA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:55640)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLNUh-00000000J3G-11yk;
	Mon, 26 Oct 2026 21:54:19 +0530
Message-ID: <7df58d42-517c-4936-88b0-9d044d30882c@roeck-us.net>
Date: Mon, 26 Oct 2026 09:24:16 -0700
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
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
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
 Gary Guo <gary@garyguo.net>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1792748690.git.andrea.porta@suse.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <cover.1792748690.git.andrea.porta@suse.com>
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
X-Exim-ID: 1xLNUh-00000000J3G-11yk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:55640
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 15
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGXBBNiaq4ZUf4Yvx+/nyrCT4rOfzMzweHISG89Avl2U8dhdoum/HJqaU8VVs7S7akZ16OhGzzL+l/rfgSfFKpxoYsofHywdxekJvs2YM6UPi7jRXxkf
 gbIZSVcs8YcgoXmCirMDfv+0XvFR6BRK3Ow09HL3m2NBjWN1j9RR4AZmnw2xtGEpcKfKdXW4oDMyOhtAhBQs7j4fE9cEzvEnBT/HA4rmDnz9ewKsqU4zK7I5

On 10/23/26 03:15, Andrea della Porta wrote:
> Hi,
> 
> This patch series adds fan tachometer / RPM monitoring support for the
> Raspberry Pi RP1 southbridge found on the Raspberry Pi 5.
> Please note that the patchset in [1] is a prerequisite for this one.
> 
> On the Raspberry Pi RP1, the active cooling fan speed is controlled via
> the RP1 PWM controller. In addition to generating PWM signals, the RP1
> monitors fan tachometer pulses. The pulse measurement and RPM calculation
> are performed autonomously by the RP1's onboard Cortex-M microcontroller
> core, which periodically writes the computed RPM value directly into
> dedicated MMIO registers located within the RP1 PWM hardware block.
> 
> During earlier discussions, Uwe Kleine-König explicitly indicated a
> preference to keep the core PWM controller driver (drivers/pwm/pwm-rp1.c)
> focused strictly on PWM duties, rather than bloating it by registering an
> hwmon device directly from within the PWM driver (see [2]).
> 
> Because the Linux PWM subsystem currently lacks a generic framework or
> consumer API for reporting hardware-calculated tachometer readings, this
> series implements a standalone hwmon driver (rp1-fan) using the following
> structure:
> 
> -  The PWM driver exposes and exports rp1_pwm_read_tachometer() within a
>     dedicated symbol namespace ('RP1_PWM') to read the RPM value from
>     the MMIO block.
> -  A companion DT binding (raspberrypi,rp1-fan.yaml) introduces a vendor
>     property, 'raspberrypi,pwm-tachometer', to link the fan node to the
>     PWM controller node without overloading or abusing the standard 'pwms'
>     property.
> -  The rp1-fan hwmon driver parses this phandle, establishes a device link
>     for proper runtime and unbind dependency management, and registers the
>     standard hwmon 'fan1_input' sysfs attribute.
> 
> An alternative architectural approach to the DT phandle + exported helper
> method would be to model the tachometer as a child device using the
> auxiliary bus framework (drivers/base/auxiliary.c). In that model, the RP1
> PWM driver would instantiate an auxiliary device for the tachometer, and
> the hwmon driver would bind to that auxiliary bus device without requiring
> a separate DT node.
> 
> However, adopting the auxiliary bus would require a more significant
> rework and refactoring of the existing RP1 PWM driver.
> 
> I'd appreciate any feedback on whether the current companion driver with
> a dedicated DT property is acceptable, or if an auxiliary bus-based
> refactoring of the PWM driver is the preferred upstream path.
> 
> Patch Breakdown
> ---------------
> Patch 1: pwm: rp1: Export helper to read fan tachometer RPM
> Patch 2: dt-bindings: hwmon: Add Raspberry Pi RP1 fan binding
> Patch 3: hwmon: Add driver for Raspberry Pi RP1 fan tachometer

This seems conceptually wrong.

Have you considered implementing the hwmon driver as auxiliary driver
and accessing the register in question through regmap ?

> Patch 4: arm64: dts: broadcom: bcm2712-rpi-5-b: Add RP1 fan tachometer node
> 
> Thanks,
> Andrea
> 
> 
> LINKS:
> [1] - https://lore.kernel.org/all/cover.1790686331.git.andrea.porta@suse.com/
> [2] - https://lore.kernel.org/all/adLTwOTbkJ0VQXy6@monoceros/
> 
> Andrea della Porta (4):
>    pwm: rp1: Export helper to read fan tachometer RPM
>    dt-bindings: hwmon: Add Raspberry Pi RP1 fan binding
>    hwmon: Add driver for Raspberry Pi RP1 fan tachometer
>    arm64: dts: broadcom: bcm2712-rpi-5-b: Add RP1 fan tachometer node
> 
>   .../bindings/hwmon/raspberrypi,rp1-fan.yaml   |  39 +++++
>   Documentation/hwmon/index.rst                 |   1 +
>   Documentation/hwmon/rp1-fan.rst               |  41 ++++++
>   MAINTAINERS                                   |   1 +
>   .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |   5 +
>   drivers/hwmon/Kconfig                         |  11 ++
>   drivers/hwmon/Makefile                        |   1 +
>   drivers/hwmon/rp1-hwmon.c                     | 136 ++++++++++++++++++
>   drivers/pwm/pwm-rp1.c                         |  27 ++++

Either case, there is no such driver in mainline or linux-next.

Guenter

>   include/soc/bcm2835/raspberrypi-pwm-rp1.h     |  10 ++
>   10 files changed, 272 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-fan.yaml
>   create mode 100644 Documentation/hwmon/rp1-fan.rst
>   create mode 100644 drivers/hwmon/rp1-hwmon.c
>   create mode 100644 include/soc/bcm2835/raspberrypi-pwm-rp1.h
> 

