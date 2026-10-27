Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108928;
	b=QF+x1XdfAkupMmv+UaYAmgc0aVaPE+yENTA/ciFjClboBsd4vlr/H1a/4tZrj3hdbiuW
	 /D4i1ZLrGMySGvcBVE1WSGI8xfL4lFSiH8rP28nLIJ16wJjA2jZu1PmQckqyRhRwH5z85
	 Whf+6AwbVSOLbH9898wyb714WvhztAP3Bg/zcG/EyY1GrW6JSSXJb/m/rjoDDCLqw5nba
	 wR8HM9w3r2i4U4JqSu12XqdxEWN87aIHmi9zihtgi2RNyJLutY1IVw9fkW4tz+B6luNFF
	 3Vmh2tjiMNSq45iD2vSZtTUuwks7gIgZbicChv5eqScKGVmJntrt8aO51H9v0rPeK8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108928;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:X-Source:
	 X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=xnmTt7xAHrUILK2F5tw9jpxyescs2qacR8TokbmgBtk=;
	b=hflbJIb9OpO49WGs1+dh6TTB/UVLQB9i65e4eHnTnTY1PYBtSyMzoViNWOL7IM4GUowG
	 pxciL/L9yyCP010IAgoQx10QHLrLvKJo7PpK9teQaVjnsCBCbLv5h4AhLfkEYs0KzWui4
	 JmRYhrvoWBfOBNvUd/GCG7FP/1qpum4CBgScqv5SIqRvmV6l6FIoAqVp/wNkals2Vqu8L
	 DK6IKUdFP7IiqgotImWrbRXm5Y/c9YfloxZZa2s6z6EKzZY0n6i4RlnXss7qu1HgC+PPZ
	 guoicm8QPjhgLJLrameCcA+0Y/dsgO3Jmb+nuL2egJdzVzbZuojLYf/zQxMPb0l5pDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=SpXCwzbR;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78F606A31D
	for <linux-pwm@vger.kernel.org>; Tue, 27 Oct 2026 13:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F78F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=SpXCwzbR
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id LeuQx7z4TLvgbLhXjxu6PC; Tue, 27 Oct 2026 13:48:47 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LhXixKFntp4IlLhXixLbvo; Tue, 27 Oct 2026 13:48:47 +0000
X-Authority-Analysis: v=2.4 cv=X59SKHTe c=1 sm=1 tr=0 ts=6ae0abbf
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=iox4zFpeAAAA:8 a=SGJkWrW82lNR26rtH8EA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=xnmTt7xAHrUILK2F5tw9jpxyescs2qacR8TokbmgBtk=; b=SpXCwzbRcHVw
	N2YxxPeLLeWmEdPesF9F/Tvwg3/Ur+cwc0BNs5PkwRihIB8ZMpHxkfenhxHZpiilczHaa4BtNtJ1l
	MQnh1TC5aAZMz+jcAA5b/5ruWpsHOZrFPKBcqgrpVB3caHvWBe1ZNul0by2cPjbo+g7bcc2QVh+57
	V6+/SqH5BLHSkzcWPPnOglmu2ivP6fkSwwKLoaDhSDx727CnyZj1Tp4091tI/+Uj6SFEuba4GhaTl
	igg3Fb3jjUNUqPtxHIgSUTYnREXjUpO4E5Wjps/Jf4KT2tqED6oeLR6WZpxmMaRsTbbMxiLK7yK0h
	Q6z0bqsN0q8zSZQDFgNCgQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:34878 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLhXf-00000003hnK-28cN;
	Tue, 27 Oct 2026 19:18:43 +0530
Date: Tue, 27 Oct 2026 06:48:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Gary Guo <gary@garyguo.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH RFC 0/4] hwmon: Add fan tachometer support for Raspberry
 Pi RP1
Message-ID: <53a4b4bb-271c-4d2d-a9e4-cec4e0ce214b@roeck-us.net>
References: <cover.1792748690.git.andrea.porta@suse.com>
 <7df58d42-517c-4936-88b0-9d044d30882c@roeck-us.net>
 <auBzvB8TsvIK8Hik@apocalypse>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auBzvB8TsvIK8Hik@apocalypse>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLhXf-00000003hnK-28cN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:34878
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGtWfMx4SB+ptxnQ9x1ly5Efm16NnL6vyWUycO7QVUJzR4S+dBe1NAvKJYDFrBRbwck4UpGJGrRsC9iWg5FYwQGXoo7VdyermppJmluvWFJo2j9eR5Dt
 dfDiR8xkTND8Na2eUI0bulB0U6pIFFFlq4NzW7oLpMHQs6rIx8FPFcAXR2woPql9o9XjdoRDa6lVhPOed0SIpeOPj8Wxu7sXjaYy8DBgQasVH+jxETGP4D4P

On Tue, Oct 27, 2026 at 10:49:48AM +0100, Andrea della Porta wrote:
> Hi Guenter,
> 
> On 09:24 Mon 26 Oct     , Guenter Roeck wrote:
> > On 10/23/26 03:15, Andrea della Porta wrote:
> > > Hi,
> > > 
> > > This patch series adds fan tachometer / RPM monitoring support for the
> > > Raspberry Pi RP1 southbridge found on the Raspberry Pi 5.
> > > Please note that the patchset in [1] is a prerequisite for this one.
> > > 
> > > On the Raspberry Pi RP1, the active cooling fan speed is controlled via
> > > the RP1 PWM controller. In addition to generating PWM signals, the RP1
> > > monitors fan tachometer pulses. The pulse measurement and RPM calculation
> > > are performed autonomously by the RP1's onboard Cortex-M microcontroller
> > > core, which periodically writes the computed RPM value directly into
> > > dedicated MMIO registers located within the RP1 PWM hardware block.
> > > 
> > > During earlier discussions, Uwe Kleine-König explicitly indicated a
> > > preference to keep the core PWM controller driver (drivers/pwm/pwm-rp1.c)
> > > focused strictly on PWM duties, rather than bloating it by registering an
> > > hwmon device directly from within the PWM driver (see [2]).
> > > 
> > > Because the Linux PWM subsystem currently lacks a generic framework or
> > > consumer API for reporting hardware-calculated tachometer readings, this
> > > series implements a standalone hwmon driver (rp1-fan) using the following
> > > structure:
> > > 
> > > -  The PWM driver exposes and exports rp1_pwm_read_tachometer() within a
> > >     dedicated symbol namespace ('RP1_PWM') to read the RPM value from
> > >     the MMIO block.
> > > -  A companion DT binding (raspberrypi,rp1-fan.yaml) introduces a vendor
> > >     property, 'raspberrypi,pwm-tachometer', to link the fan node to the
> > >     PWM controller node without overloading or abusing the standard 'pwms'
> > >     property.
> > > -  The rp1-fan hwmon driver parses this phandle, establishes a device link
> > >     for proper runtime and unbind dependency management, and registers the
> > >     standard hwmon 'fan1_input' sysfs attribute.
> > > 
> > > An alternative architectural approach to the DT phandle + exported helper
> > > method would be to model the tachometer as a child device using the
> > > auxiliary bus framework (drivers/base/auxiliary.c). In that model, the RP1
> > > PWM driver would instantiate an auxiliary device for the tachometer, and
> > > the hwmon driver would bind to that auxiliary bus device without requiring
> > > a separate DT node.
> > > 
> > > However, adopting the auxiliary bus would require a more significant
> > > rework and refactoring of the existing RP1 PWM driver.
> > > 
> > > I'd appreciate any feedback on whether the current companion driver with
> > > a dedicated DT property is acceptable, or if an auxiliary bus-based
> > > refactoring of the PWM driver is the preferred upstream path.
> > > 
> > > Patch Breakdown
> > > ---------------
> > > Patch 1: pwm: rp1: Export helper to read fan tachometer RPM
> > > Patch 2: dt-bindings: hwmon: Add Raspberry Pi RP1 fan binding
> > > Patch 3: hwmon: Add driver for Raspberry Pi RP1 fan tachometer
> > 
> > This seems conceptually wrong.
> > 
> > Have you considered implementing the hwmon driver as auxiliary driver
> > and accessing the register in question through regmap ?
> 
> Yes, I also proposed that in the cover letter because auxbus seems also a viable
> solution.
> 
> The current implementation is a consequence to the discussion about the companion
> PWM driver, from here (and the revisions that followed):
> 
> https://lore.kernel.org/all/cover.1775223441.git.andrea.porta@suse.com/
> 
> To give a short and hopefully coherent view of the decisions, here's a breakdown:
> 
> - first proposal: PWM driver + fan hwmon (to read the RPM), all in the same driver
> 
> - V2: Uwe preferred to split the PWM driver from the hwmon one, so the hwmon was
>   dropped from teh PWM driver in favor of a future (fan) driver. To accomplish this,
>   I moved from readl/writel to regmap + syscon.
> 
> - V8: Gary proposed to export a function to read the fan RPM as a viable
>   solution. As a result, the regmap/syscon was dropped as it was no longer needed
>   and the function has been exported from the PWM driver
> 
> - new patchset for fan driver: the now independent hwmon moodle just call the
>   exported function from thw PWM driver.
> 
> If the auxiliary bus is indeed the preferred approach, I'd like to ensure we are
> all aligned, as this would also require refactoring the PWM driver.
> 

Let's say it that way: If you don't want to implement the auxiliary driver,
and you insist using the exported function, I would prefer for you to go back
to the first solution. The one thing I really dislike is conceptually broken
code, and I consider the current approach broken. Your call, but the one thing
I won't accept is the code with the exported function.

Guenter
