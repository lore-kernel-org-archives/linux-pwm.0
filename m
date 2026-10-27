Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117615;
	b=3vO069ZN4FYc99bsuKg+0TxLpUOE/+6rT7CbrrRA1iAlFtIM/NeceKPN5ogD0fW995X5
	 0+DQhVmhJYQwlOTXVsqc2gS5T7OwWYOxYXTe2q2yS46IRTy0uCAgXYdp3ONR8HPEXHVUf
	 m0jpW1oGrN9D6bcdha+Pd8+4R7BOL5Xqu+CIrvXwcWxV1LuxD698fDWkYZXBhhjXsHS5v
	 t/as/Dmd5jVVsbPVei8PUnoWgddia4iEZS6EroqmNgpjPOnnIRflI5dKavja/9E7iEhjI
	 d5uQbWVGGyrKv6YnIJj6reZFVJ+nXAP8kXfwBCXymsUno38Dv87WTrmsfgrtPLZz7CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117615;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=5G3ZmT86d3fe1rJiM6b5mr2ay0ue+O83AEJqLc41Pes=;
	b=M+DZDk9COHGqxc2XfcPI0jcx58TYRD21sE8JgWLEptOWY5UOubB5jleK8ONyLUY4oQ6B
	 beBFfZAhOP1HTOjKzOzRzIdSHsOdFRSK4Vs7L1+NeIgOsQMuCKeCS6zMSE1XxHVrpSmJr
	 xts+rmaTCzeNGTD0cGPejSIXqAARTKCxusPkADjCXgMfC0beEgaAZdyxmEcbPD+pdLO4c
	 CfLV1tejKZqfirXMxQAu11SwkUIUyUbPaEZjPj9JHx6iN5hB2TmTlAL2ml44XGbTGy8ph
	 n0RicBKJlOLTWwgeAnpMfF1Nb6PgX7SGBkCxq0b2qmIohvzPWa925X/khlu0pIHeITg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=0bRG5pWu;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE98606A321
	for <linux-pwm@vger.kernel.org>; Tue, 27 Oct 2026 16:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EE98606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=0bRG5pWu
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id LdyNxwpZ2v0ndLjnrxLaW7; Tue, 27 Oct 2026 16:13:35 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LjnpxlXWxCWbvLjnqxJkt6; Tue, 27 Oct 2026 16:13:34 +0000
X-Authority-Analysis: v=2.4 cv=bNEWIO+Z c=1 sm=1 tr=0 ts=6ae0cdae
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=iox4zFpeAAAA:8 a=lMUDpl8nYqh3M6R7ydkA:9 a=CjuIK1q_8ugA:10 a=LP3-5Lh9zdkA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5G3ZmT86d3fe1rJiM6b5mr2ay0ue+O83AEJqLc41Pes=; b=0bRG5pWuLiZXHXqJQvNggCWlNQ
	GbtulZEHDb8sReMmPpD9jeLOPqZQkvsmUB1QF/eaKJBgihsBywZ3ulNPnxshEjknN4c31xvSydrof
	G8UKnkf5xfgnI69nY3a4sNA9bFAtUL8L0JA58uLhKUpMYHBBJ0OrdJplBMt99zyuCp21tdFaUrvXc
	Rj/BTRRnkXIIxr7cfp1yIvTqmh6CwL7GsO4UOrGrFPKoB3lE61ZgXnJN1tKcwjo/RzpYUatrMH8pN
	s0ztAID6NGI3HShJw5b84D//CWybXdMw56O+bg8PoNsDOWiW4Y6p1JVP8bF+MAB+WQBG2bEK7fw3K
	OgN2UsKg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:37196 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLjnm-00000000huz-1JIR;
	Tue, 27 Oct 2026 21:43:30 +0530
Date: Tue, 27 Oct 2026 09:13:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Gary Guo <gary@garyguo.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Gregor Herburger <gregor.herburger@linutronix.de>,
	Stanimir Varbanov <svarbanov@suse.de>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH RFC 0/4] hwmon: Add fan tachometer support for Raspberry
 Pi RP1
Message-ID: <b02b4f0b-ad2c-453a-b69c-a0865a333d62@roeck-us.net>
References: <cover.1792748690.git.andrea.porta@suse.com>
 <7df58d42-517c-4936-88b0-9d044d30882c@roeck-us.net>
 <auBzvB8TsvIK8Hik@apocalypse>
 <53a4b4bb-271c-4d2d-a9e4-cec4e0ce214b@roeck-us.net>
 <DMFPE71J8205.3FZKD5BKW3U7C@garyguo.net>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMFPE71J8205.3FZKD5BKW3U7C@garyguo.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLjnm-00000000huz-1JIR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:37196
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 26
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNh4RTl6dWBGXKJchGshqWH1QVh8WtGeFBiet04m259jJ/hg0aChAnMEWutWIsVEtQKkMXXRXu2gDFxWW3ipelh/JykunBmlvDBN878GbtXVW4e2BDbl
 R1YS6RH3BNOhliCI2T+1zkrFS491+3LJzNvYY6Czp/4XIvYO9nuPyK7HzTFdQ1QAb1yZj5ApkA4DJ/wJljJBHFCjMjrtT3stbZ7Xb0dx7XZ3Hh5MsIDsYVd1

On Tue, Oct 27, 2026 at 10:51:15PM +0800, Gary Guo wrote:
> On Tue Oct 27, 2026 at 9:48 PM CST, Guenter Roeck wrote:
> > On Tue, Oct 27, 2026 at 10:49:48AM +0100, Andrea della Porta wrote:
> >> Hi Guenter,
> >> 
> >> Yes, I also proposed that in the cover letter because auxbus seems also a viable
> >> solution.
> >> 
> >> The current implementation is a consequence to the discussion about the companion
> >> PWM driver, from here (and the revisions that followed):
> >> 
> >> https://lore.kernel.org/all/cover.1775223441.git.andrea.porta@suse.com/
> >> 
> >> To give a short and hopefully coherent view of the decisions, here's a breakdown:
> >> 
> >> - first proposal: PWM driver + fan hwmon (to read the RPM), all in the same driver
> >> 
> >> - V2: Uwe preferred to split the PWM driver from the hwmon one, so the hwmon was
> >>   dropped from teh PWM driver in favor of a future (fan) driver. To accomplish this,
> >>   I moved from readl/writel to regmap + syscon.
> >> 
> >> - V8: Gary proposed to export a function to read the fan RPM as a viable
> >>   solution. As a result, the regmap/syscon was dropped as it was no longer needed
> >>   and the function has been exported from the PWM driver
> >> 
> >> - new patchset for fan driver: the now independent hwmon moodle just call the
> >>   exported function from thw PWM driver.
> >> 
> >> If the auxiliary bus is indeed the preferred approach, I'd like to ensure we are
> >> all aligned, as this would also require refactoring the PWM driver.
> >> 
> >
> > Let's say it that way: If you don't want to implement the auxiliary driver,
> > and you insist using the exported function, I would prefer for you to go back
> > to the first solution. The one thing I really dislike is conceptually broken
> > code, and I consider the current approach broken. Your call, but the one thing
> > I won't accept is the code with the exported function.
> 
> I agree on the auxiliary driver part. However, I don't think EXPORT_SYMBOL_NS is
> an issue, and regmap is not the right fit here:
> 
> - Previous version of the PWM1 patch series publish regmap using
>   of_syscon_register_regmap, but this cannot be undone -- which needs to happen
>   on PWM device unbind (the RP1 PWM device is itself platform device, but RP1
>   chip itself is PCIe device which must be removable).
> 
> - The tachometer register is not its own separate register, but rather (re)using
>   the phase control register. The phase control is not implemented in the RP1
>   PWM driver on the list yet, so this is currently a simple register read -- I
>   can see that RP1 PWM driver need to take special care to about the tachometer
>   reading if the phase control is implemented.
> 
>   For the two reasons above, I think the way that tachometer is read should
>   really be an implementation detail of the PWM driver and not for the hwmon
>   driver to worry about, so I suggested using EXPORT_SYMBOL_NS.
> 
> - EXPORT_SYMBOL_NS is the documented way for exposing functionality from parent
>   device to auxiliary drivers: https://docs.kernel.org/driver-api/auxiliary_bus.html
> 

Let's agree to disagree, and keep the code in the pwm subsystem.

Thanks,
Guenter
