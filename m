Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795887766;
	b=G0HufPcDc4MeVyHGTuVDH8akCzwgQ3wRUrmOydjghetyu/WEjGJyxCzRPBtUw9F22YFY
	 rDT7jhWeSGqW8m0b+m10tOsQmgFnAnrYqFWmaGdKwvPplPbnNuZ5zHTHTBfH3j6a6swsW
	 oETaUoiBTII+ZMmjl9a9OW5JIKDB4OdKJqxV/R7Y57ePHsGZ1wivai/WkLAjbt2Wuvpkw
	 nr6/9rmFXTPjO7zxzYrNbwx7g6NJYcLPfFh/yB0V4/7hZ8LpvsJIFF7o7j/9FhfJq9oaw
	 caLhwvpA72u7if1JFAtZ8J7KfSDwMELgCTZOrfu5k6aAwAwUOMRh/epssyOZr/KpvnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795887766;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=3y8o5rf93bMJe/qkYCNtnd/Fwl4nGibxk4LovORGw/E=;
	b=rfxXqeXbDer1aK/fBwUT35t7KxwVrer/y1KSP8o9j53rfpDIXUknJheTQJLj05D+1hlf
	 3Voa2QqKkuFndZsffc/FID8WO44CdspudJjAYAoZij0hCRfMenAPCRql7thVinGEhKB31
	 VXIJEQ2gnwYP2b+fKfnPPhZMoFYET9OH0mIC++hLFTJNii4EDBtblys4jMAkOIFkOKHqo
	 dRkKG47L2ZqWANKEDR8Peok+Vk+2fNtRSOeZcG3JVZpsBW16wIZ+AMqvdRXKrOEA37zgg
	 OPuJMtVc9v6QMZJxVt16rJKW/gOLms0vZvtfxAAs7i6HyNnPdTGlwiB2QeI9vfQ5rbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=BIh0mmPW;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AAE606A321
	for <linux-pwm@vger.kernel.org>; Sat, 28 Nov 2026 17:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85AAE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=BIh0mmPW
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id X0EtxJ3OfVK9UXMRixgyKy; Sat, 28 Nov 2026 17:42:46 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id XMRhxa0wyb2qJXMRhxZIQg; Sat, 28 Nov 2026 17:42:45 +0000
X-Authority-Analysis: v=2.4 cv=A7tsP7WG c=1 sm=1 tr=0 ts=6b0b1295
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=iox4zFpeAAAA:8
 a=_jlGtV7tAAAA:8 a=jRv6SZqfwPPOu8Mw20sA:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3y8o5rf93bMJe/qkYCNtnd/Fwl4nGibxk4LovORGw/E=; b=BIh0mmPWzem1+G318kY6ef1+/C
	5uk5PLZ2CEJ4JdNo5ZctwpMXv7J9MustqxNy4nGePPVd0xm4MR6WvNczK9hkXsNSU7Fl7iCWTzf9A
	ThEDA+CVbScVR1yRp99K+n2Tvo7je1G+oRM6Ou5hHamTaaBdHXuH/4/m5QVF76EoSWYpFPp0FqsFr
	+ClhcrWiAg1lSWZhviYKCCDIOAXCtwQg/C0f+t8gD+5/UMvriIfGHHBGefK0QIkVCMbraRRWBtAuB
	TovO7mcJEtk+dzbozXZlzzCZLyNgBVQhMBpq2DoQPyn7ghDi2K8pBRafe3JlTpqyK+3ELx1KoHfL1
	wA0TUdoA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58802 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.2)
	(envelope-from <linux@roeck-us.net>)
	id 1xXMRh-000000007VH-0TSi;
	Sat, 28 Nov 2026 23:12:45 +0530
Date: Sat, 28 Nov 2026 09:42:44 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH v2 1/1] hwmon: Add driver for Raspberry Pi RP1 fan
 tachometer
Message-ID: <0d047acc-7921-4482-a130-9c630cf3f1eb@roeck-us.net>
References: <20261124173900.31266-1-andrea.porta@suse.com>
 <20261124173900.31266-2-andrea.porta@suse.com>
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
In-Reply-To: <20261124173900.31266-2-andrea.porta@suse.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xXMRh-000000007VH-0TSi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:58802
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 11
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA8onwYLSqxRoX0rl5oxMJZuMWuxu/0hFqyNZFQ9QfnH4J0Jdt3AcHPoLXHz1fuPrA+39Lfvq/GHClrcHHazC1coktwDp3BKgjKunoCSJW2o1M2gnMJ0
 pnpAlgvQqoVtFGAciXR/l+jHDA3Vs2Qvmr+xlPRUliCxBYsF+qvJIk57cw5vdlhtdW9liPPMZa47O9M43wPLmhzMmGkT5Uee+27YpanI84uKTTSBnm/EJ0Cz

On Tue, Nov 24, 2026 at 06:39:00PM +0100, Andrea della Porta wrote:
> Add a hardware monitoring driver to support the fan tachometer on the
> Raspberry Pi RP1 southbridge, found on the Raspberry Pi 5.
> 
> The RP1 PWM controller block contains an MMIO register that holds the
> current fan speed in RPM. This register is periodically updated by the
> RP1 internal firmware based on the tachometer pulses.
> 
> The RP1 PWM driver registers a "fan" auxiliary device for the
> tachometer. This driver binds to it as an auxiliary driver and reads
> the RPM value through rp1_pwm_read_tachometer(), exported by the PWM
> driver in the 'RP1_PWM' symbol namespace. Since the auxiliary device is
> a child of the PWM controller, no Device Tree node is needed and the
> lifetime of this driver is bound to the one of the PWM controller.
> 
> Provides the standard hwmon sysfs attribute 'fan1_input'.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I assume that the driver will be applied together with the changes introducing
rp1_pwm_read_tachometer().

Guenter
